# Claude on Advanced SSH Addon
This repository outlines the steps to get Claude installed and working on the [hassio/addon-ssh](https://github.com/hassio-addons/app-ssh) (Advanced SSH & Web Terminal). 

Thank you to @jantimon for their fork of [ha-addon-ssh](https://github.com/jantimon/ha-addon-ssh) which has all this bundled in. I wanted to see if I could do it without relying on a fork of the SSH addon

By installing claude on that container, we can then use VSCode on a remmote computer to connect to home assistant via SSH to provide access to the files itself, as well as Claude.

Additionally, I used [The Unofficial and Awesome Home Assistant MCP Server](https://github.com/homeassistant-ai/ha-mcp?tab=readme-ov-file) to provide access to Home Assistant to Claude.

By setting Claude up with access to both the filesystem and the MCP server, it can do anything you'd like to your home assistant install.


## Steps
1. Install [hassio/addon-ssh](https://github.com/hassio-addons/app-ssh) and [The Unofficial and Awesome Home Assistant MCP Server](https://github.com/homeassistant-ai/ha-mcp?tab=readme-ov-file)
2. In the configuration for `app-ssh`:  
```
packages:
  - npm
  - nodejs
init_commands:
  - npm install -g @anthropic-ai/claude-code
  - ln -s /addon_configs/terminal/.claude /root/.claude
  - ln -s /addon_configs/terminal/CLAUDE.md /homeassistant/CLAUDE.md
  - "for f in /addon_configs/terminal/bin/*; do cp -n \"$f\" /usr/local/bin/ && chmod 755 \"/usr/local/bin/$(basename \"$f\")\"; done"
```
3. In the configuration for `ha-mcp`, disable the external port (delete it), as we will be talking to it over the docker network
4. Copy the `addon_configs/terminal` folder to the `/addon_configs` folder on Home Assistant. Use whatever method you want for this.
4. Restart the `app-ssh` addon and open a web terminal
5. Type claude and login to claude. Once logged in, exit claude.
6. Start the MCP Server. Grab the login url, and replace the home-assistant-ip with `81f33d0f-ha-mcp`. Enter the command on the `app-ssh` terminal (should look like `claude mcp add --transport http home-assistant http://81f33d0f-ha-mcp:9583/<your token here>`
7. Connect to your HA instance with VSCode on your desktop/laptop via "Remote Connection", selecting SSH. Install the Claude extension to VSCode, and it should start working!

### Troubleshooting notes
1. I had difficulties running this on a machine with 4GB of memory. I increased my VM memory to 6GB and problems went away.