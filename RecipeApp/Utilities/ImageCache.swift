//
//  ImageCache.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/17/25.
//

import UIKit
import CryptoKit

class ImageCache {
    
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    private let diskCacheDirectory: URL
    
    private init() {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheDirectory = cachesDirectory.appendingPathComponent("ImageCache")
        
        if !fileManager.fileExists(atPath: diskCacheDirectory.path) {
            try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    var imageCache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 50
        return cache
    }()
    
    
    func loadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        if let diskImage = loadFromDisk(path: url) {
            imageCache.setObject(diskImage, forKey: url as NSURL) // Store in memory
            return diskImage
        }

        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        imageCache.setObject(image, forKey: url as NSURL)
        saveToDisk(image: image, path: url)
        
        return image
    }
    
    /// Load image from disk
    private func loadFromDisk(path: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: path) else { return nil }
       //print("loading from the disk")
        return UIImage(data: data)
    }

    /// Save image to disk
    private func saveToDisk(image: UIImage, path: URL) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        try? data.write(to: path)
    }

    /// Generate a unique filename using SHA256 hash of URL string
    private func hashString(_ string: String) -> String {
        let hash = SHA256.hash(data: Data(string.utf8))
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
    
}

