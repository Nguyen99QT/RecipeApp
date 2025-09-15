// Test simple HTTP server để kiểm tra
const http = require('http');

const server = http.createServer((req, res) => {
    console.log('Request received:', req.method, req.url);
    
    if (req.method === 'GET' && req.url === '/') {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`
            <html>
            <body>
                <h2>Admin Login Test</h2>
                <form method="POST" action="/">
                    <div>
                        <label>Email:</label>
                        <input type="email" name="email" value="admin@recipe.com" required>
                    </div>
                    <div>
                        <label>Password:</label>
                        <input type="password" name="password" value="admin123" required>
                    </div>
                    <button type="submit">Login</button>
                </form>
            </body>
            </html>
        `);
    } else if (req.method === 'POST' && req.url === '/') {
        let body = '';
        req.on('data', chunk => {
            body += chunk.toString();
        });
        
        req.on('end', () => {
            console.log('POST body received:', body);
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(`
                <html>
                <body>
                    <h2>Login Received</h2>
                    <p>Data: ${body}</p>
                    <p>Now test với main admin panel!</p>
                    <a href="http://localhost:8190">Go to Admin Panel</a>
                </body>
                </html>
            `);
        });
    } else {
        res.writeHead(404);
        res.end('Not found');
    }
});

server.listen(3000, () => {
    console.log('Test server running on http://localhost:3000');
    console.log('Use this to test form submission format');
});
