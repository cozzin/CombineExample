//
//  ContentView.swift
//  CombineExample
//
//  Created by SeongHo on 21/06/2019.
//  Copyright © 2019 NAVER. All rights reserved.
//

import SwiftUI
import Combine
import GithubAPI

struct ContentView : View {
    
    @EnvironmentObject
    var viewModel: SearchViewModel
    
    var body: some View {
        List {
            TextField($viewModel.text, placeholder: Text("input repository name"))
            
            ForEach(viewModel.repositories) { (repository: SearchRepositoriesItem) in
                HStack {
                    Text("\(repository.fullName!)")
                    Text("🌟\(repository.stargazersCount!)")
                }
            }
        }
        .navigationBarTitle(Text("Github Search"))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
