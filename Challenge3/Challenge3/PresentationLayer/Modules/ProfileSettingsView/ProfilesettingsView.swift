//
//  ProfilesettingsView.swift
//

import SwiftUI

struct ProfilesettingsView: View, ItemView {

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    var texts: [String: String] = [
        Images.Icon.profile.rawValue: Localizable.ProfileSettings.accountSetting,
        Images.Icon.shield.rawValue: Localizable.ProfileSettings.changePassword,
        Images.Icon.unlock.rawValue: Localizable.ProfileSettings.forgetPassword
    ]

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 66) {
            BlankWideCell(
                mainTitle: "Abigael Amaniah",
                secondTitle: "Love,life and chill"
            )
            
            MenuCell(menuItems:texts,spacing: 21)
            
            Spacer()
            
            CustomButton(title: Localizable.ProfileSettings.logOut, buttonType: .strokeBlue) {
            }
        }
        .padding([.top, .leading])
    }
}
struct ProfilesettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesettingsView()
    }
}

