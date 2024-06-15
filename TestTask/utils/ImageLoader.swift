import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private var cache = ImageCache.getImageCache()

    init(url: URL?) {
        self.url = url
        loadImage()
    }

    func loadImage() {
        guard let url = url else { return }

        if let cachedImage = cache.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.cache.set(forKey: url.absoluteString, image: loadedImage)
                self.image = loadedImage
            }
        }.resume()
    }
}

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    static func getImageCache() -> ImageCache {
        return ImageCache()
    }

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
