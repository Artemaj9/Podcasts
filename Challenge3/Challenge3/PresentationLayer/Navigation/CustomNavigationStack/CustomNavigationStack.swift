//
//  CustomNavigationStack.swift
//

import Foundation

// MARK: custom navigation stack model itself
public struct CustomNavigationStack {
    private var screens: [Screen] = [Screen]() //здесь хранятся экраны

    var count: Int {
        screens.count
    }

    func top() -> Screen? {
        self.screens.last
    }

    mutating func push(_ screen: Screen) {
        self.screens.append(screen)
    }

    mutating func pop() {
        _ = self.screens.popLast()
    }

    mutating func popToRoot() {
        self.screens.removeAll()
    }
}
