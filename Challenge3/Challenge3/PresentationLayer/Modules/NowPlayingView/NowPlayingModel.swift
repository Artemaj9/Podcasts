//
//  NowPlayingModel.swift
//

import Foundation

struct NowPlayingModel: Codable, Hashable, Sendable {
    var id: Int?
    var title: String?
    var link: String?
    var description: String?
    var guid: String?
    var datePublished: Date?
    var datePublishedPretty: String?
    var dateCrawled: Date?
    var enclosureUrl: String?
    var enclosureType: String?
    var enclosureLength: Int?
    var contentLink: String?
    var duration: Int?
    var episode: Int?
    var season: Int?
    var image: String?
    var feedItunesId: Int?
    var feedImage: String?
    var feedId: Int?
    var feedLanguage: String?
    var feedDead: Int?
    var feedTitle: String?
    var feedDuplicateOf: Int?
    var chaptersUrl: String?
    var transcriptUrl: String?
    var feedImageUrlHash: Int?
    var imageUrlHash: Int?
    var startTime: Int?
    var endTime: Int?
    
    init(id: Int? = nil, title: String? = nil, link: String? = nil, description: String? = nil, guid: String? = nil, datePublished: Date? = nil, datePublishedPretty: String? = nil, dateCrawled: Date? = nil, enclosureUrl: String? = nil, enclosureType: String? = nil, enclosureLength: Int? = nil, contentLink: String? = nil, duration: Int? = nil, episode: Int? = nil, season: Int? = nil, image: String? = nil, feedItunesId: Int? = nil, feedImage: String? = nil, feedId: Int? = nil, feedLanguage: String? = nil, feedDead: Int? = nil, feedTitle: String? = nil, feedDuplicateOf: Int? = nil, chaptersUrl: String? = nil, transcriptUrl: String? = nil, feedImageUrlHash: Int? = nil, imageUrlHash: Int? = nil, startTime: Int? = nil, endTime: Int? = nil) {
        self.id = id
        self.title = title
        self.link = link
        self.description = description
        self.guid = guid
        self.datePublished = datePublished
        self.datePublishedPretty = datePublishedPretty
        self.dateCrawled = dateCrawled
        self.enclosureUrl = enclosureUrl
        self.enclosureType = enclosureType
        self.enclosureLength = enclosureLength
        self.contentLink = contentLink
        self.duration = duration
        self.episode = episode
        self.season = season
        self.image = image
        self.feedItunesId = feedItunesId
        self.feedImage = feedImage
        self.feedId = feedId
        self.feedLanguage = feedLanguage
        self.feedDead = feedDead
        self.feedTitle = feedTitle
        self.feedDuplicateOf = feedDuplicateOf
        self.chaptersUrl = chaptersUrl
        self.transcriptUrl = transcriptUrl
        self.feedImageUrlHash = feedImageUrlHash
        self.imageUrlHash = imageUrlHash
        self.startTime = startTime
        self.endTime = endTime
    }
}

let mokePodcastData = [
    NowPlayingModel.init(
        id: 16795088,
        title: "Gotham",
        link: "https://www.theincomparable.com/batmanuniversity/19/",
        description: "Batman University is back in session! James Thomson and Nathan Alderman join Tony for a discussion of Fox",
        guid: "incomparable/batman/19b",
        datePublishedPretty: "January 01, 2019 9:30pm",
        enclosureUrl: "https://www.theincomparable.com/podcast/batmanuniversity302.mp3",
        enclosureType: "audio/mp3",
        enclosureLength: 26385472,
        duration: 3297,
        episode: 19,
        season: 3,
        image: "",
        feedItunesId: 1441923632,
        feedImage: "https://www.theincomparable.com/imgs/logos/logo-batmanuniversity-3x.jpg",
        feedId: 75075,
        feedLanguage: "en-us",
        feedDead: 0
    ),
    NowPlayingModel.init(
        id: 16795089,
        title: "The Lego Batman Movie",
        link: "https://www.theincomparable.com/batmanuniversity/18/",
        description: "Batman University is back for a panel discussion of the Lego Batman Movie. We pull apart why this movie is such a great (and important!)",
        guid: "theincomparable/teevee/451",
        datePublishedPretty: "August 04, 2018 8:00pm",
        enclosureUrl: "https://www.theincomparable.com/podcast/batmanuniversity301.mp3",
        enclosureType: "audio/mp3",
        enclosureLength: 26670520,
        duration: 3333,
        episode: 18,
        season: 3,
        image: "",
        feedItunesId: 1441923632,
        feedImage: "https://www.theincomparable.com/imgs/logos/logo-batmanuniversity-3x.jpg",
        feedId: 75075,
        feedLanguage: "en-us",
        feedDead: 0
    )
]
