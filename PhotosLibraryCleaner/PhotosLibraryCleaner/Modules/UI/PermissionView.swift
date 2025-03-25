import SwiftUI
import Photos

struct PermissionView: View {
    @ObservedObject var permissionManager: PhotoLibraryPermissionManager

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
                permissionManager.requestAuthorization()
            }, label: {
                Text("Grant Access")
                    .bold()
                    .frame(minWidth: 200)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .padding()

            if permissionManager.authorizationStatus == .denied {
                VStack {
                    Text("Photo library access has been denied.")
                        .foregroundColor(.red)

                    #if os(iOS)
                    Button(action: {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text("Open Settings")
                            .underline()
                    })
                    #elseif os(macOS)
                    Button(action: {
                        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Photos")!)
                    }, label: {
                        Text("Open Settings")
                            .underline()
                    })
                    #endif
                }
                .padding()
            }

            Spacer()
        }
        .padding()
    }
}

#if DEBUG
struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(permissionManager: PhotoLibraryPermissionManager())
    }
}
#endif
