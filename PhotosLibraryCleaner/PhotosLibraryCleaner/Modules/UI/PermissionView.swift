import SwiftUI
import Photos

struct PermissionView: View {
    var photoLibrary: PhotoLibrary
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()
            
            Text("Photos Access Required")
                .font(.title)
                .bold()
            
            Text("This app needs access to your photo library to help you clean up and organize your photos.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                photoLibrary.requestAuthorization()
            }) {
                Text("Grant Access")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if photoLibrary.authorizationStatus == .denied {
                VStack {
                    Text("Photo library access has been denied.")
                        .foregroundColor(.red)
                    
                    Button("Open Settings") {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}
