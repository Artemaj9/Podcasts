//
//  Cells.swift
//

import SwiftUI

struct Cells: View {
    @State var iconState: Bool = false
    
    var body: some View {
        VStack {
            Text("For test ONLY!")
            NavigationView {
                ScrollView() {
                    ForEach(0..<3) { _ in
                        NavigationLink(destination: Icons()) {
                            FilledWideCell(
                                iconState: Binding<Bool?>(
                                    get: { iconState },
                                    set: { newValue in iconState = newValue ?? false }
                                ),
                                mainLeft: "Ngobam", mainRight: "Gofar Hilman",
                                secondLeft: "Music & Fun", secondRight: "23 Eps",
                                iconMode: .like
                            )
                            .padding([.top, .horizontal])
                        }
                    }
                }
            }
            
            ScrollView() {
                BlankWideCell(
                    mainTitle: "Create Playlist",
                    cellMode: .new
                )
                .padding([.top, .leading])
                
                ForEach(0..<2) { _ in
                    BlankWideCell(
                        mainTitle: "Tuhan mengapa dia berbeda",
                        secondTitle: "15 Eps",
                        cellMode: .normal
                    )
                    .padding([.top, .leading])
                }
            }
            
            VStack(spacing: 16) {
                MenuCell(menuIcon: .accountSettings)
                    .padding(.horizontal)
                
                MenuCell(menuIcon: .changePass)
                    .padding(.horizontal)
                
                MenuCell(menuIcon: .forgetPass)
                    .padding(.horizontal)
            }
        }
    }
}

struct Cells_Previews: PreviewProvider {
    static var previews: some View {
        Cells()
    }
}

struct FilledWideCell: View {
    @Binding var iconState: Bool?
    
    var mainLeft: String?
    var mainRight: String?
    var secondLeft: String?
    var secondRight: String?
    var image: String?
    var iconMode: IconMode?
    var height: CGFloat?
    
    init(
        iconState: Binding<Bool?>? = nil,
        mainLeft: String? = nil, mainRight: String? = nil,
        secondLeft: String? = nil, secondRight: String? = nil,
        image: String? = nil, iconMode: IconMode? = nil,
        height: CGFloat? = nil) {
            self._iconState = iconState ?? .constant(false)
            self.mainLeft = mainLeft
            self.mainRight = mainRight
            self.secondLeft = secondLeft
            self.secondRight = secondRight
            self.image = image
            self.iconMode = iconMode
            self.height = height
        }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Pallete.Gray.forCells)
                .frame(height: height)
            
            HStack(alignment: .center) {
                CustomImage(imageString: image, width: 56 ,height: 56)
                    .padding(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    
                    HStack {
                        if mainLeft != nil {
                            Text(mainLeft ?? "")
                                .foregroundColor(.black)
                        }
                        if (mainLeft != nil && mainRight != nil) {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 1)
                                .padding(3)
                        } else {
                            Text("")
                        }
                        if mainRight != nil {
                            Text(mainRight ?? "")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        if secondLeft != nil {
                            Text(secondLeft ?? "")
                                .foregroundColor(Pallete.Gray.forText)
                        }
                        if (secondLeft != nil && secondRight != nil) {
                            Circle()
                                .fill(.white)
                                .frame(width: 4)
                        }
                        if secondRight != nil {
                            Text(secondRight ?? "")
                                .foregroundColor(Pallete.Gray.forText)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {iconState?.toggle()},
                       label: {
                    switch iconMode {
                    case .like:
                        Image(iconState == true ? Images.Icon.heartFill.rawValue : Images.Icon.heart.rawValue)
                            .padding(.trailing, 8)
                    case .select:
                        Image(iconState == true ? Images.Icon.tickSquare.rawValue : Images.Icon.plusWithBorder.rawValue)
                            .padding(.trailing, 26)
                    default:
                        Text("")
                    }
                })
                .frame(width: 56, height: 56)
            }
        }
    }
}

struct BlankWideCell: View {
    var mainTitle: String?
    var secondTitle: String?
    var image: String?
    var cellMode: WideCellMode?
    
    var body: some View {
        HStack(spacing: 12) {
            CustomImage(
                imageString: (cellMode == .new) ? Images.Icon.plus.rawValue : (cellMode == .normal ? image : nil),
                width: 48, height: 48
            )
            
            VStack(alignment: .leading) {
                if mainTitle != nil {
                    Text(mainTitle ?? "")
                        .foregroundColor(.black)
                }
                if secondTitle != nil {
                    Text(secondTitle ?? "")
                        .foregroundColor(Pallete.Gray.forText)
                }
            }
            
            Spacer()
        }
    }
}

struct MenuCell: View {
    var menuIcon: MenuIcon = .accountSettings
    
    var body: some View {
        HStack(spacing: 12) {
            CustomIcon(
                iconString: (menuIcon == .accountSettings) ? Images.Icon.profile.rawValue : (menuIcon == .changePass ? Images.Icon.shield.rawValue : Images.Icon.unlock.rawValue),
                width: 48, height: 48
            )
            
            Text(
                (menuIcon == .accountSettings) ? "Account Settings" : (menuIcon == .changePass ? "Change Password" : "Forget Password")
            )
            
            Spacer()
            
            Image(Images.Icon.arrowRight.rawValue)
        }
    }
}

enum WideCellMode: String {
    case new, normal
}

enum IconMode: String {
    case like, select, blank
}

enum MenuIcon: String {
    case accountSettings, changePass, forgetPass
}
