//
//  MiniPlayer.swift
//

import SwiftUI
import Kingfisher

struct MiniPlayer: View {
    @Binding var progress: Double
    @Binding var isPlaying: Bool
    @Binding var imageString: String
    let width: CGFloat
    let height: CGFloat
    let title: String
    let podcastColor: Color
    
    var prevTrack: () -> Void
    var play: () -> Void
    var nextTrack: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 1)
                        .foregroundColor(Pallete.Blue.forAccent)
                        .frame(width: (width - 20)*progress)
                        .animation(.easeIn, value: progress)
                }
                .frame(width: width - 20, height: 3)
                .padding(.top, 4)
                .gesture(DragGesture(minimumDistance: 0).onEnded({ value in
                    progress = value.location.x/(width - 20)
                }))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width, height: height)
                    .foregroundColor(Pallete.Blue.forOnboarding)
            }
            HStack(spacing: 10) {
                if !imageString.isEmpty {
                    KFImage(URL(string: imageString))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.63 * height, height: 0.63 * height)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .frame(width: 0.63*height, height: 0.63*height)
                        .foregroundColor(podcastColor)
                        .padding(.leading, 8)
                }
                
                Text(title)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.8)
                
                Spacer()
                
                HStack(spacing: 14) {
                    Button {
                        prevTrack()
                    } label: {
                        Image(Images.AudioPlaying.previous.rawValue)
                    }
                    Button {
                        play()
                    } label: {
                        Image(Images.AudioPlaying.play.rawValue)
                    }
                    Button {
                        nextTrack()
                    } label: {
                        Image(Images.AudioPlaying.next.rawValue)
                    }
                }
                .padding(.trailing, 8)
            }
        }
        .frame(width: width, height: height)
    }
}
