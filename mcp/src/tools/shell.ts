import { basename, join, dirname } from 'node:path';
import { spawn } from 'node:child_process';
import { access } from 'node:fs/promises';
import { constants as fsConstants } from 'node:fs';
import { fileURLToPath } from 'node:url';
import type { McpServer, RegisteredTool } from '@modelcontextprotocol/sdk/server/mcp.js';
import { z } from 'zod';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

type ScriptDescriptor = {
  id: string;
  description: string;
  bash: string;
  ps1: string;
};

const projectRoot = join(__dirname, '..', '..', '..');
const scriptDir = join(projectRoot, 'AI', 'scripts');

const scriptSchema = z.object({
  script: z.enum(['init-project', 'add-deps', 'generate-core', 'init-core-exceptions', 'generate-feature']),
  args: z.array(z.string()).default([]),
});

const scriptDetails = {
  'init-project': {
    description: 'Initialise Flutter project using AI/scripts/bash/init_project.sh',
    bash: join(scriptDir, 'bash', 'init_project.sh'),
    ps1: join(scriptDir, 'powershell', 'init_project.ps1'),
  },
  'add-deps': {
    description: 'Install recommended dependencies',
    bash: join(scriptDir, 'bash', 'add_dependencies.sh'),
    ps1: join(scriptDir, 'powershell', 'add_dependencies.ps1'),
  },
  'generate-core': {
    description: 'Generate lib/core directory structure',
    bash: join(scriptDir, 'bash', 'generate_core.sh'),
    ps1: join(scriptDir, 'powershell', 'generate_core.ps1'),
  },
  'init-core-exceptions': {
    description: 'Create core exceptions scaffolding',
    bash: join(scriptDir, 'bash', 'init_core_exceptions.sh'),
    ps1: join(scriptDir, 'powershell', 'init_core_exceptions.ps1'),
  },
  'generate-feature': {
    description: 'Generate feature folder structure',
    bash: join(scriptDir, 'bash', 'generate_feature.sh'),
    ps1: join(scriptDir, 'powershell', 'generate_feature.ps1'),
  },
} satisfies Record<(typeof scriptSchema)['shape']['script']['_def']['values'][number], { description: string; bash: string; ps1: string }>;

async function isExecutable(path: string): Promise<boolean> {
  try {
    if (process.platform === 'win32') {
      await access(path);
      return true;
    }

    await access(path, fsConstants.X_OK);
    return true;
  } catch {
    return false;
  }
}

async function runCommand(command: string, args: string[]): Promise<{ exitCode: number; stdout: string; stderr: string }> {
  return await new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      cwd: projectRoot,
      env: process.env,
      shell: process.platform === 'win32',
    });

    let stdout = '';
    let stderr = '';

    child.stdout?.on('data', (data: Buffer) => {
      stdout += data.toString();
    });

    child.stderr?.on('data', (data: Buffer) => {
      stderr += data.toString();
    });

    child.on('close', (code: number | null) => {
      resolve({
        exitCode: code ?? 0,
        stdout,
        stderr,
      });
    });

    child.on('error', (error: Error) => {
      reject(error);
    });
  });
}

function formatOutput(details: { script: string; command: string; exitCode: number; stdout: string; stderr: string }): string {
  const lines = [
    `Script: ${details.script}`,
    `Command: ${details.command}`,
    `Exit code: ${details.exitCode}`,
  ];

  if (details.stdout.trim().length > 0) {
    lines.push(`stdout:\n${details.stdout.trim()}`);
  }

  if (details.stderr.trim().length > 0) {
    lines.push(`stderr:\n${details.stderr.trim()}`);
  }

  return lines.join('\n\n');
}

export function registerShellTool(server: McpServer): RegisteredTool {
  return server.registerTool(
    'flutter_init_shell',
    {
      title: 'Flutter Init Script Runner',
      description: 'Execute bundled flutter_init helper scripts (Bash / PowerShell).',
      inputSchema: scriptSchema.shape,
    },
    async ({ script, args }) => {
      const descriptor = scriptDetails[script];
      if (!descriptor) {
        return {
          content: [
            {
              type: 'text',
              text: `Unknown script: ${script}`,
            },
          ],
          isError: true,
        };
      }

      const preferPowerShell = process.platform === 'win32';
      const commandPath = preferPowerShell ? descriptor.ps1 : descriptor.bash;

      if (!(await isExecutable(commandPath))) {
        return {
          content: [
            {
              type: 'text',
              text: `Script is not executable: ${commandPath}`,
            },
          ],
          isError: true,
        };
      }

      const executable = preferPowerShell ? 'pwsh' : commandPath;
      const spawnArgs = preferPowerShell ? [commandPath, ...args] : args;

      try {
        const { exitCode, stdout, stderr } = await runCommand(executable, spawnArgs);

        return {
          content: [
            {
              type: 'text',
              text: formatOutput({
                script,
                command: basename(commandPath),
                exitCode,
                stdout,
                stderr,
              }),
            },
          ],
          structuredContent: {
            script,
            command: basename(commandPath),
            exitCode,
            stdout,
            stderr,
          },
        };
      } catch (error) {
        return {
          content: [
            {
              type: 'text',
              text: error instanceof Error ? error.message : String(error),
            },
          ],
          isError: true,
        };
      }
    },
  );
}
