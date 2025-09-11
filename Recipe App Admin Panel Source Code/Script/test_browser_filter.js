// Test script to verify dropdown change functionality
console.log('🧪 Testing Review Filter Dropdown Changes');

// Wait for DOM to be ready
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM ready, testing filters...');
    
    // Check if elements exist
    const statusFilter = document.getElementById('statusFilter');
    const typeFilter = document.getElementById('typeFilter');
    
    if (statusFilter && typeFilter) {
        console.log('✅ Filter elements found');
        console.log('Current status filter:', statusFilter.value);
        console.log('Current type filter:', typeFilter.value);
        
        // Test event listeners
        console.log('🔄 Testing event listeners...');
        
        // Test status filter change
        console.log('Testing status filter change...');
        const originalStatus = statusFilter.value;
        
        // Mock a change event
        statusFilter.value = 'enabled';
        console.log('Changed status to:', statusFilter.value);
        
        // Create and dispatch change event
        const changeEvent = new Event('change', { bubbles: true });
        statusFilter.dispatchEvent(changeEvent);
        console.log('✅ Status change event dispatched');
        
        // Test type filter change
        setTimeout(() => {
            console.log('Testing type filter change...');
            const originalType = typeFilter.value;
            
            typeFilter.value = 'recipe';
            console.log('Changed type to:', typeFilter.value);
            
            const typeChangeEvent = new Event('change', { bubbles: true });
            typeFilter.dispatchEvent(typeChangeEvent);
            console.log('✅ Type change event dispatched');
        }, 2000);
        
    } else {
        console.log('❌ Filter elements not found');
        console.log('StatusFilter:', statusFilter);
        console.log('TypeFilter:', typeFilter);
        
        // Check if elements exist in DOM
        console.log('All select elements:', document.querySelectorAll('select'));
        console.log('Elements with statusFilter id:', document.querySelectorAll('#statusFilter'));
        console.log('Elements with typeFilter id:', document.querySelectorAll('#typeFilter'));
    }
});

// Also run immediately in case DOM is already loaded
if (document.readyState === 'loading') {
    console.log('DOM still loading, waiting...');
} else {
    console.log('DOM already loaded, running tests immediately...');
    // Run the test code here too
}
