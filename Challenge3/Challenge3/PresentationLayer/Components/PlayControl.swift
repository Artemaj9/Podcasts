//
//  PlayControl.swift
//

import SwiftUI

struct PlayControl: View {
    @Binding var isPlaying: Bool
    @Binding var isRandom: Bool
    @Binding var isRepeated: Bool
    
    // MARK: - Internal Properties
    var shuffleAction:  () -> Void
    var previousAction:  () -> Void
    var playAction:  () -> Void
    var nextAction:  () -> Void
    var repeatAction:  () -> Void
    
    // MARK: - Body
    var body: some View {
        Group{
            HStack(){
                Group {
                    Spacer()
                    
                    Button{
                          shuffleAction()
                    } label: {
                        Image(Images.AudioPlaying.shuffle.rawValue)
                            .foregroundColor(isRandom ? Pallete.Other.purple : Pallete.Other.blue)
                    }
                }
                Spacer()
                
                Button{
                    previousAction()
                } label: {
                    Image(Images.AudioPlaying.priviousFill.rawValue)
                }
                
                Spacer()
                
                Button{
                    playAction()
                } label: {
                    Image(isPlaying ? Images.AudioPlaying.playFill.rawValue : Images.AudioPlaying.play.rawValue)
                }
                
                Spacer()
                
                Button{
                    nextAction()
                } label: {
                    Image(Images.AudioPlaying.nextFill.rawValue)
                }
                
                Spacer()
                
                Button{
                    repeatAction()
                } label: {
                    Image(Images.AudioPlaying.repeatTrack.rawValue)
                        .foregroundColor(isRepeated ? Pallete.Other.purple : Pallete.Other.blue)
                }
                
                Spacer()
            }
        }
    }
}



