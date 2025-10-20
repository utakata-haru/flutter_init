import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/streamableHttp.js';
import { Command } from 'commander';
import { registerShellTool } from './tools/shell.js';
import { registerPromptTool } from './tools/prompt.js';

async function main() {
  const program = new Command();

  program
    .name('flutter-init-mcp')
    .description('MCP server wrapping flutter_init project workflows')
    .option('--port <number>', 'Port to listen on', (value) => parseInt(value, 10), 3000)
    .option('--host <string>', 'Host to bind to', '127.0.0.1');

  program.parse(process.argv);
  const options = program.opts<{ port: number; host: string }>();

  const server = new McpServer({
    name: 'flutter-init-mcp',
    version: '1.0.0',
  });

  const registeredTools = [
    registerShellTool(server),
    registerPromptTool(server),
  ];

  const transport = new StreamableHTTPServerTransport({
    sessionIdGenerator: () => crypto.randomUUID(),
  });

  await server.connect(transport);

  console.log(`MCP server running on http://${options.host}:${options.port}`);

  const shutdown = async () => {
    for (const tool of registeredTools) {
      tool.disable();
    }

    await server.close();
    process.exit(0);
  };

  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}

main().catch((error) => {
  console.error('Failed to start MCP server:', error);
  process.exit(1);
});
