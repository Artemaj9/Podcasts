//
//  AuthentificationModel.swift
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import CryptoKit

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    static let shared = AuthenticationViewModel()
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""
    
    private var currentNonce: String?
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    private init() {
        registerAuthStateHandler()
        
        $flow
            .combineLatest($email, $password, $confirmPassword)
            .map { flow, email, password, confirmPassword in
                flow == .login
                ? !(email.isEmpty || password.isEmpty)
                : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            }
            .assign(to: &$isValid)
    }
    
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.displayName ?? ""
            }
        }
    }
    
    func sentMessageToChangePassword() {
        if let userEmail = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: userEmail){ error in
                
            }
            
        }
    }
    
    func switchFlow() {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
    }
    
    func reset() {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    private func wait() async {
        do {
            print("Wait")
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("Done")
        }
        catch { }
    }
}

// MARK: - Email and Password Authetication

extension AuthenticationViewModel {
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        var isDone = false
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            isDone = true
        }
        catch {
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
        sendEmailToConfirmEmail()
        return isDone
    }
    
    func changeDisplayName() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "\(firstName) \(lastName)"
        changeRequest?.commitChanges { error in
            if let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func changeUserPassword() {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if let error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func changeUserEmail() {
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if let error {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func reauthenticateUser() {
        // TODO: add functionality for relogin with user credentials
        let credetials = EmailAuthProvider.credential(withEmail: email, password: password)
        user?.reauthenticate(with: credetials) { _, error  in
            self.errorMessage = error?.localizedDescription ?? ""
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    private func sendEmailToConfirmEmail(){
        Auth.auth().currentUser?.sendEmailVerification()
    }
    
}

// MARK: - Google Sign-In

enum AuthenticationError: Error {
    case tokenError(message: String)
}

extension AuthenticationViewModel {
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }
}

// MARK: - Apple Sign-In

extension AuthenticationViewModel {
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        if case .failure(let failure) = result {
            errorMessage = failure.localizedDescription
        }
        else if case .success(let authorization) = result {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: a login callback was received, but no login request was sent.")
                }
                
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identify token.")
                    return
                }
                
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credentials = OAuthProvider.credential(withProviderID: "apple.com",
                                                           idToken: idTokenString,
                                                           rawNonce: nonce)
                
                Task {
                    do {
                        let result = try await Auth.auth().signIn(with: credentials)
                        await updateDisplayName(for: result.user, with: appleIDCredential)
                    }
                    catch {
                        print("Error authenticating: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func updateDisplayName(for user: User, with appleIDCredential: ASAuthorizationAppleIDCredential, force: Bool = false) async {
        if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty {
            //
        }
        else {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = appleIDCredential.displayName()
            do {
                try await changeRequest.commitChanges()
                self.displayName = Auth.auth().currentUser?.displayName ?? ""
            }
            catch {
                print("Unable to update the user's displayname: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func verifySignInWithAppleAuthenticationState() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let providerData = Auth.auth().currentUser?.providerData
        if let appleProviderData = providerData?.first(where: { $0.providerID == "apple.com" }) {
            Task {
                do {
                    let credentialState = try await appleIDProvider.credentialState(forUserID: appleProviderData.uid)
                    switch credentialState {
                    case .authorized:
                        break
                    case .revoked, .notFound:
                        self.signOut()
                    default:
                        break
                    }
                }
                catch {
                }
            }
        }
    }
}

extension ASAuthorizationAppleIDCredential {
    func displayName() -> String {
        return [self.fullName?.givenName, self.fullName?.familyName]
            .compactMap( {$0})
            .joined(separator: " ")
    }
}

private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}
