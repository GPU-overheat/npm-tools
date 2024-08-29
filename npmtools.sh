cat npmtools.sh
#!/bin/bash

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

display_help() {
    echo -e "${GREEN}Usage: ./npmtools.sh [server] [package1 package2 ...]${NC}"
    echo -e "${GREEN}Commands:${NC}"
    echo -e "  ${GREEN}server${NC}                  : Initialize a Node.js project and install Express and Nodemon."
    echo -e "  ${GREEN}[package1 package2 ...]${NC} : Install the specified npm packages."
    echo -e "  ${GREEN}help${NC}                    : Display this help message."
    exit 0
}

if [ "$1" == "help" ]; then
    display_help
fi

echo -e "${GREEN}Initializing Node.js project...${NC}"
if ! npm init -y; then
    echo -e "${RED}Error: Failed to initialize Node.js project.${NC}"
    exit 1
fi

if [ "$1" == "server" ]; then
    echo -e "${GREEN}Installing Express...${NC}"
    if ! npm install express; then
        echo -e "${RED}Error: Failed to install Express.${NC}"
        exit 1
    fi

    echo -e "${GREEN}Installing Nodemon...${NC}"
    if ! npm install --save-dev nodemon; then
        echo -e "${RED}Error: Failed to install Nodemon.${NC}"
        exit 1
    fi

if [ ! -f server.js ] || [ ! -s server.js ]; then
    echo -e "${GREEN}Creating server.js file...${NC}"
    if ! touch server.js; then
        echo -e "${RED}Error: Failed to create server.js.${NC}"
        exit 1
    fi

    echo -e "${GREEN}Writing to server.js...${NC}"
    echo 'const express = require("express");' > server.js
    echo 'const app = express();' >> server.js
    echo 'const port = 3000;' >> server.js
    echo 'app.get("/", (req, res) => res.send("Hello World!"));' >> server.js
    echo 'app.listen(port, () => console.log(`Listening on port ${port}!`));' >> server.js
else
    echo -e "${GREEN}server.js already exists and is not empty.${NC}"
fi

    echo -e "${GREEN}Adding 'devStart' script to package.json...${NC}"
    if ! jq '.scripts.devStart = "nodemon server.js"' package.json > raw.json || ! mv raw.json package.json; then
        echo -e "${RED}Error: Failed to update package.json.${NC}"
        exit 1
    fi
    shift
fi

for package in "$@"; do
    echo -e "${GREEN}Installing $package...${NC}"
    if ! npm install "$package"; then
        echo -e "${RED}Error: Failed to install $package.${NC}"
        rm package.json
        exit 1
    fi
done

echo -e "${GREEN}##########DONE!##########${NC}"