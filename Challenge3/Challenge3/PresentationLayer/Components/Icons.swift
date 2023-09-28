//
//  Icons.swift
//

import SwiftUI
import Kingfisher

struct Icons: View {
    var body: some View {
        VStack {
            Text("For test ONLY!")

            Spacer()

            HStack {
                CustomIcon(iconString: Images.Icon.closeSquare.rawValue, width: 48, height: 48)
                    .padding()

                CustomImage(width: 48, height: 48)
            }

            Spacer()
        }
    }
}

struct CustomIcon: View {
    var iconString: String
    var backColor: Color = Pallete.Gray.forCells
    var width: CGFloat?
    var height: CGFloat?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(backColor)
                .frame(width: width, height: height)

            Image(iconString)
                .foregroundColor(Color.gray)
        }
    }
}

struct CustomImage: View {
    var imageString: String?
    var backColor: Color = Pallete.OtherLight.peach
    var width: CGFloat?
    var height: CGFloat?

    var body: some View {
        ZStack {
            if let urlString = imageString, let url = URL(string: urlString), url.scheme != nil {
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else if let imageString = imageString, !imageString.isEmpty {
                Image(imageString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backColor)
                    .frame(width: width, height: height)
            }
        }
    }
}

struct Icons_Previews: PreviewProvider {
    static var previews: some View {
        Icons()
    }
}
