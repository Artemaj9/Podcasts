//
//  FavoritesViewModel.swift
//

import Foundation
import PodcastIndexKit

final class FavoritesViewModel: ObservableObject {
    @Published var podcasts: [Podcast]?
    
    private var podcastManager: PodcastManager?
    
    init() {
        Task {
            self.podcastManager = await PodcastManager()
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
}
