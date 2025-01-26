//
//  LocalDataManager.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Keys Enum
    enum Key {
        case nowPlaying
        case popular
        case upcoming
        case movieDetails(Int)
        
        var rawValue: String {
            switch self {
            case .nowPlaying: return MoviesListType.nowPlaying.rawValue
            case .popular: return MoviesListType.popular.rawValue
            case .upcoming: return MoviesListType.upcoming.rawValue
            case .movieDetails(let id): return "movieDetails\(id)"
            }
        }
    }
    
    
    // MARK: - Setters
    // Save custom object arrays
    func set<T: Codable>(_ value: [T], forKey key: Key) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key.rawValue)
            print("saved in manager")
        }
        
    }
    
    func set<T: Codable>(_ value: T, forKey key: Key) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key.rawValue)
            print("details saved in manager")
        }
    }
    
    func get<T: Codable>(_ type: T.Type, forKey key: Key) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        let decoder = JSONDecoder()
        print("get from manager")
        return try? decoder.decode(T.self, from: data)
    }
    
    // MARK: - Getters
    // Retrieve custom object arrays
    func getArray<T: Codable>(_ type: T.Type, forKey key: Key) -> [T]? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        let decoder = JSONDecoder()
        print("get from manager")
        return try? decoder.decode([T].self, from: data)
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        
        // Check if the image is already cached
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            completion(image)
        }
        
        // If not cached, download the image
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response, error == nil,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Cache the downloaded image
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
