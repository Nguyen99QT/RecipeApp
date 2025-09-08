# 🔧 Scripts Directory

This directory contains utility scripts for development, maintenance, and automation tasks.

## 📁 Directory Structure

### 💻 PowerShell Scripts (`powershell/`)
Automation scripts for Windows development environment:

- **`check_parentheses.ps1`** - Validates code syntax and parentheses matching
- **`fix_api_calls.ps1`** - Corrects API endpoint calls and formats
- **`fix_api_parsing.ps1`** - Fixes API response parsing issues
- **`fix_parentheses.ps1`** - Automatically corrects parentheses syntax errors
- **`fix_row_syntax.ps1`** - Fixes row syntax issues in code files

### 🟨 JavaScript Scripts (`javascript/`)
Node.js utility scripts for various tasks:

- **`fix_redirect_deprecation.js`** - Updates deprecated redirect handling in the application

## 🚀 Usage Instructions

### PowerShell Scripts

#### Prerequisites
- Windows PowerShell 5.1 or PowerShell Core 7.0+
- Execution policy set to allow script execution:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

#### Running Scripts
```powershell
# Navigate to the scripts directory
cd scripts/powershell

# Run a specific script
.\check_parentheses.ps1

# Run with parameters (if applicable)
.\fix_api_calls.ps1 -FilePath "path/to/file"
```

### JavaScript Scripts

#### Prerequisites
- Node.js 18.0 or higher
- Required npm packages (install with `npm install`)

#### Running Scripts
```bash
# Navigate to the scripts directory
cd scripts/javascript

# Run a script
node fix_redirect_deprecation.js

# Run with Node.js arguments
node --inspect fix_redirect_deprecation.js
```

## 📋 Script Descriptions

### `check_parentheses.ps1`
**Purpose**: Validates parentheses matching in code files  
**Usage**: Ensures code syntax integrity before commits  
**Input**: Code files (various formats)  
**Output**: Validation report with error locations  

### `fix_api_calls.ps1`
**Purpose**: Automatically corrects API endpoint formatting  
**Usage**: Standardizes API calls across the application  
**Input**: JavaScript/Dart files with API calls  
**Output**: Corrected files with proper API formatting  

### `fix_api_parsing.ps1`
**Purpose**: Fixes API response parsing issues  
**Usage**: Resolves JSON parsing and data handling problems  
**Input**: Files with API response handling  
**Output**: Updated files with correct parsing logic  

### `fix_parentheses.ps1`
**Purpose**: Automatically fixes parentheses syntax errors  
**Usage**: Corrects common syntax issues in batch  
**Input**: Source code files  
**Output**: Syntax-corrected files  

### `fix_row_syntax.ps1`
**Purpose**: Fixes row-related syntax issues  
**Usage**: Corrects table row and data structure syntax  
**Input**: Files with row/table definitions  
**Output**: Properly formatted structure files  

### `fix_redirect_deprecation.js`
**Purpose**: Updates deprecated redirect handling  
**Usage**: Modernizes redirect logic in web applications  
**Input**: JavaScript files with redirect functions  
**Output**: Updated files with current redirect methods  

## 🛠️ Development Guidelines

### Adding New Scripts

1. **Choose appropriate directory** (powershell/ or javascript/)
2. **Follow naming convention**: `action_target.extension`
3. **Include documentation** at the top of each script
4. **Add error handling** for robust execution
5. **Update this README** with script description

### Script Standards

#### PowerShell Scripts
```powershell
<#
.SYNOPSIS
    Brief description of the script
    
.DESCRIPTION
    Detailed description of what the script does
    
.PARAMETER FilePath
    Description of parameters
    
.EXAMPLE
    .\script.ps1 -FilePath "example.txt"
    
.NOTES
    Author: Recipe App Team
    Date: Creation date
#>
```

#### JavaScript Scripts
```javascript
/**
 * Script Name: script_name.js
 * Purpose: Description of what the script does
 * Author: Recipe App Team
 * Date: Creation date
 * 
 * Usage: node script_name.js [arguments]
 * 
 * Dependencies:
 * - Node.js 18+
 * - Required npm packages
 */
```

## 🔄 Maintenance

### Regular Tasks
- **Monthly**: Review and update scripts for compatibility
- **Release**: Test all scripts before major releases
- **Quarterly**: Optimize script performance and add new utilities

### Version Control
- All scripts are version controlled with the main project
- Use descriptive commit messages for script changes
- Tag major script updates for easy rollback

## 📞 Support

For script-related issues:
1. Check script documentation and comments
2. Review error messages and logs
3. Contact the development team if issues persist
4. Create GitHub issues for script bugs or enhancement requests

## 🧪 Testing Scripts

### Before Using Scripts
```powershell
# Test PowerShell scripts in safe mode
.\script.ps1 -WhatIf

# Backup important files before running fix scripts
Copy-Item "source" "source.backup"
```

```bash
# Test JavaScript scripts with sample data
node script.js --test-mode

# Verify output before applying to production files
```

## 📈 Script Performance

### Optimization Guidelines
- **Batch operations** when possible
- **Progress indicators** for long-running scripts
- **Logging** for troubleshooting
- **Error recovery** mechanisms

### Monitoring
- Script execution time tracking
- Success/failure rate monitoring
- Resource usage optimization
