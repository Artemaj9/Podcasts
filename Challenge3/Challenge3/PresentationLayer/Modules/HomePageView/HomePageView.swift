//
//  HomePageView.swift
//

import SwiftUI

struct HomePageView: View, ItemView {

    // MARK: - Internal Properties

    var listener: CustomNavigationContainer?

    // MARK: - Property Wrapper

    @State private var selectedCategory: Int = 0

    // MARK: - Private Properties

    var strings = Localizable.HomePage.self
    var categoriesStrings = Localizable.HomePage.Categories.self

    // MARK: - Private View Properties

    private var titleRow: some View {
        HStack {
            CustomLabel(labelText: "Abigael Amaniah", additionalText: "Love,life and chill", labelStyle: .homepage, epsText: "")
            Spacer()
            CustomImage(
                imageString: "",
                width: 48, height: 48
            )
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        }
        .padding(.horizontal, 32)
    }

    private var categoryAndSeeAllRow: some View {
        HStack {
            Text(strings.category)
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            Text(strings.seeAll)
                .foregroundColor(Pallete.Gray.forText)
                .font(.system(size: 16))
                .onTapGesture {
                    // TODO: - Add Navigation
                }
        }
        .padding(.horizontal, 32)
        .padding(.top)
    }

    private var categoryItemsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 24, height: 0)
                ForEach(0..<100) { index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Pallete.Other.pink)
                        .frame(width: 144, height: 200)
                        .overlay {
                            createCategoryCell()
                        }
                }
            }
        }
    }

    private var categorySelectionView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                CategoryTabView(selectedCategory: $selectedCategory, data: [
                    categoriesStrings.popular,
                    categoriesStrings.recent,
                    categoriesStrings.music,
                    categoriesStrings.design
                ])
            }
        }
    }

    private var categorizedRows: some View {
        Group {
            switch selectedCategory {
            case 0:
                VStack(spacing: 16) {
                    ForEach(0..<30) { index in
                        FilledWideCell(mainLeft: "Ngobam", mainRight: "Gofar Hilman", secondLeft: "Music & Fun", secondRight: "23 Eps", iconMode: .like)
                    }
                }
                .padding(.horizontal, 32)
            case 1:
                Text("recent")
            case 2:
                Text("music")
            case 3:
                Text("Design")
            default:
                Text("unknown")
            }
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {

            VStack(spacing: 16) {
                categoryAndSeeAllRow
                VStack(spacing: 24) {
                    categoryItemsRow
                    categorySelectionView
                }
                categorizedRows
            }

        }
        .makeCustomNavBar {
            titleRow
        }
    }

    // MARK: - Functions

    @ViewBuilder private func createCategoryCell() -> some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 12)
                .fill(Pallete.BlackWhite.white.opacity(0.6))
                .frame(width: 144, height: 64)
                .overlay {
                    VStack(alignment: .leading) {
                        CustomLabel(labelText: "Music & Fun", additionalText: "84 Podcast", epsText: "")
                    }
                }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
