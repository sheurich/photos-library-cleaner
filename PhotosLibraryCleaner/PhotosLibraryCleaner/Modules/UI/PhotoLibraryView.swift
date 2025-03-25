import SwiftUI
import Photos

struct PhotoLibraryView: View {
    @EnvironmentObject private var dataModel: DataModel
    @State private var isScanning = false
    @State private var selectedAssets: [PHAsset] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if dataModel.photoCollection.assets.isEmpty {
                    ProgressView()
                        .scaleEffect(2.0)
                        .onAppear {
                            dataModel.loadPhotos()
                        }
                } else {
                    PhotoCollectionView(
                        photoCollection: dataModel.photoCollection,
                        selectedAssets: $selectedAssets
                    )
                }
            }
            .navigationTitle("Photos Library Cleaner")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        moveSelectedToRecentlyDeleted()
                    }, label: {
                        Label("Move to Recently Deleted", systemImage: "trash")
                    })
                    .disabled(selectedAssets.isEmpty)
                }
            }
        }
    }
    
    private func moveSelectedToRecentlyDeleted() {
        guard !selectedAssets.isEmpty else { return }
        
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets(selectedAssets as NSArray)
        } completionHandler: { success, error in
            DispatchQueue.main.async {
                if success {
                    selectedAssets.removeAll()
                    dataModel.loadPhotos()
                } else if let error = error {
                    print("Error moving assets to Recently Deleted: \(error.localizedDescription)")
                }
            }
        }
    }
}
