# Photos Library Cleaner

A Swift package that provides functionality for cleaning and organizing photo libraries on iOS and macOS.

## Features

- Cross-platform support for iOS and macOS
- Example implementation of duplicate photo detection
- SwiftUI interface that works on both platforms

## Requirements

- iOS 15.0+ / macOS 12.0+
- Swift 5.5+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/sheurich/photos-library-cleaner.git", from: "0.1.0")
]
```

## Usage

```swift
import PhotosLibraryCleaner

// Initialize the cleaner
let cleaner = PhotosLibraryCleaner()

// Get the current platform
let platform = cleaner.getPlatformName()
print("Running on \(platform)")

// Find duplicate photos
let duplicates = cleaner.findDuplicatePhotos(count: 5)
print("Found \(duplicates.count) duplicate photos")
```

## SwiftUI Example

```swift
import SwiftUI
import PhotosLibraryCleaner

struct ContentView: View {
    var body: some View {
        PhotosLibraryCleanerView()
    }
}
```
