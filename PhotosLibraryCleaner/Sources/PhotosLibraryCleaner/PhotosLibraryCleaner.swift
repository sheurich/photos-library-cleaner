import Foundation
import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public class PhotosLibraryCleaner {
    public init() {
        print("PhotosLibraryCleaner initialized")
    }
    
    public func getPlatformName() -> String {
        #if os(iOS)
        return "iOS"
        #elseif os(macOS)
        return "macOS"
        #else
        return "Unknown"
        #endif
    }
    
    public func findDuplicatePhotos(count: Int) -> [String] {
        return (1...count).map { "Photo_\($0)" }
    }
}

public struct PhotosLibraryCleanerView: View {
    private let cleaner = PhotosLibraryCleaner()
    @State private var duplicateCount = 5
    @State private var duplicates: [String] = []
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Photos Library Cleaner")
                .font(.largeTitle)
            
            Text("Running on \(cleaner.getPlatformName())")
                .font(.headline)
            
            Stepper("Number of duplicates: \(duplicateCount)", value: $duplicateCount, in: 0...20)
                .padding()
            
            Button("Find Duplicates") {
                duplicates = cleaner.findDuplicatePhotos(count: duplicateCount)
            }
            .buttonStyle(.borderedProminent)
            
            if !duplicates.isEmpty {
                List(duplicates, id: \.self) { photo in
                    Text(photo)
                }
                .frame(height: 200)
            }
        }
        .padding()
        .frame(width: 400, height: 500)
    }
}
