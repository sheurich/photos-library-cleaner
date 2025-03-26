import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif


print("Photos Library Cleaner")
print("=====================")

let cleaner = PhotosLibraryCleaner()
print("Running on \(cleaner.getPlatformName())")

let duplicates = cleaner.findDuplicatePhotos(count: 5)
print("Found \(duplicates.count) duplicate photos:")
for photo in duplicates {
    print("- \(photo)")
}

print("\nTo use the full app with UI, build and run the app target in Xcode.")
