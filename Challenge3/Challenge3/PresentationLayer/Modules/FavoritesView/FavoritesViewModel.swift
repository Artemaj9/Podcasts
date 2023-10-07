//
//  FavoritesViewModel.swift
//

import Foundation
import CoreData
import PodcastIndexKit

@MainActor
final class FavoritesViewModel: ObservableObject {
  
    @Published var podcasts: [Podcast]?
    @Published var favoriteNetworkPodcasts: [Podcast] = []

    private var podcastManager: PodcastManager?
    private var episodeManager: EpisodeManager?
    private var viewContext: NSManagedObjectContext

    init() {
        self.viewContext = FavoritesDataManager.shared.viewContext
        self.podcastManager = PodcastManager()
        self.episodeManager = EpisodeManager()
        searchFavoritePodcastsFromIndexKit()
    }

    func searchFavoritePodcastsFromIndexKit() {
        Task {
            await searchFavoritePodcasts()
        }
    }
  
    func getPodcastsFromCategory(category: String) {
        Task {
            if let data = await podcastManager?.performTrendingPodcasts(max: 10, category: category) {
                DispatchQueue.main.async { [weak self] in
                    self?.podcasts = data
                }
            }
        }
    }

    private func searchFavoritePodcasts() async {
        var fetchedPodcasts: [Podcast] = []
        let favoritePodcastsIds = getFavoritePodcastsIds()!
        for id in favoritePodcastsIds {
            let newFetchedPodcast = await podcastManager!.getPodcastData(podcastID: id)
            fetchedPodcasts.append(newFetchedPodcast!)
        }
        favoriteNetworkPodcasts = fetchedPodcasts
    }

    private func getFavoritePodcastsIds() -> [Int]? {
        if let favoritePodcasts = getPodcasts() {
            let favoritePodcastsIds = favoritePodcasts.map { Int($0.id) }
            return favoritePodcastsIds
        } else {
            return nil
        }
    }

    private func getPodcasts() -> [FavoritePodcast]? {
        let fetchRequest: NSFetchRequest<FavoritePodcast> = FavoritePodcast.fetchRequest()
        do {
            let objects = try viewContext.fetch(fetchRequest)
            return objects
        }
        catch {
            return nil
        }
    }
}
