# Photos Library Cleaner

A native macOS/iOS application that helps you clean up and organize your Apple Photos library.

## Features

- Delete blurry photos
- Delete low-quality/bad photos and videos
- Remove redundant and duplicate media
- Coalesce similar shots into one or two best selections
- Identify and remove temporary task-related photos/videos
- Organize the remaining photos into events with appropriate labels and dates

## Implementation

- Uses PhotoKit for accessing and modifying the photo library
- Implements ML-based analysis for detecting blur, duplicates, and more
- Provides a user-friendly interface for reviewing and confirming changes
- Ensures all deletions are non-destructive (using Photos "Recently Deleted" feature)

## Getting Started

1. Clone the repository
2. Open the Xcode project
3. Build and run on your device or simulator

## Requirements

- iOS 15.0+ / macOS 12.0+
- Xcode 13.0+
- Swift 5.5+

## License

This project is licensed under the MIT License - see the LICENSE file for details.
