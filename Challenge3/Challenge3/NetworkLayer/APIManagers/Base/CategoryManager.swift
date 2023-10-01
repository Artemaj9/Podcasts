//
//  CategoryManager.swift
//

import Foundation
import PodcastIndexKit

struct PodcastCategory: Codable, Hashable, Sendable {
    public let id: Int?
    public let name: String?
}

final class CategoryManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call return list of available categories
    
    func getCategoryList(debug: Bool = false) async -> [PodcastCategory]? {
        do {
            let result = try await PodcastIndexKit().categoriesService.list(pretty: debug)
            return result.feeds as? [PodcastCategory]
        }
        catch {
            return nil
        }
    }
}
