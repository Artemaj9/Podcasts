//
//  PlayControl.swift
//

import SwiftUI

struct PlayControl: View {
    
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
                
                Spacer()
                
                Button{
                    shuffleAction()
                } label: {
                    Image(Images.AudioPlaying.shuffle.rawValue)
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
                    Image(Images.AudioPlaying.playFill.rawValue)
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
                }
                
                Spacer()
                
            }
        }
    }
}



