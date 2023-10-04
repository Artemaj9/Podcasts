//
//  HomePageViewModel.swift
//

import Foundation
import PodcastIndexKit

final class HomePageViewModel: ObservableObject {
    @Published var categories = ["Popular", "Recent"]
    @Published var newPodcasts: [Podcast]?
    @Published var podcastFromCategory: [Podcast]?
    @Published var selectedCategory: Int = 0 {
        didSet {
            getPodcastsByCategory(categoryName: categories[selectedCategory])
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
            self.getPodcastsByCategory(categoryName: categories[selectedCategory])
            self.getRandomPodcasts()
        }
    }
    
    func getRandomPodcasts() {
        // TODO: make for another function. Not trending
        Task {
            if categories.count > 2 {
                randomCat = categories[Int.random(in: 2..<categories.count)]
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
            if categoryName.isEmpty {
                //
            } else if categoryName == "Popular" {
                if let data = await podcastManager?.performTrendingPodcasts(max: 10, category: nil) {
                    DispatchQueue.main.async { [weak self] in
                        self?.podcastFromCategory = data
                    }
                }
            } else if categoryName == "Recent" {
                if let data = await recentManager?.performRecentPodcasts(max: 10, category: nil) {
                    DispatchQueue.main.async { [weak self] in
                        self?.podcastFromCategory = data
                    }
                }
            } else {
                if let data = await podcastManager?.performTrendingPodcasts(max: 10, category: categoryName) {
                    DispatchQueue.main.async { [weak self] in
                        self?.podcastFromCategory = data
                    }
                }
            }
        }
    }
    
    func convertDataToCellData(podcast: Podcast) -> CellData {
        var cellData: CellData

        // TODO: add boolean value from favorite db
        let isFavorite = false
        
        cellData = CellData(
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
        )
        
        return cellData
    }
}
