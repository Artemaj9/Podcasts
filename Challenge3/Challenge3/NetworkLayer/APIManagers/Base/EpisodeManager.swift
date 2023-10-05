//
//  EpisodeManager.swift
//

import Foundation
import PodcastIndexKit

@MainActor
final class EpisodeManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call returns all the episodes we know about for this feed from the Podcast GUID
    
    func performEpisodesSearch(podcastID: String, debug: Bool = false) async -> [Episode]? {
        do {
            let result = try await PodcastIndexKit().episodesService.episodes(
                byFeedID: podcastID,
                pretty: debug
            )
            return result.items
        }
        catch {
            return nil
        }
    }
    
    // MARK: - Get all episodes that have been found in the podcast:liveitem from the feeds
    
    func performLiveEpisodes(max: Int, debug: Bool = false) async -> [Episode]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().episodesService.liveEpisodes(
                max: max,
                pretty: debug
            )
            return result.items
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - This call returns a random batch of episodes, in no specific order
    
    func performRandomEpisodes(max: Int, category: String?, debug: Bool = false) async -> [Episode]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().episodesService.randomEpisodes(
                max: max,
                cat: category,
                pretty: debug
            )
            return result.items
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Get all the metadata for a single episode by passing its guid
    
    func getEpisodeData(episodeID: String, debug: Bool = false) async -> Episode? {
        do {
            let result = try await PodcastIndexKit().episodesService.episodes(
                byGUID: episodeID,
                pretty: debug
            )
            return result.episode
        }
        catch {
            return nil
        }
    }
}
