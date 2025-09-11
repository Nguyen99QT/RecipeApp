"use strict";

function testFilterRecipeAPI() {
  var response, data;
  return regeneratorRuntime.async(function testFilterRecipeAPI$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(fetch('http://172.16.2.199:8190/api/FilterRecipe', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              categoryId: '',
              cuisinesIdList: [],
              userId: ''
            })
          }));

        case 3:
          response = _context.sent;
          _context.next = 6;
          return regeneratorRuntime.awrap(response.json());

        case 6:
          data = _context.sent;
          console.log('FilterRecipe API Response:');
          console.log('Status:', data.status);
          console.log('Data length:', data.data ? data.data.length : 0);

          if (data.data && data.data.length > 0) {
            console.log('First recipe structure:');
            console.log('- _id:', data.data[0]._id);
            console.log('- name:', data.data[0].name);
            console.log('- categoryId:', data.data[0].categoryId);
            console.log('- cuisinesId:', data.data[0].cuisinesId);
            console.log('Keys:', Object.keys(data.data[0]));
          }

          _context.next = 16;
          break;

        case 13:
          _context.prev = 13;
          _context.t0 = _context["catch"](0);
          console.error('Error testing FilterRecipe API:', _context.t0.message);

        case 16:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 13]]);
}

testFilterRecipeAPI();