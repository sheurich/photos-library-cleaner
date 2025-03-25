import SwiftUI
import Photos

struct AssetGridView: View {
    var assets: [PHAsset]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(assets, id: \.localIdentifier) { asset in
                    AssetThumbnailView(asset: asset)
                        .aspectRatio(1, contentMode: .fill)
                        .cornerRadius(5)
                }
            }
            .padding()
        }
    }
}

struct AssetThumbnailView: View {
    var asset: PHAsset
    @State private var image: Image?
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                    )
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.deliveryMode = .opportunistic
        option.resizeMode = .exact
        option.isSynchronous = false
        
        manager.requestImage(
            for: asset,
            targetSize: CGSize(width: 200, height: 200),
            contentMode: .aspectFill,
            options: option
        ) { result, _ in
            #if os(iOS)
            if let uiImage = result as? UIImage {
                image = Image(uiImage: uiImage)
            }
            #elseif os(macOS)
            if let nsImage = result as? NSImage {
                image = Image(nsImage: nsImage)
            }
            #endif
        }
    }
}

#if DEBUG
struct AssetGridView_Previews: PreviewProvider {
    static var previews: some View {
        AssetGridView(assets: [])
    }
}
#endif
