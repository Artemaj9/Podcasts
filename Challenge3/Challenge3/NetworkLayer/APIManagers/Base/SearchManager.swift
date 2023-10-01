//
//  SearchManager.swift
//

import Foundation
import PodcastIndexKit

enum searchVal {
    case any
    case lightning
    case hive
    case webmonetization
}

@MainActor
final class SearchManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call returns all of the feeds that match the search terms in the title, author or owner of the feed.
    
    func performSearchByTerm(term: String, max: Int, debug: Bool = false) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().searchService.search(
                byTerm: term,
                max: max,
                pretty: debug
            )
            return result.feeds
        }
        catch {
            apiError = error.localizedDescription
            return nil
        }
    }
    
    // MARK: - This call returns all of the feeds where the title of the feed matches the search term (ignores case).
    
    func performSearchByTitle(title: String, max: Int, debug: Bool = false) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().searchService.search(
                byTitle: title,
                max: max,
                pretty: debug
            )
            return result.feeds
        }
        catch {
            apiError = error.localizedDescription
            return nil
        }
    }
    
    // MARK: - This call returns all of the episodes where the specified person is mentioned.
    
    func performSearchByPerson(person: String, max: Int, debug: Bool = false) async -> [Podcast]? {
        precondition(max >= 0 && max <= 1000, "max should be int 0-1000")
        do {
            let result = try await PodcastIndexKit().searchService.search(
                byPerson: person,
                max: max,
                pretty: debug
            )
            return result.feeds
        }
        catch {
            apiError = error.localizedDescription
            return nil
        }
    }
}
