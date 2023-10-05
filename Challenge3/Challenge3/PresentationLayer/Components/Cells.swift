//
//  Cells.swift
//

import SwiftUI

struct Cells: View {
    @State var iconState: Bool = false
    
    //MARK: - Mock data
    
    @State var cellDatas: [CellData] = [
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 1", mainRight: "Right 1", secondLeft: "Second 1", secondRight: "Right Sec 1", image: "image1", iconMode: .blank, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 2", mainRight: "Right 2", secondLeft: "Second 2", secondRight: "Right Sec 2", image: "image2", iconMode: .like, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 3", mainRight: "Right 3", secondLeft: "Second 3", secondRight: "Right Sec 3", image: "image3", iconMode: .select, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 4", mainRight: "Right 4", secondLeft: "Second 4", secondRight: "Right Sec 4", image: "image4", iconMode: .blank, height: nil)
    ]
    
    var body: some View {
        VStack {
            Text("For test ONLY!")
            
            ScrollView {
                ForEach($cellDatas) { $data in
                    FilledWideCell(data: $data)
                }
                .padding()
            }
        }
        
        ScrollView() {
            CreateButton{}
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])
            
            ForEach(0..<2) { _ in
                BlankWideCell(
                    mainTitle: "Tuhan mengapa dia berbeda",
                    secondTitle: "15 Eps"
                )
                .padding([.top, .leading])
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
    @Binding var data: CellData
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Pallete.Gray.forCells)
                .frame(height: data.height)
            
            HStack(alignment: .center) {
                CustomImage(imageString: data.image, width: 56 ,height: 56)
                    .padding(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    
                    HStack {
                        if let mainLeft = data.mainLeft {
                            Text(mainLeft)
                                .foregroundColor(Pallete.Other.deepPurpleText)
                        }
                        if (data.mainLeft != nil && data.mainRight != nil) {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 1)
                                .padding(3)
                        } else {
                            Text("")
                        }
                        if let mainRight = data.mainRight {
                            Text(mainRight)
                                .foregroundColor(Pallete.Other.deepPurpleText)
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        if let secondLeft = data.secondLeft {
                            Text(secondLeft)
                                .foregroundColor(Pallete.Gray.forText)
                        }
                        if (data.secondLeft != nil && data.secondRight != nil) {
                            Circle()
                                .fill(Pallete.Gray.forDots)
                                .frame(width: 4)
                        }
                        if let secondRight = data.secondRight {
                            Text(secondRight)
                                .foregroundColor(Pallete.Gray.darkerForText)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    data.iconState.toggle()
                } label: {
                    switch data.iconMode {
                    case .like:
                        Image(data.iconState ? Images.Icon.heartFill.rawValue : Images.Icon.heart.rawValue)
                            .padding(.trailing, 8)
                    case .select:
                        Image(data.iconState ? Images.Icon.tickSquare.rawValue : Images.Icon.plusWithBorder.rawValue)
                            .padding(.trailing, 26)
                    default:
                        Text("")
                    }
                }
                .frame(width: 56, height: data.height)
            }
        }
        .padding(5)
    }
}

struct BlankWideCell: View {
    var mainTitle: String?
    var secondTitle: String?
    var image: String?
    
    var body: some View {
        HStack(spacing: 12) {
            CustomImage(
                imageString: image,
                width: 48, height: 48
            )
            
            VStack(alignment: .leading) {
                if let mainTitle {
                    Text(mainTitle)
                        .foregroundColor(.black)
                }
                if let secondTitle {
                    Text(secondTitle)
                        .foregroundColor(Pallete.Gray.forText)
                }
            }
            
            Spacer()
        }
    }
}

struct MenuCell: View {
    var menuItems: [String: String]
    var spacing: Double = 16
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(menuItems), id: \.0) { item in
                HStack(spacing: 12) {
                    CustomIcon(
                        iconString: item.0,
                        width: 48, height: 48
                    )
                    
                    Text(item.1)
                    
                    Spacer()
                    
                    Image(Images.Icon.arrowRight.rawValue)
                }
            }
        }
    }
}

enum IconMode: String {
    case like, select, blank
}

struct CellData: Identifiable {
    let id: Int?
    let guid: String?
    var iconState: Bool
    let mainLeft: String?
    let mainRight: String?
    let secondLeft: String?
    let secondRight: String?
    let image: String?
    let iconMode: IconMode?
    let height: CGFloat?
}
