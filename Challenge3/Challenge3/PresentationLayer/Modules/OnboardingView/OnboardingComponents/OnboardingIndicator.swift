//
//  OnboardingIndicator.swift
//

import SwiftUI

struct OnboardingIndicator: View {

    // MARK: - Property Wrappers
    @Binding var selectedIndex: Int

    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Circle()
                    .fill(selectedIndex == index ? .gray : .white)
                    .frame(width: 6, height: 6)
            }
        }
    }
}

struct OnboardingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIndicator(selectedIndex: .constant(0))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
