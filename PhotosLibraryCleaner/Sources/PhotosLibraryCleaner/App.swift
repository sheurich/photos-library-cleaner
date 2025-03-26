import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@main
struct PhotosLibraryCleanerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = PhotosViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Photos Library Cleaner")
                    .font(.largeTitle)
                    .padding()
                
                Text("Running on \(viewModel.platformName)")
                    .font(.headline)
                    .padding()
                
                Divider()
                
                PhotoStatsView(viewModel: viewModel)
                
                Spacer()
                
                Button("Scan for Duplicates") {
                    viewModel.scanForDuplicates()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                if !viewModel.duplicatePhotos.isEmpty {
                    List {
                        ForEach(viewModel.duplicatePhotos, id: \.self) { photo in
                            HStack {
                                Text(photo)
                                Spacer()
                                Button("Remove") {
                                    viewModel.removeDuplicate(photo)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }
            .padding()
            .navigationTitle("Photos Cleaner")
        }
    }
}

struct PhotoStatsView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Library Statistics")
                .font(.headline)
            
            HStack {
                Text("Total Photos:")
                Spacer()
                Text("\(viewModel.totalPhotos)")
                    .bold()
            }
            
            HStack {
                Text("Duplicate Photos:")
                Spacer()
                Text("\(viewModel.duplicatePhotos.count)")
                    .bold()
            }
            
            HStack {
                Text("Storage Used:")
                Spacer()
                Text(viewModel.storageUsed)
                    .bold()
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

class PhotosViewModel: ObservableObject {
    @Published var totalPhotos: Int = 0
    @Published var duplicatePhotos: [String] = []
    @Published var storageUsed: String = "0 MB"
    
    private let cleaner = PhotosLibraryCleaner()
    
    var platformName: String {
        return cleaner.getPlatformName()
    }
    
    init() {
        totalPhotos = Int.random(in: 100...1000)
        storageUsed = "\(Int.random(in: 1...10)) GB"
    }
    
    func scanForDuplicates() {
        let count = Int.random(in: 3...10)
        duplicatePhotos = cleaner.findDuplicatePhotos(count: count)
    }
    
    func removeDuplicate(_ photo: String) {
        if let index = duplicatePhotos.firstIndex(of: photo) {
            duplicatePhotos.remove(at: index)
        }
    }
}
