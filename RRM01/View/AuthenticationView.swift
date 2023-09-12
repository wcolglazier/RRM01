import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct AuthenicationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Image("Aggie")
                .resizable()
                .scaledToFill()
                .opacity(0.65)
                .overlay(Color.black.opacity(0.35))
                .overlay(Color(red: 128/255, green: 0, blue: 0).opacity(0.25))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            guard let nsError = error as? NSError else {
                                return // or handle the failure
                            }
                            if nsError.domain == "TAMU_EMAIL_VALIDATION" {
                                // Handle error

                                showAlert = true
                            } else {
                                print(error)
                            }
                        }
                    }
                }) {
                    Text("Connect Here")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 128/255, green: 0, blue: 0))
                        .padding(.vertical, 25)
                        .padding(.horizontal, 30)
                        .background(Color.white)
                        .cornerRadius(16)
                }
                .padding(.top, 440)

                Text("(Sign in using your TAMU Email)")
                    .font(.system(size: 25))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)

                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Howdy! As a safety measure please use your tamu email."), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Howdy")
                    .fontWeight(.bold)
                    .padding(.top, 197)
                    .foregroundColor(.white)
                    .font(Font.custom("marker Felt", size: 115))
            }
        }
    }
}

struct AuthenicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenicationView(showSignInView: .constant(false))
        }}}
