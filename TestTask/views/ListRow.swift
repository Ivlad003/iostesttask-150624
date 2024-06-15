//
//  ListRow.swift
//  TestTask
//
//  Created by mac on 15.06.2024.
//

import SwiftUI

struct ListRowView: View {
    let item: ContentItem
    @ObservedObject var imageLoader: ImageLoader

    init(item: ContentItem) {
        self.item = item
        self.imageLoader = ImageLoader(url: URL(string: item.imageURL))
    }

    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }

            Text(item.title)
                .font(.headline)
            Text(item.description)
                .font(.subheadline)
        }
        .padding()
    }
}
