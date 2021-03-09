//
//  ImageCache.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation
import UIKit

protocol ImageCacheProtocol: class {
    func image(for posterPath: String) -> Data?
    func insertImage(_ image: Data?, for posterPath: String)
    func removeImage(for posterPath: String)
    func removeAllImages()
    subscript(_ posterPath: String) -> Data? { get set }
}



final class ImageCache {
    
    static let shared = ImageCache()
    
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    private init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}


extension ImageCache: ImageCacheProtocol {
    
    subscript(_ posterPath: String) -> Data? {
        get {
            return image(for: posterPath)
        }
        set {
            return insertImage(newValue, for: posterPath)
        }
    }

    func image(for posterPath: String) -> Data? {
        defer { lock.unlock() }
        
        lock.lock()
        
        if let image = imageCache.object(forKey: posterPath as AnyObject) as? Data {
            return image
        }
        return nil
    }
    
    func insertImage(_ image: Data?, for posterPath: String) {
        guard let image = image else { return removeImage(for: posterPath) }

        lock.lock()
        defer { lock.unlock() }
        
        imageCache.setObject(image as AnyObject, forKey: posterPath as AnyObject, cost: image.count)
    }

    func removeImage(for posterPath: String) {
        defer { lock.unlock() }
        lock.lock()
        
        imageCache.removeObject(forKey: posterPath as AnyObject)
    }
    
    func removeAllImages() {
        defer { lock.unlock() }
        lock.lock()
        imageCache.removeAllObjects()
    }
}

extension ImageCache: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
