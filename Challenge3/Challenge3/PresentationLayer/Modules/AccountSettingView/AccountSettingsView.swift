//
//  AccountSettingsView.swift
//

import SwiftUI

struct AccountSettingsView: View, ItemView {
    var listener: CustomNavigationContainer?

    var body: some View {
           NavigationView {
               VStack(alignment: .center) {
                   
                   Image(Images.DefaultView.avatar.rawValue)
                       .overlay(
                        Image(Images.Icon.edit.rawValue)
                            .offset(x: 35, y: 35)
                                         )

                   LoginTextField(inputText: "",
                                  title: "First name",
                                  placeHolder: "First name",
                                  withHideOption: false,
                                  withBorder: true,
                                  cornerRadius: 24,
                                  backgroundColor: .white)
                   
                   LoginTextField(inputText: "",
                                  title: " Last name",
                                  placeHolder: "Last name",
                                  withHideOption: false,
                                  withBorder: true,
                                  cornerRadius: 24,
                                  backgroundColor: .white)
                   
                   LoginTextField(inputText: "",
                                  title: "E-mail ",
                                  placeHolder: "E-mail",
                                  withHideOption: false,
                                  withBorder: true,
                                  cornerRadius: 24,
                                  backgroundColor: .white)
                   
                   Text("Date of Birth")
                   HStack {
                       Spacer()
                       
                       Text("24 februry 1996")
                       
                       Spacer()
                       
                   }
                   .padding(.vertical)
                   .overlay(
                        Capsule()
                            .stroke(Color.blue, lineWidth: 2)
                   )
                   .padding()
                   
                   CustomButton(title: "Save Changes",buttonType: .filledGray) {
                       //
                   }
               }
               .makeCustomNavBar {
                   NavigationBars(atView: .accountSetting) {
                    //
                   }
               }
           }
       }
   }

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
