//
//  AsyncImageView.swift
//  LeboincoinTestSwiftUI
//
//  Created by Lucas CHEN on 03/10/2024.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: Image?
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    func load(url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                    Log.error(error)
                case .finished: break
                }
            }, receiveValue: { [weak self] (data, _) in
                guard let uiImage = UIImage(data: data) else { return }
                self?.image = Image(uiImage: uiImage)
            })
            .store(in: &cancellables)
    }
}

/**
 Using SwiftUI’s AsyncImage to render remote images from URLs
 */

struct AsyncImageView: View {
    private var imageUrl: URL?
    private let height: CGFloat
    private let placeholder: String?
    private let placeholderText: String?
    private let resizerWidth: CGFloat?
    private let alignment: Alignment = .center
    
    @StateObject private var loader = ImageLoader()
    
    init(imageUrl: URL? = nil, height: CGFloat, placeholder: String? = nil, placeholderText: String? = nil, resizerWidth: CGFloat? = nil) {
        self.imageUrl = imageUrl
        self.height = height
        self.placeholder = placeholder
        self.placeholderText = placeholderText
        self.resizerWidth = resizerWidth
        
        // Resizer image for Orange repository image
        if let width = resizerWidth {
            self.imageUrl = self.imageUrl?.addQueryParams(queryItems: [URLQueryItem(name: "width", value: "\(Int(width))"),
                                                                       URLQueryItem(name: "height", value: "\(Int(height))")])
        }
        // Encode Url
        self.imageUrl = self.imageUrl?.addingPercentEncoding
    }

    var body: some View {
        ZStack {
            if let image = loader.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: height, alignment: .center)
            } else if loader.error != nil || imageUrl == nil {
                // Placeholder image or text if image is not loaded
                if let placeholderText = placeholderText, let placeholder = placeholder, let image = UIImage(named: placeholder) {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: image)
                            .centerCropped()
                        Text(placeholderText)
                            //.modifier(FallbackTitleModifier(lineLimit: placeholder == "horizontal_placeholder" ? 1 : 2))

                    }
                } else if let placeholder = placeholder {
                    if let image = UIImage(named: placeholder) {
                        Image(uiImage: image)
                            .centerCropped()
                    } else {
                        // create Text fallback
                        Text(placeholder)
                            //.modifier(FallbackTitleModifier())
                            .frame(height: height, alignment: .center)
                    }
                }
            } else {
                /**
                 Default image if none of the above conditions are satisfied.
                 Showing progress view as placeholder
                 */
                ProgressView()
                    .font(.largeTitle)
                    .tint(.tintColor)
            }
        }
        .task(id: imageUrl) {
            guard let imageUrl = imageUrl else { return }
            loader.load(url: imageUrl)
        }
        .id(self.imageUrl)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
            .clipped()
        }
    }
}

