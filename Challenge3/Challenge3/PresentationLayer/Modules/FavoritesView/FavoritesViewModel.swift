//
//  FavoritesViewModel.swift
//

import Foundation
import CoreData
import PodcastIndexKit

@MainActor
final class FavoritesViewModel: ObservableObject {

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

    private func searchFavoritePodcasts() async {
        var fetchedPodcasts: [Podcast] = []
        let favoritePodcastsIds = getFavoritePodcastsIds()!
        for id in favoritePodcastsIds {
            let newFetchedPodcast = await podcastManager!.getPodcastData(podcastID: id)
            //dump("DEBUG: new fetched podcasts: \(newFetchedPodcast)")
            fetchedPodcasts.append(newFetchedPodcast!)
        }
        print("DEBUG: fetchedPodcasts count \(fetchedPodcasts.count)")
        favoriteNetworkPodcasts = fetchedPodcasts
    }

    private func getFavoritePodcastsIds() -> [Int]? {
        if let favoritePodcasts = getPodcasts() {
            let favoritePodcastsIds = favoritePodcasts.map { Int($0.id) }
            dump("DEBUG: favorite podcasts ids: \(favoritePodcastsIds)")
            return favoritePodcastsIds
        } else {
            return nil
        }
    }

    private func getPodcasts() -> [FavoritePodcast]? {
        let fetchRequest: NSFetchRequest<FavoritePodcast> = FavoritePodcast.fetchRequest()
        do {
            let objects = try viewContext.fetch(fetchRequest)
//            dump("DEBUG: fetched objects \(objects)")
            return objects
        }
        catch {
            print("DEBUG: error while getting objects")
            return nil
        }
    }

}
