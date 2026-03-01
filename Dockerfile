FROM mcr.microsoft.com/playwright:v1.58.2-noble-amd64

# Install Node.js dependencies
RUN npm install -g @playwright/mcp

# This downloads the official Google Chrome .deb and installs dependencies
RUN npx playwright install chrome

# Expose the port for SSE (Server-Sent Events)
EXPOSE 3000

# Start the MCP server in SSE mode
# Replace '0.0.0.0' with your server's IP if needed
ENTRYPOINT ["npx", "-y", "@playwright/mcp", "--port", "3000", "--host", "0.0.0.0" ]
