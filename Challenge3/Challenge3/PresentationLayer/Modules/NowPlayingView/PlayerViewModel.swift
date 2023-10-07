//
//  PlayerViewModel.swift
//

import AVFoundation
import Combine
import PodcastIndexKit

let timeScale = CMTimeScale(1000)
let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

enum PlayerScrubState {
    case reset
    case scrubStarted
    case scrubEnded(TimeInterval)
}

final class PlayerViewModel: ObservableObject {
    static let shared = PlayerViewModel()
    
    private init() {
    }
    
    // TODO: change model NowPlayingModel to Episode
    @Published var episodePlaylist: [Episode]? {
        didSet {
            setCurrentEpisode(index: currentEpisodeIndex)
        }
    }
    @Published var currentEpisode: Episode? {
        didSet {
            updateEpisodeInfo()
        }
    }
    
    @Published var episodeTitle: String = ""
    @Published var episodeNumber: Int = 1
    @Published var currentEpisodeIndex: Int = 0
    
    @Published var isRandom: Bool = false
    @Published var isPlaying: Bool = false
    @Published var isRepeated: Bool = false
    
    @Published var displayTime: TimeInterval = 0
    @Published var observedTime: TimeInterval = 0
    
    @Published var timeControlStatus: AVPlayer.TimeControlStatus = .paused
    
//    var itemDurationKVOPublisher: AnyCancellable!
//    var timeControlStatusKVOPublisher: AnyCancellable!
    
    var scrubState: PlayerScrubState = .reset {
        didSet {
            switch scrubState {
            case .reset:
                return
            case .scrubStarted:
                return
            case .scrubEnded(let seekTime):
                player?.seek(to: CMTime(seconds: seekTime, preferredTimescale: 1000))
            }
        }
    }
    
    var durationFormatter: DateComponentsFormatter {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.allowedUnits = [.minute, .second]
        durationFormatter.unitsStyle = .positional
        durationFormatter.zeroFormattingBehavior = .pad

        return durationFormatter
    }
    
    var player: AVPlayer?
    var originalPlaylist: [Episode]?
    
    private var playbackTimeObserver: Any?
    
    func play() {
        print("play button pressed")
        guard let episode = currentEpisode,
              let url = URL(string: episode.enclosureUrl ?? "") else {
            return
        }
        print("Trying to play \(episode.title ?? "no title") with url: \(episode.enclosureUrl ?? "no url")")
        
        if player == nil {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
            addTimeObserver()
        } else {
            if observedTime == 0 {
                player?.seek(to: CMTime.zero)
                player?.play()
                isPlaying = true
                return
            } else {
                player?.play()
                isPlaying = true
                return
            }
        }
        
        player?.seek(to: CMTime.zero)
        player?.play()
        
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        if let observedTime = player?.currentTime().seconds {
            self.observedTime = observedTime
        }
        isPlaying = false
    }
    
    func play_next() {
        if isRepeated {
            let index = currentEpisodeIndex
            if index < (episodePlaylist?.count ?? 0) - 1 {
                observedTime = 0
                currentEpisodeIndex += 1
                currentEpisode = episodePlaylist?[currentEpisodeIndex]
                play()
            } else {
                observedTime = 0
                currentEpisodeIndex = 0
                currentEpisode = episodePlaylist?[0]
                play()
            }
        } else {
            guard currentEpisodeIndex < (episodePlaylist?.count ?? 0) - 1 else {
                return
            }
            
            observedTime = 0
            currentEpisodeIndex += 1
            currentEpisode = episodePlaylist?[currentEpisodeIndex]
            play()
        }
    }
    
    func play_prev() {
        guard (currentEpisodeIndex > 0) && (currentEpisodeIndex < (episodePlaylist?.count ?? 0)) else {
            return
        }
        
        observedTime = 0
        currentEpisodeIndex -= 1
        currentEpisode = episodePlaylist?[currentEpisodeIndex]
        play()
    }
    
    func setCurrentEpisode(index: Int) {
        print("Debug: index \(index)")
        guard index < episodePlaylist?.count ?? 0 else {
            return
        }
        observedTime = 0
        currentEpisodeIndex = index
        currentEpisode = episodePlaylist?[currentEpisodeIndex]
        play()
    }
    
    func shufflePlaylist() {
        if episodePlaylist?.count ?? 0 > 1 {
            if isRandom {
                episodePlaylist = originalPlaylist
                setCurrentEpisode(index: 0)
                isRandom = false
            } else {
                originalPlaylist = episodePlaylist
                episodePlaylist?.shuffle()
                setCurrentEpisode(index: 0)
                isRandom = true
            }
        }
    }
    
    func repeatPlaylist() {
        isRepeated.toggle()
    }
    
    func seekToTime(seconds: Double) {
            player?.seek(to: CMTime(seconds: seconds, preferredTimescale: 1))
        }
    
    private func selectFirstEpisode() {
        if let firstEpisode = episodePlaylist?.first {
            currentEpisode = firstEpisode
            currentEpisodeIndex = 0
        }
    }
    
    private func updateEpisodeInfo() {
        if let currentEpisode = currentEpisode {
            episodeTitle = currentEpisode.title ?? "Unknown"
            episodeNumber = currentEpisode.episode ?? 1
        } else if let firstEpisode = episodePlaylist?.first {
            episodeTitle = firstEpisode.title ?? "Unknown"
            episodeNumber = firstEpisode.episode ?? 1
        } else {
            episodeTitle = "No episodes to play"
            episodeNumber = 0
        }
    }
    
    private func addTimeObserver() {
        let interval = CMTime(seconds: 1.0, preferredTimescale: timeScale)
        playbackTimeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.displayTime = time.seconds
        }
    }
    
    deinit {
        if let observer = playbackTimeObserver {
            player?.removeTimeObserver(observer)
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        play_next()
        let index = currentEpisodeIndex
        NotificationCenter.default.post(name: Notification.Name("ScrollToNextEpisode"), object: index)
    }
}

