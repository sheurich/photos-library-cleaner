import SwiftUI
import Photos

struct ContentView: View {
    @StateObject private var photoLibrary = PhotoLibrary()
    
    var body: some View {
        NavigationView {
            if photoLibrary.authorizationStatus == .authorized {
                PhotoCollectionView(photoCollection: photoLibrary.photoCollection)
                    .navigationTitle("Photos Library Cleaner")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                photoLibrary.loadPhotos()
                            }) {
                                Label("Refresh", systemImage: "arrow.clockwise")
                            }
                        }
                    }
            } else {
                PermissionView(photoLibrary: photoLibrary)
            }
        }
    }
}
