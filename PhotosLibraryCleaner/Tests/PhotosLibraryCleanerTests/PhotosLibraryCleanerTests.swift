import XCTest
@testable import PhotosLibraryCleaner

final class PhotosLibraryCleanerTests: XCTestCase {
    func testPlatformName() {
        let cleaner = PhotosLibraryCleaner()
        
        #if os(iOS)
        XCTAssertEqual(cleaner.getPlatformName(), "iOS")
        #elseif os(macOS)
        XCTAssertEqual(cleaner.getPlatformName(), "macOS")
        #else
        XCTFail("Unknown platform")
        #endif
    }
    
    func testFindDuplicatePhotos() {
        let cleaner = PhotosLibraryCleaner()
        let duplicates = cleaner.findDuplicatePhotos(count: 3)
        
        XCTAssertEqual(duplicates.count, 3)
        XCTAssertEqual(duplicates[0], "Photo_1")
        XCTAssertEqual(duplicates[1], "Photo_2")
        XCTAssertEqual(duplicates[2], "Photo_3")
    }
}
