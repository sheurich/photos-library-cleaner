import SwiftUI
import Photos

struct ContentView: View {
    @EnvironmentObject private var permissionManager: PhotoLibraryPermissionManager
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        NavigationView {
            Group {
                if permissionManager.authorizationStatus == .authorized {
                    DashboardView()
                        .environmentObject(coordinator)
                } else {
                    PermissionView(permissionManager: permissionManager)
                }
            }
            .navigationTitle("Photos Library Cleaner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PhotoLibraryPermissionManager())
    }
}
