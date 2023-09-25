//
//  OnboardingView.swift
//

import SwiftUI

struct OnboardingView: View, ItemView {

    // MARK: - Property Wrappers
    @StateObject var onboardingViewModel = OnboardingViewModel()

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    var currentIndex: Int {
        onboardingViewModel.currentIndex
    }
    var currentImageName: String {
        OnboardingModel.onboardingImages[self.currentIndex]
    }
    var currentTitle: String {
        OnboardingModel.onboardingTitles[self.currentIndex]
    }
    var currentText: String {
        OnboardingModel.onboardingTexts[self.currentIndex]
    }

    // MARK: - Private Properties
    private var strings = Localizable.Onboarding.self

    // MARK: - View Builders
    @ViewBuilder func onboardingBottomBar() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(currentTitle)
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            Text(currentText)
                .font(.system(size: 15))
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            VStack(spacing: 20) {
                HStack {
                    if onboardingViewModel.currentIndex == 2 {
                        Spacer()
                        Text(strings.getStarted)
                            .foregroundColor(.white)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 16)
                            .background(Pallete.Blue.forAccent)
                            .cornerRadius(16)
                            .onTapGesture {
                                withAnimation {
                                    // TODO: Dismiss OnboardingView
                                }
                            }
                        Spacer()
                    } else {
                        Group {
                            Text(strings.skip)
                                .font(.system(size: 17, weight: .semibold))
                                .onTapGesture {
                                    withAnimation {
                                        // TODO: Dismiss OnboardingView
                                    }
                                }
                            Spacer()
                            Text(strings.next)
                                .padding(16)
                                .background(.white)
                                .cornerRadius(20)
                                .onTapGesture {
                                    withAnimation {
                                        if onboardingViewModel.currentIndex <= 1 {
                                            self.onboardingViewModel.currentIndex += 1
                                        } else {
                                            // TODO: Dismiss OnboardingView
                                        }
                                    }
                                }
                        }
                    }
                }
                OnboardingIndicator(selectedIndex: $onboardingViewModel.currentIndex)
            }
        }
        .padding(30)
        .background(Pallete.Blue.forOnboarding)
        .cornerRadius(30)
    }

    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Image(currentImageName)
            Spacer()
            onboardingBottomBar()
        }
        .padding(.horizontal, 30)
        .frame(idealWidth: 320)
    }

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
