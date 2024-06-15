//
//  DataService.swift
//  TestTask
//
//  Created by mac on 15.06.2024.
//

import Foundation
import Foundation
import Combine

class DataService: ObservableObject {
    @Published var contentItems: [ContentItem] = []
    @Published var isLoading = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func loadData() {
        isLoading = true
        error = nil

        guard let url = URL(string: "https://496.ams3.cdn.digitaloceanspaces.com/data/test.json") else {
            self.isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ContentItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
                self.isLoading = false
            } receiveValue: { items in
                self.contentItems = items
            }
            .store(in: &cancellables)
    }
}
