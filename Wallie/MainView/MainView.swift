//
//  ContentView.swift
//  Wallie
//
//  Created by Le Chris on 04.07.2023.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var router: Router
    
    init(router: Router, viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.router = router
        viewModel.searchImages()
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Wallpapers")
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                Spacer()
                
                Button(action: {
                    print("BUTTON: Search Icon was tapp")
                    router.showSearchScreenView()
                }, label: {
                    Image("SearchIcon")
                        .foregroundColor(.primary)
                })
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .padding(.bottom, 27)
            
            // Elements - Categories - HorizontalScroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(viewModel.categories), id: \.self) { category in
                        Button(action: {
                            // Update ScrollView with pictures below.
                            print("BUTTON: Load pictures for category on tap")
                            print(category)
                            viewModel.selectedCategory = category
                            viewModel.searchImages()
                        }, label: {
                            if category == viewModel.selectedCategory {
                                Text(category)
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                                    .fontWeight(.bold)
                            } else {
                                Text(category)
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                            }
                        })
                        .padding(.trailing, 25)
                    }
                }
            }
            .padding(.leading, 24)
            .padding(.bottom, 38)
            
            ScrollView {
                ImagesGridView(router: router,
                               images: viewModel.images)
            }
        }
        .navigationBarHidden(true)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(router: Router(),
                     viewModel: MainViewModel(repo: RepositoryMock()))
        }
    }
}
