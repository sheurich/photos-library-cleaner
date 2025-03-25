import Foundation
import Photos
import UIKit
import SwiftUI

class PhotoLibraryManager {
    static let shared = PhotoLibraryManager()

    private init() {}

    // MARK: - Fetch Assets

    func fetchAllAssets(completion: @escaping ([PHAsset]?, Error?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)

        var assets = [PHAsset]()
        fetchResult.enumerateObjects { asset, _, _ in
            assets.append(asset)
        }

        completion(assets, nil)
    }

    func fetchImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> Void) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false

        PHImageManager.default().requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: contentMode,
            options: options,
            resultHandler: completion
        )
    }

    // MARK: - Asset Management

    func moveAssetToRecentlyDeleted(_ asset: PHAsset, completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
        } completionHandler: { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }

    func moveAssetsToRecentlyDeleted(_ assets: [PHAsset], completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets(assets as NSArray)
        } completionHandler: { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
}
