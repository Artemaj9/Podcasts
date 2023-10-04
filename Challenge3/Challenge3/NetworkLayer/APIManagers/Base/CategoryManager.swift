//
//  CategoryManager.swift
//

import Foundation
import PodcastIndexKit

struct LocalCategory: Codable, Hashable, Sendable {
    public let id: Int?
    
    public let name: String?
}

@MainActor
final class CategoryManager: ObservableObject {
    @Published var apiError = ""
    
    // MARK: - This call return list of available categories
    
    func getCategoryList(debug: Bool = false) async -> CategoriesResponse? {
        do {
            let result = try await PodcastIndexKit().categoriesService.list(pretty: debug)
            return result
        }
        catch {
            return nil
        }
    }
}
