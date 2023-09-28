//
//  SearchView.swift
//

import SwiftUI

struct SearchView: View, ItemView {
    var listener: CustomNavigationContainer?
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -8, alignment: nil),
        GridItem(.flexible(), spacing: -8, alignment: nil)]
    let aspectRatio = 0.57
    let padding: CGFloat = 16
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundSearchView()
                VStack(spacing: 4) {
                    Text("Search")
                        .fontWeight(.semibold)
                        .padding(.vertical, 20)
                    
                    SearchBarView(searchText: "", placeholder: "Podcasts, chanell or artist", backgroundColor: Pallete.BlackWhite.white)
                    HStack {
                        Text("Top Genres")
                            .fontWeight(.semibold)
                        Spacer()
                        Button {
                        } label: {
                            Text("See all")
                                .foregroundColor(Pallete.Gray.forText)
                        }
                    }
                    .offset(y: 16)
                    .padding(.horizontal, 28)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            GenresButton(title: "Comedy", backgroundColor: .cyan,
                                         hSize: geometry.size.width*0.4) {}
                            GenresButton(title: "Music and chill", backgroundColor: .brown,   hSize: geometry.size.width*0.4) {}
                            GenresButton(title: "Funny life", backgroundColor: .yellow,   hSize: geometry.size.width*0.4) {}
                            GenresButton(title: "Sports", backgroundColor: .green,   hSize: geometry.size.width*0.4) {}
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 24)
                        
                    }
                    Spacer()
                    HStack {
                        Text("Browse all")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 28)
                    VStack {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(
                                columns: columns,
                                alignment: .center,
                                spacing: 0,
                                content: {
                                    ForEach(0..<40) { index in
                                        GeometryReader { geo2 in
                                            GenresButton(title: "Sports", backgroundColor: .green,   hSize: geometry.size.width*0.4) {}
                                                .opacity(getScrollOpacity(geometry: geo2))
                                            
                                        }
                                        .frame(width: geometry.size.width*0.4, height: geometry.size.width*0.4*aspectRatio + padding, alignment: .center)
                                    }
                                })
                        }
                        .padding(.horizontal, 12)
                    }
                    .padding(.leading, -2)
                    .padding(.trailing, 10)
                        
                }
                .padding(.top, 44)
            }
            .ignoresSafeArea()
        }
    }
    
    func getScrollOpacity(geometry: GeometryProxy) -> Double {
        let maxY = UIScreen.main.bounds.height
        
        // Координата верхней границы контейнера
        let currentY = geometry.frame(in: .global).minY
        
        let opacity: Double
        
        //координата, с которой начинает убывать прозрачнотсь
        let yInitial = 0.48*maxY
        
        // координата, на которой прозрачность становится нулевой
        let yFinal = 0.43*maxY
        
        // угловой коэффициент линейной зависимости
        let k = 1 / (yInitial - yFinal)
        
        // свободный коэффициент в линейной зависимости
        let b = -k*yFinal
        
        if currentY > yInitial {
            opacity = 1
        } else {
            opacity = k * currentY + b
        }
        return opacity
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
