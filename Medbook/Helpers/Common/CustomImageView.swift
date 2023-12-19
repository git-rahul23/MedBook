//
//  CustomImageView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct ContentImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageUrl: String
    var width: CGFloat?
    var height: CGFloat?
    var isRadius: Bool = false
    
    init(_ imageUrl: String, width: CGFloat? = nil, height: CGFloat? = nil, isRadius: Bool = false) {
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
        self.isRadius = isRadius
    }
    
    var body: some View {
        if let image = imageLoader.image {
            if let width = width, let height = height {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width,height: height)
                    .clipped()
                    .cornerRadius(isRadius ? 7 : 0)
            } else {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(isRadius ? 7 : 0)
            }
        } else {
            
            if let width = width, let height = height {

                Image("bookLoader")
                    .frame(width: width,height: height)
                    .clipped()
                    .cornerRadius(isRadius ? 7 : 0)
                    .onAppear {
                        imageLoader.loadImage(from: imageUrl)
                    }
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        imageLoader.loadImage(from: imageUrl)
                    }
                
            }
            
        }
    }
}

final fileprivate class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    fileprivate func loadImage(from url: String) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        if let cachedImage = URLCache.shared.cachedImage(for: URLRequest(url: url)) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let downloadedImage = UIImage(data: data) {
                URLCache.shared.storeImage(downloadedImage, for: URLRequest(url: url))
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}

extension URLCache {
    fileprivate func cachedImage(for request: URLRequest) -> UIImage? {
        if let cachedResponse = cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        return nil
    }
    
    fileprivate func storeImage(_ image: UIImage, for request: URLRequest) {
        if let url = request.url {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let cachedResponse = CachedURLResponse(response: response, data: image.jpegData(compressionQuality: 0.8)!)
            storeCachedResponse(cachedResponse, for: request)
        }
    }
}
