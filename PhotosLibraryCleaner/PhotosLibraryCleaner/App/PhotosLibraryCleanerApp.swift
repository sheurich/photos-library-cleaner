import SwiftUI
import Photos

@main
struct PhotosLibraryCleanerApp: App {
    @StateObject private var permissionManager = PhotoLibraryPermissionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(permissionManager)
        }
    }
}
