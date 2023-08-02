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
    
    @State private var text: String = ""
    
    init(router: Router, viewModel: SearchScreenViewModel) {
        self.viewModel = viewModel
        self.router = router
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack(alignment: .leading) { // "BackArrowIcon" button and "Search" word
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
                    print("BUTTON: Back to MainView")
                }, label: {
                    Image("BackArrowIcon")
                        .foregroundColor(.primary)
                })
            }
            .padding(.top, 14)
            .padding(.horizontal, 24)
            .padding(.bottom, 26)
            
            HStack { // Textfield and "DiscardIcon"
                
                TextField("Type the category you like", text: $text)
                    .foregroundColor(.primary)
//                                        TextFieldView(text: $viewModel.searchText)
                    .autocorrectionDisabled(true)
                
                
                Spacer()
                
                Button {
                    self.text = "" // Действие кнопки для сброса текста
                    print("BUTTON: 'DiscardIcon' was tapp")
                } label: {
                    Image("DiscardIcon")
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
            
            ImagesGridView(router: router)
        }
    }
}

struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView(router: Router(),
                         viewModel: SearchScreenViewModel())
    }
}
