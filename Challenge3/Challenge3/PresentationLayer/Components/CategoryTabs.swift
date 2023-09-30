//
//  CategoryTabs.swift
//

import SwiftUI

struct CategoryTabView: View {
    @Binding var selectedCategory: Int
    var data: [String]

    var body: some View {
        ScrollViewReader { scrollViewProxy in

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 32, height: 0)
                    ForEach(0..<data.count, id: \.self) { index in
                        CategoryButton(
                            title: data[index],
                            isSelected: selectedCategory == index
                        ) {
                            selectedCategory = index
                            withAnimation {
                                if index == data.count - 1 {
                                    scrollViewProxy.scrollTo(index, anchor: .trailing)
                                } else {
                                    scrollViewProxy.scrollTo(index, anchor: .center)
                                }
                            }
                        }
                        .id(index)
                    }
                }
            }
        }
    }
}

struct CategoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct CategoryButton: View {

    var title: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: isSelected ? .bold : .regular))
            .foregroundColor(isSelected ? Color.black : Pallete.Gray.forText)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .animation(.linear(duration: 0.1), value: isSelected)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(isSelected ? Pallete.Gray.forNext: Color.clear, lineWidth: 0.5)
            )
            .onTapGesture(perform: onTap)
    }
}
