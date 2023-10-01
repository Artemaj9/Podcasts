//
//  PodcastManager.swift
//

import Foundation
import PodcastIndexKit

@MainActor
final class PodcastManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call returns everything we know about the feed from the feed's GUID. The GUID is a unique, global identifier for the podcast.
    
    func getPodcastData(podcastID: String, debug: Bool = false) async -> Podcast? {
        do {
            let result = try await PodcastIndexKit().podcastsService.podcast(
                byGuid: podcastID,
                pretty: debug
            )
            return result.feed
        }
        catch {
            return nil
        }
    }
    
    // MARK: - This call returns popular podcasts. With optional category use
    
    func performTrendingPodcasts(max: Int, category: String?, debug: Bool = false) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().podcastsService.trendingPodcasts(
                max: max,
                cat: category,
                pretty: debug
            )
            return result.feeds
        }
        catch {
            return nil
        }
    }
}
