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
    
    
    // Function to save image to UserDefaults
//    func saveImageToUserDefaults(image: UIImage, key: String) {
//        guard let imageData = image.pngData() else {
//            print("Failed to convert image to PNG data")
//            return
//        }
//        
//        // Debugging: Print the size of the image data to check for large image sizes
//        print("Saving image data of size: \(imageData.count) bytes")
//        DispatchQueue.main.async {
//            UserDefaults.standard.set(imageData, forKey: key)
//        }
//        
//    }
    
    // Function to load image from UserDefaults
//    func loadImageFromUserDefaults(key: String) -> UIImage? {
//        if let imageData = UserDefaults.standard.object(forKey: key) as? Data {
//            print("Loaded image data of size: \(imageData.count) bytes") // Debugging size
//            
//            if let loadedImage = UIImage(data: imageData) {
//                return loadedImage
//            } else {
//                print("Failed to convert data to UIImage")
//            }
//        } else {
//            print("No image data found in UserDefaults")
//        }
//        return nil
//    }
}
