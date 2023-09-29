//
//  ChannelView.swift
//

import SwiftUI

struct ChannelView: View, ItemView {
    
    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?
    
    // MARK: - Private Properties
    private var strings = Localizable.Channel.self
    private var informationRow: some View {
        VStack(spacing: 24) {
            VStack(spacing: 5) {
                CustomImage(imageString: "", backColor: Pallete.Other.blue, width: 84, height: 84)
                CustomLabel(labelText: "Baby Pesut Podcast", additionalText: "Dr. Oi om jean", labelStyle: .channel, epsText: "56 EPS")
            }
        }
    }
    
    //MARK: Mock data
    @State private var data = [
        CellData(iconState: false, mainLeft: "Between love and career", mainRight: nil, secondLeft: "56:38", secondRight: "56 Eps", image: "", iconMode: .blank, height: nil)
    ]
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 34) {
                informationRow
                VStack(spacing: 16) {
                    HStack {
                        Text(strings.allEpisode)
                            .font(.system(size: 14, weight: .bold))
                            .padding(.horizontal)
                        Spacer()
                    }
                    ForEach($data) { $data in
                        FilledWideCell(data: $data)
                    }
                    .padding(.horizontal)
                }
            }
            .makeCustomNavBar {
                NavigationBars(atView: .channel) {
                    listener?.pop()
                }
            }
        }
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}
