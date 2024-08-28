## How to Use

1. **Navigate to Your Project Directory**
   Run the script from within the repository where you want to set up your Node.js server.

2. **Setup**  
   The script will:
   - Create the necessary JSON files for your project.
   - Install `express` and `nodemon` as dependencies.
   - Generate an empty `server.js` file to get you started.
   - Automatically add `"devStart": "nodemon server.js"` to package.json.
3. **Start the Server**  
   Use the following command to start the server in development mode:
   ```bash
   npm run devStart
