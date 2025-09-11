// Simple test using Node.js built-in modules
const http = require('http');
const url = require('url');

async function testReviewFilter(path, description) {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: 'localhost',
            port: 8190,
            path: path,
            method: 'GET'
        };

        const req = http.request(options, (res) => {
            let data = '';
            
            res.on('data', (chunk) => {
                data += chunk;
            });
            
            res.on('end', () => {
                console.log(`\n=== ${description} ===`);
                console.log(`URL: http://localhost:8190${path}`);
                console.log(`Status: ${res.statusCode}`);
                
                // Extract filter values from HTML
                const statusMatch = data.match(/currentStatusFilter === '([^']+)'/);
                const typeMatch = data.match(/currentTypeFilter === '([^']+)'/);
                
                // Extract stats
                const totalMatch = data.match(/Total: (\d+)/);
                const enabledMatch = data.match(/Enabled: (\d+)/);
                const disabledMatch = data.match(/Disabled: (\d+)/);
                const recipeMatch = data.match(/Recipe: (\d+)/);
                const appMatch = data.match(/App: (\d+)/);
                
                console.log(`Current Status Filter: ${statusMatch ? statusMatch[1] : 'not found'}`);
                console.log(`Current Type Filter: ${typeMatch ? typeMatch[1] : 'not found'}`);
                console.log(`Stats - Total: ${totalMatch ? totalMatch[1] : '?'}, Enabled: ${enabledMatch ? enabledMatch[1] : '?'}, Disabled: ${disabledMatch ? disabledMatch[1] : '?'}`);
                console.log(`Stats - Recipe: ${recipeMatch ? recipeMatch[1] : '?'}, App: ${appMatch ? appMatch[1] : '?'}`);
                
                resolve();
            });
        });

        req.on('error', (err) => {
            console.log(`\n=== ${description} ===`);
            console.log(`ERROR: ${err.message}`);
            resolve();
        });

        req.end();
    });
}

async function runTests() {
    console.log('🧪 Testing Review Filtering Functionality');
    
    const tests = [
        { path: '/admin/review', desc: 'All Reviews (Default)' },
        { path: '/admin/review?status=enabled', desc: 'Enabled Reviews Only' },
        { path: '/admin/review?status=disabled', desc: 'Disabled Reviews Only' },
        { path: '/admin/review?type=recipe', desc: 'Recipe Reviews Only' },
        { path: '/admin/review?type=app', desc: 'App Reviews Only' },
        { path: '/admin/review?status=enabled&type=recipe', desc: 'Enabled Recipe Reviews' },
        { path: '/admin/review?status=disabled&type=app', desc: 'Disabled App Reviews' }
    ];
    
    for (const test of tests) {
        await testReviewFilter(test.path, test.desc);
        await new Promise(resolve => setTimeout(resolve, 1000)); // Wait 1 second between tests
    }
    
    console.log('\n✅ Test completed!');
}

runTests().catch(console.error);
