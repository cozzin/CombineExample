//
//  SearchViewModel.swift
//  CombineExample
//
//  Created by SeongHo on 25/06/2019.
//  Copyright © 2019 NAVER. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import GithubAPI

final class SearchViewModel: BindableObject {
    
    let didChange = PassthroughSubject<SearchViewModel, Never>()
    
    @Published
    var text: String = ""
    
    private(set) var repositories: [SearchRepositoriesItem] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $text
            .throttle(for: .milliseconds(300), scheduler: DispatchQueue.main, latest: true)
            .removeDuplicates()
            .map { query -> RepositoryAPI.SearchResponse in
                if query.isEmpty {
                    return Publishers.Just([]).eraseToAnyPublisher()
                }
                return RepositoryAPI.search(query: query)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: \.repositories, on: self)
    }
}
