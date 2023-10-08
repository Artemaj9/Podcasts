//
//  ProfilesettingsView.swift
//

import SwiftUI

struct ProfilesettingsView: View, ItemView {
    @ObservedObject var authViewModel = AuthenticationViewModel.shared
    @EnvironmentObject var userManager: UserManager
    @State var showingAlert = false
    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(alignment: .leading, spacing: 66) {
                if let image = userManager.imageUrl {
                    BlankWideCell(
                        mainTitle: userManager.getDisplayName(),
                        secondTitle: "Love,life and chill",
                        image: image
                    )
                }
                VStack() {
                    HStack(spacing: 12) {
                        Button {
                            listener?.push(view: AccountSettingsView())
                        } label: {
                            CustomIcon(
                                iconString:  Images.Icon.profile.rawValue,
                                width: 48, height: 48
                            )
                            
                            Text(Localizable.ProfileSettings.accountSetting)
                            
                            Spacer()
                            
                            Image(Images.Icon.arrowRight.rawValue)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Button {
                            showingAlert = true
                            authViewModel.sentMessageToChangePassword()
                        } label: {
                            CustomIcon(
                                iconString: Images.Icon.shield.rawValue,
                                width: 48, height: 48
                            )
                            Text(Localizable.ProfileSettings.changePassword)
                            
                            Spacer()
                            
                            Image(Images.Icon.arrowRight.rawValue)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Button {
                            
                        } label: {
                            CustomIcon(
                                iconString: Images.Icon.unlock.rawValue,
                                width: 48, height: 48
                            )
                            
                            Text(Localizable.ProfileSettings.forgetPassword)
                            
                            Spacer()
                            
                            Image(Images.Icon.arrowRight.rawValue)
                        }
                    }
                }
                
                Spacer()
                
                CustomButton(title: Localizable.ProfileSettings.logOut, buttonType: .strokeBlue) {
                    authViewModel.signOut()
                    listener?.push(view: SplashView())
                }
            }
            .onAppear {
                userManager.searchImage()
            }
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Message sent!"), message: Text("We have sent you a link to change your password by email."), dismissButton: .default(Text("OK")))
            }
            .padding([.top, .horizontal])
        }
    }
}

struct ProfilesettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesettingsView()
    }
}

