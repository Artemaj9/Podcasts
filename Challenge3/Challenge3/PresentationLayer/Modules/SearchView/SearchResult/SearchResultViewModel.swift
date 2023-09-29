//
//  SearchResultViewModel.swift
//

import SwiftUI

final class SearchResultViewModel: ObservableObject {
    
    func getScrollOpacity(geometry: GeometryProxy) -> Double {
        let maxY = UIScreen.main.bounds.height
        
        // Координата верхней границы контейнера
        let currentY = geometry.frame(in: .global).minY

        let opacity: Double
        
        //координата, с которой начинает убывать прозрачнотсь
        let yInitial = 0.9*maxY
        let yInitial2 = 0.2*maxY
        
        // координата, на которой прозрачность становится нулевой
        let yFinal = maxY
        let yFinal2 = 0.05*maxY
        
        // угловой коэффициент линейной зависимости
        let k = 1 / (yInitial - yFinal)
        let kTop = 1 / (yInitial2 - yFinal2)
        
        // свободный коэффициент в линейной зависимости
        let b = -k*yFinal
        let bTop = -kTop*yFinal2
        
        if currentY < yInitial && currentY > yInitial2 {
            opacity = 1
        } else if currentY >= yInitial {
            opacity = k * currentY + b
        } else  {
            opacity = kTop * currentY + bTop
        }
            
        return opacity
    }
}
