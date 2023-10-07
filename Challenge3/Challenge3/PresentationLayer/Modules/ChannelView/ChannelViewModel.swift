//
//  ChannelViewModel.swift
//

import Foundation
import PodcastIndexKit

final class ChannelViewModel: ObservableObject {

    @Published var currentPodcastEpisodes: [Episode] = []

    private var episodeManager: EpisodeManager?

    init() {
        Task {
            self.episodeManager = await EpisodeManager()
        }
    }

    func getEpisodes(podcastID: String) {
        Task {
            if let episodes = await getEpisodesByPodcastId(podcastID: podcastID) {
                self.currentPodcastEpisodes = episodes
            } 
        }
    }

    func getEpisodeIndex(episode: Episode) -> Int? {
        return currentPodcastEpisodes.firstIndex(of: episode)
    }

    func dataToEpisodeCellData(episode: Episode) -> EpisodeCellData {
        let iconState: Bool = false
        return .init(
            id: episode.id,
            iconState: iconState,
            mainLeft: episode.title,
            secondLeft: episode.link,
            secondRight: String(episode.duration ?? 0),
            image: episode.image,
            iconMode: .blank,
            height: nil
        )
    }

    private func getEpisodesByPodcastId(podcastID: String) async -> [Episode]? {
        let episodes = await episodeManager?.performEpisodesSearch(podcastID: podcastID)
        return episodes
    }
}
