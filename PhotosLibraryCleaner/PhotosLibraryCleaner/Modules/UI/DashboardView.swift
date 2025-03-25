import SwiftUI
import Photos

struct DashboardView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                
                if coordinator.isScanning {
                    scanningSection
                } else if let results = coordinator.scanResults {
                    resultsSection(results)
                } else {
                    startScanSection
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
    }
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Text("Photos Library Cleaner")
                .font(.largeTitle)
                .bold()
            
            Text("Clean up and organize your photo library")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical)
    }
    
    private var scanningSection: some View {
        VStack(spacing: 15) {
            ProgressView(value: coordinator.scanProgress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(height: 10)
            
            Text("Scanning your photo library...")
                .font(.headline)
            
            Text("This may take a few minutes depending on the size of your library")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Cancel scan functionality will be implemented in future phases
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    private var startScanSection: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            Text("Ready to clean up your photo library?")
                .font(.headline)
            
            Text("Scan your library to find blurry photos, duplicates, and more.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: {
                coordinator.startScan()
            }) {
                Text("Start Scan")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    private func resultsSection(_ results: ScanResults) -> some View {
        VStack(spacing: 20) {
            Text("Scan Results")
                .font(.headline)
            
            HStack(spacing: 20) {
                resultCard(
                    icon: "photo.fill.on.rectangle.fill",
                    title: "Blurry Photos",
                    count: results.blurryPhotosCount,
                    color: .orange
                )
                
                resultCard(
                    icon: "photo.on.rectangle",
                    title: "Duplicates",
                    count: results.duplicatesCount,
                    color: .blue
                )
            }
            
            HStack(spacing: 20) {
                resultCard(
                    icon: "doc.text.image",
                    title: "Screenshots",
                    count: results.screenshotsCount,
                    color: .green
                )
                
                resultCard(
                    icon: "folder",
                    title: "Events",
                    count: results.eventsCount,
                    color: .purple
                )
            }
            
            Button(action: {
                // Clean up functionality will be implemented in future phases
            }) {
                Text("Clean Up Library")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
    }
    
    private func resultCard(icon: String, title: String, count: Int, color: Color) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
            
            Text("\(count)")
                .font(.title)
                .bold()
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}
