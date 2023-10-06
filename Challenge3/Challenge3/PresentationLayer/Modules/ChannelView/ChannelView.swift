//
//  ChannelView.swift
//

import SwiftUI
import PodcastIndexKit

struct ChannelView: View, ItemView {
    
    // MARK: - Internal Properties
    
    let screenTitle: String
    let dataForScreen: Podcast?
    
    var listener: CustomNavigationContainer?
    
    
    // MARK: - Private Properties
    
    var strings = Localizable.Channel.self
    private var informationRow: some View {
        VStack(spacing: 24) {
            VStack(spacing: 5) {
                CustomImage(imageString: dataForScreen?.image, backColor: Pallete.Other.blue, width: 84, height: 84)
                
                CustomLabel(labelText: dataForScreen?.title ?? "", additionalText: "Dr. Oi om jean", labelStyle: .channel, epsText: "56 EPS")
            }
        }
    }
    
    // MARK: - Mock data
    
    @State private var data = [
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 1", mainRight: "Right 1", secondLeft: "Second 1", secondRight: "Right Sec 1", image: "image1", iconMode: .blank, height: nil)
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
        ChannelView(screenTitle: "Channel", dataForScreen: nil)
    }
}
