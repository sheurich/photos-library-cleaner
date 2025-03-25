import SwiftUI
import Photos

struct DashboardView: View {
    @State private var isScanning = false
    @State private var scanProgress: Float = 0.0
    @State private var scanResults: ScanResults?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection

                if isScanning {
                    scanningSection
                } else if let results = scanResults {
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
            ProgressView(value: scanProgress, total: 1.0)
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
                isScanning = false
            }, label: {
                Text("Cancel")
                    .foregroundColor(.red)
            })
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
                startScan()
            }, label: {
                Text("Start Scan")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
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
            }, label: {
                Text("Clean Up Library")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
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

    private func startScan() {
        isScanning = true
        scanProgress = 0.0

        // Simulate scanning progress
        // This will be replaced with actual scanning in future phases
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if scanProgress < 1.0 {
                scanProgress += 0.1
            } else {
                timer.invalidate()
                isScanning = false

                // Mock results for UI demonstration
                scanResults = ScanResults(
                    blurryPhotosCount: 15,
                    duplicatesCount: 42,
                    screenshotsCount: 28,
                    eventsCount: 8
                )
            }
        }
    }
}

struct ScanResults {
    let blurryPhotosCount: Int
    let duplicatesCount: Int
    let screenshotsCount: Int
    let eventsCount: Int
}

#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashboardView()
        }
    }
}
#endif
