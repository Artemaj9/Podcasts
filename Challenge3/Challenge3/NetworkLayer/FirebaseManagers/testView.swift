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
    @Environment(\.dismiss) var dismiss
    
    @State var podcasts: [Podcast]?
    @State var searchString = ""
    
    var listener: CustomNavigationContainer?
    
    private func getPodcasts() {
        Task {
            podcasts = await apiModel.performSearchByTerm(term: searchString, max: 10, debug: true)
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("Search", text: $searchString)
            
            Button {
                getPodcasts()
            } label: {
                Text("get podcasts")
            }
            
            if podcasts != nil {
                ScrollView {
                    ForEach(podcasts!, id: \.id) { item in
                        Text(item.link ?? "")
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
