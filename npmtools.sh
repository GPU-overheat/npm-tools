#!/bin/bash

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Initializing Node.js project...${NC}"
if ! npm init -y; then
    echo -e "${RED}Error: Failed to initialize Node.js project.${NC}"
    exit 1
fi

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

echo -e "${GREEN}Creating server.js file...${NC}"
if ! touch server.js; then
    echo -e "${RED}Error: Failed to create server.js.${NC}"
    exit 1
fi

echo -e "${GREEN}Adding 'devStart' script to package.json...${NC}"
if ! jq '.scripts.devStart = "nodemon server.js"' package.json > tmp.json || ! mv tmp.json package.json; then
    echo -e "${RED}Error: Failed to update package.json.${NC}"
    exit 1
fi


