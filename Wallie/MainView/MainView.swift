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
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Wallpapers")
                        .font(.system(size: 26))
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        router.showSearchScreenView()
                    }, label: {
                            Image("SearchIcon")
                                .renderingMode(.template)
                                .foregroundColor(.primary)
                    })
                }
                .padding(.top, 20)
                .padding(.horizontal, 24)
                .padding(.bottom, 27)
                ScrollViewReader { reader in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(viewModel.categories), id: \.self) { category in
                                Button(action: {
                                    viewModel.selectedCategory = category
                                    viewModel.page = 1
                                    viewModel.images = []
                                    viewModel.searchImages()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation {
                                            reader.scrollTo(category, anchor: .leading)
                                        }
                                    }
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
                }
                
                ScrollView {
                    ImagesGridView(router: router,
                                   images: viewModel.images,
                                   index: { index in
                        Task {
                            await viewModel.loadImagesIfNeeded(index: index)
                        }
                    })
                }
            }
            .navigationBarHidden(true)
            
            Text(viewModel.errorMessage)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
                .colorInvert()
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.secondary)
                }
                .offset(y: viewModel.showError ? 0 : 150)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(router: Router(),
                     viewModel: MainViewModel(repo: RepositoryMock()))
        }
    }
}
