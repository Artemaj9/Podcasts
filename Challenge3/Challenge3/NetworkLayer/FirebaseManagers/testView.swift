//
//  testView.swift
//

// DELETE AFTER INTEGRATING ON VIEWS

import SwiftUI
import Combine
import AuthenticationServices
import PodcastIndexKit

struct testView: View, ItemView {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var apiModel: SearchManager
    @EnvironmentObject var categoryManager: CategoryManager
    @Environment(\.dismiss) var dismiss
    
    @State var podcasts: [Podcast]?
    @State var categories: CategoriesResponse?
    @State var searchString = ""
    
    var listener: CustomNavigationContainer?
    
    private func getPodcasts() {
        Task {
            podcasts = await apiModel.performSearchByTerm(term: searchString, max: 10, debug: true)
        }
    }
    
    private func getCategories() {
        Task {
            print("1")
            categories = await categoryManager.getCategoryList()
            print(categories?.feeds?.first?.name ?? "noData")
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("Search", text: $searchString)
            
            Button {
                getCategories()
            } label: {
                Text("get podcasts")
            }
                        
            if let items = categories {
                ScrollView {
                    ForEach(items.feeds!, id: \.id) { item in
                        Text(item.name ?? "")
                    }
                }
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
