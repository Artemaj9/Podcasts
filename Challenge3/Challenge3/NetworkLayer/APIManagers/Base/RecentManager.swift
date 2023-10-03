//
//  RecentManager.swift
//

import Foundation
import PodcastIndexKit

@MainActor
final class RecentManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call returns all recent podcast in reversed order. With optional category use
    
    func performRecentPodcasts(max: Int, category: String?, debug: Bool = false) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().recentService.recentFeeds(
                max: max,
                cat: category,
                pretty: debug
            )
            return result.feeds
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - This call returns the most recent max number of episodes globally across the whole index, in reverse chronological order
    
    func performRecentEpisodes(max: Int, debug: Bool = false) async -> [Episode]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().recentService.recentEpisodes(
                max: max,
                pretty: debug
            )
            return result.items
        }
        catch {
            return nil
        }
    }
    
    // MARK: - This call returns every new feed added to the index over the past 24 hours in reverse chronological order
    
    func performNewPodcasts(max: Int) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().recentService.recentNewFeeds(max: max)
            return result.feeds
        }
        catch {
            return nil
        }
    }
}
