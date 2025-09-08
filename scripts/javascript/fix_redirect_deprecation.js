const fs = require('fs');
const path = require('path');

// Read the loginController.js file
const filePath = path.join(__dirname, 'Recipe App Admin Panel Source Code', 'Script', 'controllers', 'loginController.js');
let content = fs.readFileSync(filePath, 'utf8');

// Replace all instances of res.redirect('back') with the secure alternative
content = content.replace(/res\.redirect\('back'\)/g, "res.redirect(req.get('Referrer') || '/')");

// Write the file back
fs.writeFileSync(filePath, content, 'utf8');

console.log('Successfully fixed all Express redirect deprecation warnings in loginController.js');
