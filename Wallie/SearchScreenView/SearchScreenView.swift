//
//  SearchScreenView.swift
//  Wallie
//
//  Created by Le Chris on 06.07.2023.
//

import SwiftUI

struct SearchScreenView: View {
    
    @ObservedObject var viewModel: SearchScreenViewModel
    
    var router: Router
    
    init(router: Router, viewModel: SearchScreenViewModel) {
        self.viewModel = viewModel
        self.router = router
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Search")
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    Button(action: {
                        router.back()
                    }, label: {
                        Image("BackArrowIcon")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                    })
                }
                .padding(.top, 14)
                .padding(.horizontal, 24)
                .padding(.bottom, 26)
                
                HStack {
                    TextField("Type the category you like", text: $viewModel.text)
                        .foregroundColor(.primary)
                        .autocorrectionDisabled(false)
                    Spacer()
                    Button {
                        viewModel.text = ""
                    } label: {
                        Image("DiscardIcon")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .padding(.trailing, 9)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 7)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 1)
                    .background(Color.primary)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 35)
                
                ScrollView {
                    if !viewModel.images.isEmpty {
                        ImagesGridView(router: router,
                                       images: viewModel.images,
                                       index: { index in
                            Task {
                                await viewModel.loadImagesIfNeeded(index: index)
                            }
                        })
                    }
                }
                .scrollDismissesKeyboard(.immediately)
            }
            .onChange(of: viewModel.text, perform: { text in
                if text.count >= 3 {
                    viewModel.startTimer(withTimeInterval: 1) {
                        viewModel.page = 1
                        viewModel.images = []
                        viewModel.searchImages()
                    }
                }
            })
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
    
    struct SearchScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SearchScreenView(router: Router(),
                             viewModel: SearchScreenViewModel(repo: RepositoryMock()))
        }
    }
}
