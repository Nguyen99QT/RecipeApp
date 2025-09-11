const axios = require('axios');

async function testReviewFiltering() {
    const baseUrl = 'http://localhost:8190/admin/review';
    
    console.log('=== Testing Review Filtering ===\n');
    
    // Test cases
    const tests = [
        { name: 'All Reviews (no filter)', url: baseUrl },
        { name: 'Enabled Reviews Only', url: `${baseUrl}?status=enabled` },
        { name: 'Disabled Reviews Only', url: `${baseUrl}?status=disabled` },
        { name: 'Recipe Reviews Only', url: `${baseUrl}?type=recipe` },
        { name: 'App Reviews Only', url: `${baseUrl}?type=app` },
        { name: 'Enabled Recipe Reviews', url: `${baseUrl}?status=enabled&type=recipe` },
        { name: 'Disabled App Reviews', url: `${baseUrl}?status=disabled&type=app` }
    ];
    
    for (const test of tests) {
        try {
            console.log(`Testing: ${test.name}`);
            console.log(`URL: ${test.url}`);
            
            const response = await axios.get(test.url);
            
            // Extract filter values from response
            const statusMatch = response.data.match(/currentStatusFilter[^']*'([^']+)'/);
            const typeMatch = response.data.match(/currentTypeFilter[^']*'([^']+)'/);
            const statsMatch = response.data.match(/stats\.total[^>]*>(\d+)</);
            
            const currentStatus = statusMatch ? statusMatch[1] : 'not found';
            const currentType = typeMatch ? typeMatch[1] : 'not found';
            const totalCount = statsMatch ? statsMatch[1] : 'not found';
            
            console.log(`✓ Response received (status: ${response.status})`);
            console.log(`  Current Status Filter: ${currentStatus}`);
            console.log(`  Current Type Filter: ${currentType}`);
            console.log(`  Total Count: ${totalCount}`);
            console.log('---');
            
        } catch (error) {
            console.log(`✗ Failed: ${error.message}`);
            console.log('---');
        }
    }
}

// Run tests
testReviewFiltering().catch(console.error);
