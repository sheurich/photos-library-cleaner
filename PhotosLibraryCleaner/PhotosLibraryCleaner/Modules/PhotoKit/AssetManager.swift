import Foundation
import Photos
import UIKit

class AssetManager {
    static let shared = AssetManager()

    private init() {}

    // MARK: - Asset Metadata

    func getAssetMetadata(for asset: PHAsset) -> [String: Any] {
        var metadata: [String: Any] = [:]

        metadata["localIdentifier"] = asset.localIdentifier
        metadata["creationDate"] = asset.creationDate
        metadata["modificationDate"] = asset.modificationDate
        metadata["mediaType"] = asset.mediaType.rawValue
        metadata["pixelWidth"] = asset.pixelWidth
        metadata["pixelHeight"] = asset.pixelHeight
        metadata["duration"] = asset.duration
        metadata["isFavorite"] = asset.isFavorite

        if let location = asset.location {
            metadata["location"] = [
                "latitude": location.coordinate.latitude,
                "longitude": location.coordinate.longitude
            ]
        }

        return metadata
    }

    // MARK: - Asset Collections

    func createAlbum(withTitle title: String, assets: [PHAsset], completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges {
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
            let placeholderForAssetCollection = createAlbumRequest.placeholderForCreatedAssetCollection

            if let albumAssetCollection = placeholderForAssetCollection {
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: albumAssetCollection)
                albumChangeRequest?.addAssets(assets as NSArray)
            }
        } completionHandler: { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }

    func fetchUserAlbums(completion: @escaping ([PHAssetCollection]?, Error?) -> Void) {
        let fetchOptions = PHFetchOptions()
        let fetchResult = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: fetchOptions
        )

        var albums = [PHAssetCollection]()
        fetchResult.enumerateObjects { album, _, _ in
            albums.append(album)
        }

        completion(albums, nil)
    }
}
