//
//  ChannelView.swift
//

import SwiftUI
import PodcastIndexKit

struct ChannelView: View, ItemView {

    @EnvironmentObject var channelViewModel: ChannelViewModel
    
    // MARK: - Internal Properties
    
    let screenTitle: String
    let dataForScreen: Podcast?
    
    var listener: CustomNavigationContainer?
    
    var strings = Localizable.Channel.self
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 34) {
                VStack(spacing: 5) {
                    CustomImage(imageString: dataForScreen?.image, backColor: Pallete.Other.blue, width: 84, height: 84)

                    CustomLabel(
                        labelText: dataForScreen?.title ?? "",
                        additionalText: dataForScreen?.author ?? "",
                        labelStyle: .channel,
                        epsText: "\(channelViewModel.currentPodcastEpisodes.count) EPS"
                    )
                }

                VStack(spacing: 16) {
                    HStack {
                        Text(strings.allEpisode)
                            .font(.system(size: 14, weight: .bold))
                            .padding(.horizontal)
                        Spacer()
                    }

                    ForEach(channelViewModel.currentPodcastEpisodes, id: \.id) { episode in

                        let bindingData = Binding<EpisodeCellData>(
                            get: { return channelViewModel.dataToEpisodeCellData(episode: episode) },
                            set: {_ in }
                        )
                        
                        FilledEpisodeWideCell(data: bindingData)
                            .onTapGesture {
                                listener?.push(
                                    view: NowPlayingView(
                                        podcastIndex: channelViewModel.getEpisodeIndex(episode: episode) ?? 0,
                                        dataForSend: channelViewModel.currentPodcastEpisodes
                                    )
                                )
                            }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    channelViewModel.getEpisodes(podcastID: String(dataForScreen?.id ?? 0))
                }
            }
        }
        .makeCustomNavBar {
            NavigationBars(atView: .channel) {
                listener?.pop()
            }
        }
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView(screenTitle: "Channel", dataForScreen: nil)
            .environmentObject(ChannelViewModel())
    }
}
