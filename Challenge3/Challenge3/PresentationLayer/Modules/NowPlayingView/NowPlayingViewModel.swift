//
//  NowPlayingViewModel.swift
//

import SwiftUI
import Combine

final class NowPlayingViewModel: ObservableObject {
    @ObservedObject var player = PlayerViewModel.shared
    
    @Published var currentDragOffsetX:CGFloat = 0
    @Published var count: CGFloat = 0
    @Published var currentBackground: Int = 0
    @Published var scrollFlag = false
    @Published var cancellables = Set<AnyCancellable>()
    
    func getScrollOpacity(geometry: GeometryProxy) -> Double {
        let maxX = UIScreen.main.bounds.width
        
        // Координата верхней границы контейнера
        let currentX = geometry.frame(in: .global).midX
        
        let opacity: Double
        
        //координата, с которой начинает убывать прозрачнотсь
        let xInitial = maxX
        let xInitial2 = 0*maxX
        
        // координата, на которой прозрачность становится нулевой
        let xFinal = 1.7*maxX
        let xFinal2 = -0.7*maxX
        
        // угловой коэффициент линейной зависимости
        let k = 1 / (xInitial - xFinal)
        let kTop = 1 / (xInitial2 - xFinal2)
        
        // свободный коэффициент в линейной зависимости
        let b = -k*xFinal
        let bTop = -kTop*xFinal2
        
        if currentX < xInitial && currentX > xInitial2 {
            opacity = 1
        } else if currentX >= xInitial {
            opacity = k * currentX + b
        } else  {
            opacity = kTop * currentX + bTop
        }
        
        return opacity
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    func scrollto(id: Int, offsetX: CGFloat) -> Int {
        print("Scroll to id \(id), offset: \(offsetX)")
        var idToScroll: Int
        if offsetX > 100 {
            idToScroll = id != 0 ? id - 1 : id
        } else if abs(offsetX) <= 100  {
            idToScroll = id
        } else {
            idToScroll = id + 1
        }
        print("trying to set episode \(idToScroll)")
        player.setCurrentEpisode(index: idToScroll)
        return idToScroll
    }
    
    func scrollFlag(id: Int, offsetX: CGFloat) -> Bool {
        var flag: Bool
        if offsetX > 100 && id != 0 {
            flag = true
        } else if abs(offsetX) <= 100  {
            flag = false
        } else {
            flag = true
        }
        return flag
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                count += 1
                if count == 5 {
                    currentDragOffsetX = 0
                    if scrollFlag {
                        let currentEpisodeIndex = player.currentEpisodeIndex
                        let idToScroll = scrollto(id: currentEpisodeIndex, offsetX: currentDragOffsetX)
                        currentBackground = idToScroll
                    }
                }
                if count == 25 {
                    currentDragOffsetX = 0
                    count = 0
                    for item in cancellables {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func sendScrollToEpisodeNotification(episodeIndex: Int) {
        NotificationCenter.default.post(name: Notification.Name("ScrollToEpisode"), object: episodeIndex)
    }
}
