//
//  BackgroundSearchView.swift
//

import SwiftUI

struct BackgroundSearchView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors:[ Pallete.OtherLight.slightGreen.opacity(0.6),Pallete.OtherLight.pink.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)
            RadialGradient(colors: [Pallete.OtherLight.slightGreen, Pallete.BlackWhite.white.opacity(0.1)], center: .topLeading, startRadius: 50, endRadius: 300)
            RadialGradient(colors: [Pallete.OtherLight.slightPink, Pallete.BlackWhite.white.opacity(0.1)], center: .topTrailing, startRadius: 30, endRadius: 250)
         
        }
        .ignoresSafeArea()
    }
}

struct BackgroundSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSearchView()
    }
}
