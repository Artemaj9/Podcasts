//
//  NowPlayingView.swift
//

import SwiftUI
import PodcastIndexKit
import AVFoundation
import Kingfisher

struct NowPlayingView: View, ItemView {
    var listener: CustomNavigationContainer?
    
    @ObservedObject var player = PlayerViewModel.shared
    @EnvironmentObject var viewModel: NowPlayingViewModel
    
    @State var opacity: Double = 1
    
    @State var startingOffsetX: CGFloat = UIScreen.main.bounds.width * 0
    @State var endingOffsetX: CGFloat = 0
    
    let podcastIndex: Int
    let dataForSend: [Episode]
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                let playerIndex = player.currentEpisodeIndex
                
                if let imageUrl = player.episodePlaylist?[playerIndex].feedImage {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(2)
                        .blur(radius: 100)
                        .animation(
                            .easeIn(duration: 1),
                            value: viewModel.currentBackground
                        )
                } else {
                    Image(Images.DefaultView.avatar.rawValue)
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(2)
                        .blur(radius: 50)
                        .animation(
                            .easeIn(duration: 1),
                            value: viewModel.currentBackground)
                }
            }
            .ignoresSafeArea()
            
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 10) {
                            Color.clear
                                .frame(width: (UIScreen.main.bounds.size.width/8))
                            
                            if let playlist = player.episodePlaylist {
                                ForEach(playlist.indices, id: \.self) { index in
                                    GeometryReader { geometry in
                                        let episode = playlist[index]
                                        
                                        EpisodeImageView(episode: episode)
                                            .frame(width: UIScreen.main.bounds.size.width * 0.7)
                                            .opacity(viewModel.getScrollOpacity(geometry: geometry))
                                            .scaleEffect(y:viewModel.getScrollOpacity(geometry: geometry))
                                            .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .global)
                                                .onChanged { value in
                                                    withAnimation(.spring()) {
                                                        viewModel.currentDragOffsetX = value.translation.width
                                                    }
                                                }
                                                .onEnded { _ in
                                                    let idToScroll = viewModel.scrollto(
                                                        id: index,
                                                        offsetX: viewModel.currentDragOffsetX
                                                    )
                                                    viewModel.currentBackground = idToScroll
                                                    
                                                    withAnimation {
                                                        scrollProxy.scrollTo(
                                                            idToScroll,
                                                            anchor: .center
                                                        )
                                                        
                                                        viewModel.scrollFlag = viewModel.scrollFlag(
                                                            id: index, offsetX: viewModel.currentDragOffsetX
                                                        )
                                                        
                                                        if viewModel.scrollFlag {
                                                            viewModel.setUpTimer()
                                                        } else {
                                                            viewModel.currentDragOffsetX = 0
                                                        }
                                                    }
                                                }
                                            )
                                    }
                                    .frame(width: 280, height: 240)
                                }
                            }
                            
                            Color.clear
                                .frame(width: (UIScreen.main.bounds.size.width - 70) / 2.0)
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(
                        for: Notification.Name("ScrollToEpisode"))
                    ) { notification in
                        if let episodeIndex = notification.object as? Int {
                            withAnimation {
                                scrollProxy.scrollTo(episodeIndex, anchor: .center)
                            }
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(
                        for: Notification.Name("ScrollToNextEpisode"))
                    ) { notification in
                        if let episodeIndex = notification.object as? Int {
                            withAnimation {
                                scrollProxy.scrollTo(episodeIndex, anchor: .center)
                            }
                        }
                    }
                }
                
                VStack {
                    Text(player.episodeTitle)
                        .font(.title)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                    
                    Text("\(player.episodeNumber)")
                        .font(.body)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                }
                .offset(y: -40)
                
                if let durationTime = player.currentEpisode?.duration, durationTime > 0 {
                    HStack() {
                        Spacer()
                        
                        Text(player.durationFormatter.string(
                            from: player.displayTime) ?? ""
                        )
                        
                        Slider(
                            value: $player.displayTime,
                            in: (0...Double(durationTime)),
                            onEditingChanged: { (scrubStarted) in
                                if scrubStarted {
                                    player.scrubState = .scrubStarted
                                } else {
                                    player.scrubState = .scrubEnded(player.displayTime)
                                }
                            }
                        )
                        
                        Text(player.durationFormatter.string(
                            from: Double(durationTime)) ?? ""
                        )
                    }
                    .foregroundColor(Pallete.Other.deepPurpleText)
                    .padding()
                }
                
                PlayControl(
                    isPlaying: $player.isPlaying,
                    isRandom: $player.isRandom,
                    isRepeated: $player.isRandom,
                    shuffleAction: {
                        player.shufflePlaylist()
                        viewModel.sendScrollToEpisodeNotification(episodeIndex: 0)
                    },
                    previousAction: {
                        let prevIndex = player.currentEpisodeIndex - 1
                        
                        if prevIndex >= 0 {
                            player.setCurrentEpisode(index: prevIndex)
                            viewModel.sendScrollToEpisodeNotification(episodeIndex: prevIndex)
                        }
                    },
                    playAction: {
                        player.isPlaying ?
                        player.pause() :
                        player.play()
                    },
                    nextAction: {
                        let nextIndex = player.currentEpisodeIndex + 1
                        
                        if player.isRepeated {
                            if nextIndex < player.episodePlaylist?.count ?? 0 {
                                player.setCurrentEpisode(index: nextIndex)
                                viewModel.sendScrollToEpisodeNotification(episodeIndex: nextIndex)
                            } else {
                                player.setCurrentEpisode(index: 0)
                                viewModel.sendScrollToEpisodeNotification(episodeIndex: 0)
                            }
                        }
                        else {
                            if nextIndex < player.episodePlaylist?.count ?? 0 {
                                player.setCurrentEpisode(index: nextIndex)
                                viewModel.sendScrollToEpisodeNotification(episodeIndex: nextIndex)
                            }
                        }
                    },
                    repeatAction: {
                        player.repeatPlaylist()
                    }
                )
                .padding(.vertical, 30)
            }
        }
        .onAppear {
            // TODO: add logic for adding data to playlist when it's empty
            player.currentEpisodeIndex = podcastIndex
            player.episodePlaylist = dataForSend
            if !player.isPlaying {
                player.play()
            }
        }
        .onDisappear {
            // TODO: add logic for clearing current episode and playlist if playing is paused
            viewModel.cancellables.removeAll()
        }
    }
}

struct EpisodeImageView: View {
    let episode: Episode
    
    var body: some View {
        if let imageURL = episode.feedImage {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 4)
                .frame(width: UIScreen.main.bounds.size.width * 0.7)
        } else {
            Image(Images.DefaultView.avatar.rawValue)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 4)
                .frame(width: UIScreen.main.bounds.size.width * 0.7)
        }
    }
}
