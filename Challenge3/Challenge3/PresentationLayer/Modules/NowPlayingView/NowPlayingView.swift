//
//  NowPlayingView.swift
//

import SwiftUI
import AVFoundation

struct NowPlayingView: View, ItemView {
    var listener: CustomNavigationContainer?
    
    @StateObject var vm  = NowPlayingViewModel()
    @StateObject var player = Player(avPlayer: AVPlayer(url: URL(string: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3")!))
    @State var track = false
    let url = "https://file-examples.com/storage/feaade38c1651bd01984236/2017/11/file_example_MP3_5MG.mp3"
    
    let anotherUrl = "https://traffic.libsyn.com/saskapriest/homily-bishopmark-20231001.mp3"
    
    @State var opacity: Double = 1
    @State var currentBackground = 0
    
    
    @State var startingOffsetX: CGFloat = UIScreen.main.bounds.width * 0
    @State var endingOffsetX: CGFloat = 0
    
    let array = ["avatar","avatar","avatar","avatar", "avatar","avatar","avatar","avatar"]
    
var body: some View {
        ZStack {
            GeometryReader {
                geo in
                Image(array[currentBackground])
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(2)
                    .blur(radius: 50)
                    .animation(.easeIn(duration: 1), value: currentBackground)
            }
            .ignoresSafeArea()
            
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 10) {
                            Color.clear
                                .frame(width: (UIScreen.main.bounds.size.width/8))
                            
                            ForEach(Array(0..<7), id: \.self) { id in
                                GeometryReader { geometry in
                                    ZStack(alignment: .center) {
                                        Image(String(array[id]))
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding(.horizontal, 4)
                                            .frame(width: UIScreen.main.bounds.size.width * 0.7)
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
                                    .opacity(vm.getScrollOpacity(geometry: geometry))
                                    .scaleEffect(y:vm.getScrollOpacity(geometry: geometry))
                                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged{ value in
                                            withAnimation(.spring()) {
                                                vm.currentDragOffsetX = value.translation.width
                                            }
                                        }
                                        .onEnded({_ in
                                            currentBackground = vm.scrollto(id: id, offsetX:  vm.currentDragOffsetX)
                                            withAnimation {
                                                scrollProxy.scrollTo(vm.scrollto(id: id, offsetX: vm.currentDragOffsetX), anchor: .center)
                                                vm.scrollFlag = vm.scrollFlag(id: id, offsetX: vm.currentDragOffsetX)
                                                if vm.scrollFlag {
                                                    vm.setUpTimer()
                                                } else {
                                                    vm.currentDragOffsetX = 0
                                                }
                                            }
                                            
                                        }))
                                }
                                .frame(width: 280, height: 240)
                            }

                            Color.clear
                                .frame(width: (UIScreen.main.bounds.size.width - 70) / 2.0)
                        }
                        .padding(.bottom, -20)
                    }
                }
                VStack {
                    Text("Track")
                        .font(.title)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                    Text("Author")
                        .font(.body)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                }
                .offset(y: -40)
                if self.player.itemDuration > 0 {
                    VStack(alignment: .trailing) {
                        Slider(value: self.$player.displayTime, in: (0...self.player.itemDuration), onEditingChanged: {
                            (scrubStarted) in
                            if scrubStarted {
                                self.player.scrubState = .scrubStarted
                            } else {
                                self.player.scrubState = .scrubEnded(self.player.displayTime)
                            }
                        })
                        HStack {
                            Text(vm.durationFormatter.string(from: self.player.displayTime) ?? "")
                            Text("/")
                            Text(vm.durationFormatter.string(from: self.player.itemDuration) ?? "")
                        }
                        .foregroundColor(Pallete.Other.deepPurpleText)
                        .opacity(0.8)
                    }
                    .padding()
                }
                
                Button(action: {
                    switch self.player.timeControlStatus {
                    case .paused:
                        self.player.play()
                    case .waitingToPlayAtSpecifiedRate:
                        self.player.pause()
                    case .playing:
                        self.player.pause()
                    @unknown default:
                        fatalError()
                    }
                }) {
                    Image(systemName: self.player.timeControlStatus == .paused ? "play" : "pause")
                        .imageScale(.large)
                        .scaleEffect(1.5)
                        .frame(width: 64, height: 64)
                }
                    .padding(.vertical, 30)
                PlayControl()
                    .padding()
                Button("Change track") {
                    track.toggle()
                    player.avPlayer.replaceCurrentItem(with: AVPlayerItem(url: track ? URL(string: url)! : URL(string: anotherUrl)!))
                }
            }
        }
    }
}
  
struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
