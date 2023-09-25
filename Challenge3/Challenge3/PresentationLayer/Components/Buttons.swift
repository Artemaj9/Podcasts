//
//  Buttons.swift
//

import SwiftUI

struct Buttons: View {
    
    @State var select = false
    
    var body: some View {
        VStack {
            RoundedButton(action: {}, title: "Войти", font: .headline, width: 326, height: 57, isReverse: false,foregroundColor: .white,background: .blue,cornerRadius: 50,padding: 10)
           
        }
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
struct RoundedButton: View {
    var title: String
    var font: Font = .system(size: 16)
    var isReverse: Bool = false
    var foregroundColor: Color = .white
    var background: Color = .blue
    var cornerRadius: Double = 10
    var padding: Double = 16
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .padding(padding)
                .background(background)
                .foregroundColor(foregroundColor)
                .cornerRadius(cornerRadius)

        }
    }
}
