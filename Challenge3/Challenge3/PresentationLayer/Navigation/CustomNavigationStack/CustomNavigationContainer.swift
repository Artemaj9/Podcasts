//
//  CustomNavigationContainer.swift
//

import SwiftUI

// MARK: each view(screen) must be signed under this protocol
protocol ItemView: View {
    var listener: CustomNavigationContainer? { get set }
}

protocol CustomNavigationContainer {
    func push<Content: View & ItemView>(view: Content)
    func pop() // на экран назад
    func popToRoot() // удаляет все вьюхи из навигейшн стека
}

// MARK: - this is just a view, which contains every view in app
struct NavigationContainer<Content: View & ItemView>: View, CustomNavigationContainer {
    // в таб баре под каждую вкладку свой навигейшн контейнер

    @ObservedObject var viewModel: CustomNavigationViewModel
    private var content: Content

    init(viewModel: CustomNavigationViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content()
        self.content.listener = self
    }

    var body: some View {
        let isRoot = viewModel.currentScreen == nil

        ZStack {
            if isRoot {
                content
            } else {
                viewModel.currentScreen?.screen
                    .transition(
                        viewModel.animationDirection == .forward ? .move(edge: .leading) : .move(edge: .trailing)
                    ) // MARK: animation
            }
        }
        .animation(.default, value: viewModel.currentScreen)
        .padding(.bottom, -10)
    }
    // MARK: - these methods are used for making navigation in the app
    func push<Content>(view: Content) where Content: ItemView {
        var newView = view
        newView.listener = self
        self.viewModel.push(newView.toAny())
    }

    func pop() {
        self.viewModel.pop()
    }

    func popToRoot() {
        self.viewModel.popToRoot()
    }
}
