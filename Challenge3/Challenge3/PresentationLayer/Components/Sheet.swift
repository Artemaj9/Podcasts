//
//  Sheet.swift
//


import SwiftUI

struct BottomSheet: View {
    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.thinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing.toggle() }
                content
                    .frame(height: UIScreen.main.bounds.height / 2.7)
                    .padding(.bottom, 42)
                    .transition(.move(edge: .bottom))
                    .background(Pallete.BlackWhite.white)
                    .customCornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
        .animation(.linear, value: isShowing)
    }
}

extension View {
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
