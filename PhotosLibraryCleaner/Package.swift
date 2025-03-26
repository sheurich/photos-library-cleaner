import PackageDescription

let package = Package(
    name: "PhotosLibraryCleaner",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "PhotosLibraryCleaner",
            targets: ["PhotosLibraryCleaner"]),
        .executable(
            name: "PhotosLibraryCleanerApp",
            targets: ["PhotosLibraryCleaner"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PhotosLibraryCleaner",
            dependencies: []),
        .testTarget(
            name: "PhotosLibraryCleanerTests",
            dependencies: ["PhotosLibraryCleaner"]),
    ]
)
