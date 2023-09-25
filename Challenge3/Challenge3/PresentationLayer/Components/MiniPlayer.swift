//
//  MiniPlayer.swift
//  Challenge3
//
//  Created by Artem on 25.09.2023.
//

import SwiftUI

struct MiniPlayer: View {
    @State var progress: Double = 0.7
    @State var isPlaying: Bool = false
    let width: CGFloat
    let height: CGFloat
    let title: String
    let podcastColor: Color
    
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
                    Circle()
                        .frame(width: 0.63*height, height: 0.63*height)
                        .foregroundColor(podcastColor)
                        .padding(.leading, 8)
                    Text(title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                    Spacer()
                    HStack(spacing: 14) {
                        Button {
                            print("Previous track")
                            // Add previous track function here!
                        } label: {
                            Image(Images.AudioPlaying.previous.rawValue)
                        }
                        Button {
                            print("Play")
                            isPlaying.toggle()
                            // Add Play function here!
                        } label: {
                          Image(Images.AudioPlaying.play.rawValue)
                        }
                        Button {
                            print("Next")
                            // Add next track function here!
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

struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayer(width: 324, height: 68, title: "Baby Pesut Eps 65", podcastColor: .pink.opacity(0.4))
    }
}
