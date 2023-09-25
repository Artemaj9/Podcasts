//
//  CustomNavigationViewModel.swift
//

import SwiftUI

enum NavigationType { // MARK: navigation actions
    case pop, push, popToRoot
}

enum AnimationDirection { // MARK: animation directions
    case none
    case forward
    case backward
}

class CustomNavigationViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    @Published var animationDirection: AnimationDirection = .none
    @Published var isRootView: Bool = true
    public var navigationType: NavigationType = .push

    var screenStack: CustomNavigationStack = CustomNavigationStack() {
        didSet {
            withAnimation {
                currentScreen = screenStack.top() // MARK: current screen with animation
            }
        }
    }
// MARK: - navigation actions
    public func push(_ screenView: AnyView) {
        self.navigationType = .push
        let screen = Screen(screen: screenView)
        self.screenStack.push(screen)
        self.isRootView = self.screenStack.count == 0  // Update isRootView when pushing a view
    }

    public func pop() {
        self.navigationType = .pop
        self.screenStack.pop()
        self.isRootView = self.screenStack.count == 0  // Update isRootView when popping a view
    }

    public func popToRoot() {
        self.navigationType = .pop
        self.screenStack.popToRoot()
        self.isRootView = true  // Update isRootView when popping to root
    }
}
