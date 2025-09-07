"use strict";

var http = require('http');

var baseURL = 'localhost:8190';

function makeRequest(path, data) {
  return new Promise(function (resolve, reject) {
    var postData = JSON.stringify(data);
    var options = {
      hostname: 'localhost',
      port: 8190,
      path: path,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      }
    };
    var req = http.request(options, function (res) {
      var body = '';
      res.on('data', function (chunk) {
        return body += chunk;
      });
      res.on('end', function () {
        try {
          resolve({
            status: res.statusCode,
            data: JSON.parse(body)
          });
        } catch (e) {
          resolve({
            status: res.statusCode,
            data: body
          });
        }
      });
    });
    req.on('error', reject);
    req.write(postData);
    req.end();
  });
}

function testFilterAPI() {
  var categoriesResponse, categories, cuisinesResponse, cuisines, filterByCategoryResponse, filterByCuisineResponse, filterByBothResponse;
  return regeneratorRuntime.async(function testFilterAPI$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          console.log('🧪 Testing Filter API...\n'); // Test 1: Get all categories

          console.log('1️⃣ Getting all categories...');
          _context.next = 5;
          return regeneratorRuntime.awrap(makeRequest('/api/getAllCategory', {}));

        case 5:
          categoriesResponse = _context.sent;
          console.log('✅ Categories response:', categoriesResponse.status);
          categories = categoriesResponse.data.data;
          console.log('📋 Categories found:', categories.length);

          if (categories.length > 0) {
            console.log('🏷️ First category:', categories[0].name, '(ID:', categories[0]._id + ')');
          } // Test 2: Get all cuisines  


          console.log('\n2️⃣ Getting all cuisines...');
          _context.next = 13;
          return regeneratorRuntime.awrap(makeRequest('/api/GetAllCuisines', {}));

        case 13:
          cuisinesResponse = _context.sent;
          console.log('✅ Cuisines response:', cuisinesResponse.status);
          cuisines = cuisinesResponse.data.data;
          console.log('🍜 Cuisines found:', cuisines.length);

          if (cuisines.length > 0) {
            console.log('🌍 First cuisine:', cuisines[0].name, '(ID:', cuisines[0]._id + ')');
          } // Test 3: Filter by category only


          if (!(categories.length > 0)) {
            _context.next = 25;
            break;
          }

          console.log('\n3️⃣ Testing filter by category...');
          _context.next = 22;
          return regeneratorRuntime.awrap(makeRequest('/api/FilterRecipe', {
            categoryId: categories[0]._id,
            cuisinesIdList: [],
            userId: ""
          }));

        case 22:
          filterByCategoryResponse = _context.sent;
          console.log('✅ Filter by category response:', filterByCategoryResponse.status);
          console.log('🍳 Recipes found for category "' + categories[0].name + '":', filterByCategoryResponse.data.data.length);

        case 25:
          if (!(cuisines.length > 0)) {
            _context.next = 32;
            break;
          }

          console.log('\n4️⃣ Testing filter by cuisine...');
          _context.next = 29;
          return regeneratorRuntime.awrap(makeRequest('/api/FilterRecipe', {
            categoryId: "",
            cuisinesIdList: [cuisines[0]._id],
            userId: ""
          }));

        case 29:
          filterByCuisineResponse = _context.sent;
          console.log('✅ Filter by cuisine response:', filterByCuisineResponse.status);
          console.log('🌍 Recipes found for cuisine "' + cuisines[0].name + '":', filterByCuisineResponse.data.data.length);

        case 32:
          if (!(categories.length > 0 && cuisines.length > 0)) {
            _context.next = 39;
            break;
          }

          console.log('\n5️⃣ Testing filter by both category and cuisine...');
          _context.next = 36;
          return regeneratorRuntime.awrap(makeRequest('/api/FilterRecipe', {
            categoryId: categories[0]._id,
            cuisinesIdList: [cuisines[0]._id],
            userId: ""
          }));

        case 36:
          filterByBothResponse = _context.sent;
          console.log('✅ Filter by both response:', filterByBothResponse.status);
          console.log('🎯 Recipes found for both "' + categories[0].name + '" + "' + cuisines[0].name + '":', filterByBothResponse.data.data.length);

        case 39:
          console.log('\n🎉 All filter tests completed!');
          _context.next = 45;
          break;

        case 42:
          _context.prev = 42;
          _context.t0 = _context["catch"](0);
          console.error('❌ Error testing filter API:', _context.t0.message);

        case 45:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 42]]);
}

testFilterAPI();