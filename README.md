# Playwright MCP Server

A containerized Playwright Model Context Protocol (MCP) server with the official Google Chrome binary pre-installed. This setup is designed for LLM agents to perform web navigation and interaction via Server-Sent Events (SSE).

## Docker Image

The pre-built image is available on Docker Hub:
* **Image:** `docker.io/frenoid/playwright-mcp:v1.58.2-noble-amd64-v1`
* **Tags:** [hub.docker.com/r/frenoid/playwright-mcp/tags](https://hub.docker.com/r/frenoid/playwright-mcp/tags)

## Deployment

Run the container using the following command. Note that `--no-sandbox` is required for execution within the container environment.

```bash
docker run -d \
  --name playwright-mcp \
  --ipc=host \
  --restart always \
  -p 3000:3000 \
  -v /data/playwright-mcp/output:/output \
  --env=PLAYWRIGHT_MCP_ALLOWED_HOSTNAMES=* \
  --env=PLAYWRIGHT_MCP_HOST=0.0.0.0 \
  --env=PLAYWRIGHT_MCP_OUTPUT_DIR=/output \
  frenoid/playwright-mcp:v1.58.2-noble-amd64-v1 --no-sandbox

Parameters
1. --ipc=host: Required to prevent Chrome memory crashes.
2. --no-sandbox: Required for Chrome to launch inside the container.
3. PLAYWRIGHT_MCP_OUTPUT_DIR: Path where the server saves screenshots or files.

## Agent Configuration
To connect an AI agent, use the following server configuration:

### Cursor or Claude Desktop
```json
{
  "mcpServers": {
    "playwright": {
      "url": "http://<SERVER_IP>:3000/sse",
      "type": "sse"
    }
  }
}
```
### Claude Code (CLI)
```bash
claude mcp add playwright -- http://<SERVER_IP>:3000/sse
```

## To build the image locally
To build the image locally from the provided Dockerfile:
```bash
docker build . -t playwright-mcp:local
```
