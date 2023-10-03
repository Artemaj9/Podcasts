//
// CustomAlert.swift
//


import SwiftUI

struct CustomAlert: View {
    var action1 : () -> ()
    var action2 : () -> ()
    var action3 : () -> ()
    
    var icons: [String] = [ Images.ChangePicture.photo.rawValue, Images.ChangePicture.galery.rawValue,
        Images.ChangePicture.trash.rawValue]
    
    var titles : [String] = [Localizable.AccountSettings.takeAPhoto, Localizable.AccountSettings.chooseFromYourFile, Localizable.AccountSettings.deletePhoto]
    
    var menuItems : [String : String] {
        var output :  [String : String] = [:]
        for (index, key) in icons.enumerated() {
            output[key] = titles[index]
            }
        return output
    }

    var body: some View {
        VStack(spacing: 40) {
            Text(Localizable.AccountSettings.changeYourPicture)
                .font(.custom("Plus Jakarta Sans", size: 20))
            VStack(spacing: 20) {
                ForEach(icons.indices) { index in
                    HStack(spacing: 12) {
                        CustomIcon(
                            iconString: icons[index],
                            width: 48, height: 48
                        )
                        
                        Text(titles[index])
                        
                        Spacer()
                        
                        Image(Images.Icon.arrowRight.rawValue)
                    }
                    .onTapGesture {
                        if index == 0 {
                            action1()
                        }
                        else if index == 1 {
                            action2()
                        } else {
                            action3()
                        }
                    }
                }
            }
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert (action1: {}, action2: {}, action3: {})
    }
}
