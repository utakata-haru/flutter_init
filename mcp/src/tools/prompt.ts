import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import type { McpServer, RegisteredTool } from '@modelcontextprotocol/sdk/server/mcp.js';
import { z } from 'zod';

type PromptCache = Map<string, string>;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const promptsDirectory = path.join(__dirname, '..', 'prompts');

const promptSchema = z.object({
  name: z
    .string({ description: 'Prompt file name (without extension)' })
    .regex(/^[a-z0-9_-]+$/i, 'Prompt name must be alphanumeric with optional dashes/underscores'),
});

export function registerPromptTool(server: McpServer, promptDir: string = promptsDirectory): RegisteredTool {
  const cache: PromptCache = new Map();

  return server.registerTool(
    'flutter_init_prompt',
    {
      title: 'Flutter Init Prompt Loader',
      description: 'Load markdown guidance for the Flutter App Builder workflow.',
      inputSchema: promptSchema.shape,
    },
    async ({ name }) => {
      if (!cache.has(name)) {
        const filePath = path.join(promptDir, `${name}.md`);
        try {
          const content = await fs.readFile(filePath, 'utf8');
          cache.set(name, content);
        } catch {
          return {
            content: [
              {
                type: 'text',
                text: `Unable to read prompt file: ${filePath}`,
              },
            ],
            isError: true,
          };
        }
      }

      return {
        content: [
          {
            type: 'text',
            text: cache.get(name) ?? '',
          },
        ],
        structuredContent: {
          name,
          path: path.join(promptDir, `${name}.md`),
        },
      };
    },
  );
}
