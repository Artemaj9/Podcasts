//
//  SearchViewModel.swift
//

import SwiftUI
import PodcastIndexKit

@MainActor
final class SearchViewModel: ObservableObject {

    // MARK: - Property Wrappers

    @Published var categories = [String]()
    @Published var podcasts: [Podcast]?
    @Published var trending: [Podcast]?
    @Published var trendingPodcasts: [Podcast]?
    @Published var podcastTitles = [String]()
    @Published var podcastFromCategory: [Podcast]?

    // MARK: - Private Properties

    private var searchManager: SearchManager?
    private var categoryManager: CategoryManager?
    private var podcastManager: PodcastManager?

    // MARK: - Functions

    init() {
        self.searchManager =  SearchManager()
        self.categoryManager = CategoryManager()
        self.podcastManager = PodcastManager()
    }

    func getPodcasts(searchText: String) {
        Task {
            podcasts = await searchManager?.performSearchByTerm(
                term: searchText, max: 10, debug: true
            )
        }
    }
        
    func getTrendingPodcasts(max: Int) {
        Task {
            trendingPodcasts = await podcastManager?.performTrendingPodcasts(
                max: 20, category: nil
            )
        }
    }

    func getCategories() {
        Task {
            if let categoryList = await categoryManager?.getCategoryList() {
                DispatchQueue.main.async { [weak self] in
                    if let items = categoryList.feeds {
                        let podcastCategories = items.map { item in
                            LocalCategory(id: item.id, name: item.name)
                        }
                        for i in podcastCategories {
                            if let catName = i.name {
                                self?.categories.append(catName)
                            }
                        }
                    }
                }
            }
        }
    }

    func getPodcastsByCategory(categoryName: String) {
        Task {
            if let data = await podcastManager?.performTrendingPodcasts(
                max: 10, category: categoryName
            ) {
                DispatchQueue.main.async { [weak self] in
                    self?.podcastFromCategory = data
                }
            }
        }
    }

    func convertDataToCellData(podcast: Podcast) -> CellData {
        var cellData: CellData

        cellData = CellData(
            id: podcast.id,
            guid: podcast.podcastGuid,
            iconState: false,
            mainLeft: podcast.title,
            mainRight: podcast.author,
            secondLeft: podcast.categories?.values.first,
            secondRight: "\(podcast.episodeCount ?? 1) Eps",
            image: podcast.image,
            iconMode: .blank,
            height: nil
        )

        return cellData
    }
}
