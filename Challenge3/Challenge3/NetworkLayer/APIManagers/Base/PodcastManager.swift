//
//  PodcastManager.swift
//

import Foundation
import PodcastIndexKit

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
}
