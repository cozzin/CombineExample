//
//  RepositoryAPI.swift
//  CombineExample
//
//  Created by SeongHo on 26/06/2019.
//  Copyright © 2019 NAVER. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GithubAPI

enum RepositoryAPI {
    typealias SearchResponse = AnyPublisher<[SearchRepositoriesItem], Never>
    
    static func search(query: String) -> SearchResponse {
        SearchResponse { subscriber in
            // Github > Settings > Developer Settings > Personal access tokens > Generate new token
            // SearchAPI(authentication: AccessTokenAuthentication(access_token: "token"))
            SearchAPI()
                .searchRepositories(q: query, per_page: 15) { response, error in
                    _ = subscriber.receive(response?.items ?? [])
            }
        }
    }
}

extension SearchRepositoriesItem: Identifiable { }
