//
//  Player.swift
//
import AVFoundation
import Combine

let timeScale = CMTimeScale(1000)
let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

enum PlayerScrubState {
    case reset
    case scrubStarted
    case scrubEnded(TimeInterval)
}

final class Player: NSObject, ObservableObject {

    @Published var displayTime: TimeInterval = 0

    @Published var observedTime: TimeInterval = 0

    @Published var itemDuration: TimeInterval = 0
    var itemDurationKVOPublisher: AnyCancellable!

    @Published var timeControlStatus: AVPlayer.TimeControlStatus = .paused
   var timeControlStatusKVOPublisher: AnyCancellable!

    // AVPlayer
    
     var avPlayer: AVPlayer
    
   var periodicTimeObserver: Any?

    var scrubState: PlayerScrubState = .reset {
        didSet {
            switch scrubState {
            case .reset:
                return
            case .scrubStarted:
                return
            case .scrubEnded(let seekTime):
                avPlayer.seek(to: CMTime(seconds: seekTime, preferredTimescale: 1000))
            }
        }
    }

    init(avPlayer: AVPlayer) {
        self.avPlayer = avPlayer
        super.init()

        self.addPeriodicTimeObserver()
        self.addTimeControlStatusObserver()
        self.addItemDurationPublisher()
    }

    deinit {
        removePeriodicTimeObserver()
        timeControlStatusKVOPublisher.cancel()
        itemDurationKVOPublisher.cancel()
    }

    func play() {
        self.avPlayer.play()
    }

    func pause() {
        self.avPlayer.pause()
    }

     func addPeriodicTimeObserver() {
        self.periodicTimeObserver = avPlayer.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in
            guard let self = self else { return }

            // Обновление времени
            
            self.observedTime = time.seconds

            switch self.scrubState {
            case .reset:
                self.displayTime = time.seconds
                
            // Когда слайдер активен, время привязываем к нему
                
            case .scrubStarted:
                break
            case .scrubEnded(let seekTime):
                self.scrubState = .reset
                self.displayTime = seekTime
            }
        }
    }

     func removePeriodicTimeObserver() {
        guard let periodicTimeObserver = self.periodicTimeObserver else {
            return
        }
        avPlayer.removeTimeObserver(periodicTimeObserver)
        self.periodicTimeObserver = nil
    }

     func addTimeControlStatusObserver() {
        timeControlStatusKVOPublisher = avPlayer
            .publisher(for: \.timeControlStatus)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (newStatus) in
                guard let self = self else { return }
                self.timeControlStatus = newStatus
                }
        )
    }

     func addItemDurationPublisher() {
        itemDurationKVOPublisher = avPlayer
            .publisher(for: \.currentItem?.duration)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (newStatus) in
                guard let newStatus = newStatus,
                    let self = self else { return }
                self.itemDuration = newStatus.seconds
                }
        )
    }
}
