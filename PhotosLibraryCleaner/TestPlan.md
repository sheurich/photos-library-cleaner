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
   - Verify the dashboard view loads correctly

2. **Asset Management**
   - Test moving a photo to Recently Deleted
   - Verify the photo appears in the Recently Deleted album
   - Verify no permanent deletions occur

3. **Asset Metadata**
   - Verify the app can retrieve and display asset metadata
   - Check that creation dates, locations, and other metadata are correctly displayed

### UI Tests

1. **Cross-Platform Compatibility**
   - Test the app on both iOS and macOS
   - Verify UI elements adapt correctly to each platform
   - Verify platform-specific code (Settings access) works correctly

2. **Dashboard View**
   - Verify the scan progress indicator works
   - Test the scan results display
   - Verify all UI elements are properly laid out

## Automated Testing

The following automated tests should be implemented using Xcode and run in GitHub Actions:

### Unit Tests

1. **Permission Manager Tests**
   - Test authorization status updates
   - Test permission request handling

2. **PhotoKit Integration Tests**
   - Test asset fetching
   - Test asset metadata extraction
   - Test moving assets to Recently Deleted

3. **ML Analysis Tests**
   - Test basic analysis functionality
   - Test result processing

### UI Tests

1. **Permission Flow Tests**
   - Test permission request flow
   - Test denied permission handling

2. **Dashboard Tests**
   - Test scan initiation
   - Test results display

## CI Integration with GitHub Actions

GitHub Actions with macOS runners will be used to automate testing and deployment:

1. **Build Verification**
   - Verify the app builds successfully for both iOS and macOS
   - Run on every pull request and push to main branch

2. **Unit Test Suite**
   - Run all unit tests using Xcode on macOS runners
   - Generate test coverage reports
   - Fail the build if tests fail

3. **UI Test Suite**
   - Run UI tests on iOS and macOS simulators
   - Capture screenshots for visual verification
   - Fail the build if tests fail

4. **Code Quality Checks**
   - Run SwiftLint for code style verification
   - Enforce code quality standards
   - Generate reports for code quality metrics
