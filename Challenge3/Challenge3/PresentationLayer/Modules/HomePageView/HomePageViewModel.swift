//
//  HomePageViewModel.swift
//

import Foundation
import CoreData
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
    @Published var favoritePodcasts: [FavoritePodcast] = []
    
    private var categoryManager: CategoryManager?
    private var podcastManager: PodcastManager?
    private var recentManager: RecentManager?
    private var episodeManager: EpisodeManager?
    private var randomCat: String? = nil
    private var viewContext: NSManagedObjectContext
    
    init() {
        self.viewContext = FavoritesDataManager.shared.viewContext
        Task {
            self.categoryManager = await CategoryManager()
            self.episodeManager = await EpisodeManager()
            self.podcastManager = await PodcastManager()
            self.recentManager = await RecentManager()
            self.getCategories()
            self.getPodcastsByCategory(categoryName: categories[selectedCategory])
            self.getRandomPodcasts()
        }
        self.fetchFavoriteData()
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
        let isFavorite = self.favoritePodcasts.map { Int($0.id) }.contains(podcast.id)

        cellData = CellData(
            id: podcast.id,
            guid: podcast.podcastGuid,
            iconState: isFavorite,
            mainLeft: podcast.title,
            mainRight: nil,
            secondLeft: podcast.categories?.values.first,
            secondRight: nil,
            image: podcast.image,
            iconMode: .like,
            height: nil
        )
        
        return cellData
    }

    func addFavorite(podcastId: Int) {
        let podcast = FavoritePodcast(context: viewContext)
        podcast.id = Int64(podcastId)
        do {
            try viewContext.save()
        }
        catch {
        }
    }

    func removeFavorite(podcastId: Int) {
        if let object = getObject(podcastId: podcastId) {
            viewContext.delete(object)
            do {
                try viewContext.save()
            }
            catch {
            }
        }
    }

    func getObject(podcastId: Int) -> FavoritePodcast? {
        let fetchRequest: NSFetchRequest<FavoritePodcast> = FavoritePodcast.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [Int64(podcastId)])
        do {
            let object = try viewContext.fetch(fetchRequest).first
            return object
        }
        catch {
            return nil
        }
    }


    func fetchFavoriteData() {
        let request = NSFetchRequest<FavoritePodcast>(entityName: "FavoritePodcast")
        do {
            self.favoritePodcasts = try viewContext.fetch(request)
        } catch {
        }
    }
}
