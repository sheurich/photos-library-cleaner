# Photos Library Cleaner Test Plan

This document outlines the testing approach for the Photos Library Cleaner app.

## Manual Testing

The following manual tests should be performed during development:

### Permission Handling Tests

1. **First Launch Permission Request**
   - Launch the app for the first time
   - Verify the permission request dialog appears
   - Grant permission and verify the app transitions to the main view
   - Deny permission and verify the app shows the denied state UI

2. **Permission Denied State**
   - Launch the app with photo library permissions previously denied
   - Verify the app shows instructions to enable permissions in Settings
   - Verify the "Open Settings" button works correctly

### PhotoKit Integration Tests

1. **Photo Library Access**
   - Grant permissions to the app
   - Verify the app can access the photo library
   - Verify photos are displayed correctly

2. **Asset Management**
   - Test selecting and moving photos to Recently Deleted
   - Verify the photos appear in the Recently Deleted album
   - Verify no permanent deletions occur

## Automated Testing with GitHub Actions

GitHub Actions with macOS runners will be used to automate testing:

1. **Build Verification**
   - Verify the app builds successfully for both iOS and macOS
   - Run on every pull request and push to main branch

2. **Unit Test Suite**
   - Run all unit tests using Xcode on macOS runners
   - Generate test coverage reports
   - Fail the build if tests fail

3. **Code Quality Checks**
   - Run SwiftLint for code style verification
   - Enforce code quality standards
   - Generate reports for code quality metrics
