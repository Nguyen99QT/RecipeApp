# 🧪 Tests Directory

This directory contains test files and testing utilities for the Recipe App AI project.

## 📁 Test Files

### 🔌 API Tests
- **`test_api.js`** - Backend API endpoint testing and validation

### 🌐 Language Tests  
- **`test_language_detection.dart`** - Flutter language detection and internationalization testing

## 🎯 Testing Strategy

### Test Categories

#### Unit Tests
- **Individual function testing**
- **Component isolation testing**
- **Mock data validation**

#### Integration Tests
- **API endpoint integration**
- **Database connectivity**
- **External service integration**

#### End-to-End Tests
- **Complete user workflows**
- **Cross-platform functionality**
- **Performance validation**

## 🚀 Running Tests

### API Tests (Node.js)
```bash
# Navigate to project root
cd "Recipe App Admin Panel Source Code/Script"

# Install dependencies
npm install

# Run API tests
npm test

# Run specific test file
npm test test_api.js

# Run with coverage
npm run test:coverage
```

### Language Detection Tests (Flutter)
```bash
# Navigate to Flutter app
cd "Flutter Receipe App/recipe_app"

# Install dependencies
flutter pub get

# Run all tests
flutter test

# Run specific test file
flutter test test/test_language_detection.dart

# Run with coverage
flutter test --coverage
```

## 📋 Test File Descriptions

### `test_api.js`
**Purpose**: Validates backend API functionality  
**Coverage**:
- Authentication endpoints
- Recipe CRUD operations  
- AI integration endpoints
- User management APIs
- Error handling validation

**Usage**:
```bash
node test_api.js
```

**Test Scenarios**:
- Valid API requests and responses
- Authentication and authorization
- Data validation and sanitization
- Error handling and status codes
- Performance and response times

### `test_language_detection.dart`
**Purpose**: Tests language detection and internationalization  
**Coverage**:
- Language detection accuracy
- Vietnamese input handling
- UI text localization
- Language switching functionality

**Usage**:
```bash
flutter test test/test_language_detection.dart
```

**Test Scenarios**:
- Automatic language detection
- Manual language switching
- Text rendering in different languages
- Input method validation

## 🛠️ Test Configuration

### Environment Setup

#### API Testing Environment
```bash
# Test environment variables
TEST_DB_URI=mongodb://localhost:27017/recipeapp_test
TEST_API_URL=http://localhost:3000
TEST_TIMEOUT=30000
```

#### Flutter Testing Environment
```yaml
# pubspec.yaml test dependencies
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  integration_test:
    sdk: flutter
```

## 📊 Test Coverage

### Current Coverage Goals
- **Backend API**: 85% code coverage minimum
- **Flutter App**: 80% code coverage minimum
- **Integration Tests**: 90% critical path coverage

### Coverage Reports
```bash
# Generate API coverage report
npm run test:coverage

# Generate Flutter coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🔧 Writing New Tests

### Test File Naming Convention
- API tests: `test_[feature].js`
- Flutter tests: `test_[component]_test.dart`
- Integration tests: `integration_[workflow]_test.[ext]`

### Test Structure Template

#### API Test Template (JavaScript)
```javascript
const request = require('supertest');
const app = require('../app');

describe('API Feature Tests', () => {
  beforeEach(() => {
    // Setup test data
  });

  afterEach(() => {
    // Cleanup test data
  });

  test('should handle valid request', async () => {
    const response = await request(app)
      .post('/api/endpoint')
      .send(testData)
      .expect(200);
    
    expect(response.body).toMatchObject(expectedResponse);
  });
});
```

#### Flutter Test Template (Dart)
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/feature.dart';

void main() {
  group('Feature Tests', () {
    setUp(() {
      // Setup test environment
    });

    tearDown(() {
      // Cleanup after tests
    });

    testWidgets('should display correct content', (tester) async {
      await tester.pumpWidget(TestWidget());
      expect(find.text('Expected Text'), findsOneWidget);
    });
  });
}
```

## 🚨 Test Data Management

### Test Database
- **Separate test database** for isolation
- **Seed data scripts** for consistent testing
- **Automatic cleanup** after test runs

### Mock Data
- **API response mocks** for consistent testing
- **User data fixtures** for authentication tests
- **Recipe data samples** for content testing

## 📈 Continuous Integration

### Automated Testing
```yaml
# GitHub Actions workflow example
name: Test Suite
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm install
      - name: Run tests
        run: npm test
```

### Quality Gates
- **All tests must pass** before merge
- **Coverage thresholds** must be met
- **Performance benchmarks** must pass

## 🐛 Debugging Tests

### Common Issues
1. **Database connection failures**
   - Check test database configuration
   - Verify MongoDB service is running

2. **API timeout errors**
   - Increase timeout values in test configuration
   - Check network connectivity

3. **Flutter test widget errors**
   - Verify widget dependencies are properly mocked
   - Check test environment setup

### Debugging Commands
```bash
# Run tests in debug mode
npm test --inspect-brk

# Flutter tests with verbose output
flutter test --verbose

# Run single test for debugging
npm test -- --grep "specific test name"
```

## 📞 Support

For testing-related issues:
1. Review test logs and error messages
2. Check test environment configuration
3. Verify dependencies are installed correctly
4. Contact development team for complex issues

## 🔄 Test Maintenance

### Regular Tasks
- **Weekly**: Review and update test data
- **Monthly**: Optimize test performance
- **Release**: Full regression test suite
- **Quarterly**: Update testing frameworks and dependencies

### Best Practices
- Keep tests simple and focused
- Use descriptive test names
- Maintain test data integrity
- Regular cleanup of obsolete tests
