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
                    
                    ForEach(0..<data.count, id:\.self) { index in
                        CategoryButton(
                            title: data[index],
                            isSelected: selectedCategory == index
                        ) {
                            withAnimation {
                                selectedCategory = index
                                
                                if index == data.count - 1 {
                                    scrollViewProxy.scrollTo(index, anchor: .trailing)
                                } else {
                                    scrollViewProxy.scrollTo(index, anchor: .center)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CategoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTabView(selectedCategory: .constant(1), data: ["Category 1", "Category 2", "Category 3", "Category 4"])
    }
}

struct CategoryButton: View {
    var title: String
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        Text(title)
            .font(.title)
            .foregroundColor(isSelected ? Color.black : Pallete.Gray.forText)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(
                   RoundedRectangle(cornerRadius: 8)
                       .strokeBorder(isSelected ? Pallete.Gray.forNext: Color.clear, lineWidth: 0.5)
                       .background(isSelected ? Pallete.Others.white : Pallete.Gray.forPhotoCells)
               )
            .onTapGesture(perform: onTap)
    }
}

