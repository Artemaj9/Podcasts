//
//  HomePageViewModel.swift
//

import Foundation
import PodcastIndexKit

final class HomePageViewModel: ObservableObject {
    @Published var categories: CategoriesResponse?
    @Published var categories2 = ["Popular", "Recent"]
    @Published var newPodcasts: [Podcast]?
    @Published var podcastFromCategory: [CellData]?
    @Published var selectedCategory: Int = 0 {
        didSet {
            getPodcastsByCategory(categoryName: categories2[selectedCategory])
        }
    }
    
    private var categoryManager: CategoryManager?
    private var podcastManager: PodcastManager?
    private var recentManager: RecentManager?
    private var episodeManager: EpisodeManager?
    private var randomCat: String? = nil
    
    init() {
        Task {
            self.categoryManager = await CategoryManager()
            self.episodeManager = await EpisodeManager()
            self.podcastManager = await PodcastManager()
            self.recentManager = await RecentManager()
            self.getCategories()
            self.getPodcastsByCategory(categoryName: categories2[selectedCategory])
            self.getRandomPodcasts()
        }
    }
    
    func getRandomPodcasts() {
        // TODO: make for another function. Not trending
        Task {
            if categories2.count > 2 {
                randomCat = categories2[Int.random(in: 2..<categories2.count)]
            } else {
                getCategories()
                randomCat = "Arts"
            }
            if let podcasts = await podcastManager?.performTrendingPodcasts(max: 10, category: randomCat) {
                DispatchQueue.main.async { [weak self] in
                    self?.newPodcasts = podcasts
                }
            }
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
                                self?.categories2.append(catName)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getPodcastsByCategory(categoryName: String) {
        Task {
            if categoryName.isEmpty {
                //
            } else if categoryName == "Popular" {
                if let data = await podcastManager?.performTrendingPodcasts(max: 10, category: nil) {
                    convertDataToCellData(data: data)
                }
            } else if categoryName == "Recent" {
                if let data = await recentManager?.performRecentPodcasts(max: 10, category: nil) {
                    convertDataToCellData(data: data)
                }
            } else {
                if let data = await podcastManager?.performTrendingPodcasts(max: 10, category: categoryName) {
                    convertDataToCellData(data: data)
                }
            }
        }
    }
    
    private func convertDataToCellData(data: [Podcast]) {
        var cellDataArray: [CellData] = []

        for podcast in data {
            // TODO: add boolean value from favorite db
            let isFavorite = false
            
            cellDataArray.append(CellData(
                id: podcast.id,
                guid: podcast.podcastGuid,
                iconState: isFavorite,
                mainLeft: podcast.title,
                mainRight: podcast.author,
                secondLeft: podcast.categories?.values.first,
                secondRight: "\(podcast.episodeCount ?? 1) Eps",
                image: podcast.image,
                iconMode: .like,
                height: nil
            ))
        }

        DispatchQueue.main.async { [weak self] in
            self?.podcastFromCategory = cellDataArray
        }
    }
}
