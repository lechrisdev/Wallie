//
//  SearchScreenView.swift
//  Wallie
//
//  Created by Le Chris on 06.07.2023.
//

import SwiftUI

struct SearchScreenView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .leading) { // "BackArrowIcon" button and "Search" word
                HStack {
                    Spacer()
                        Text("Search")
                            .font(.system(size: 26))
                            .fontWeight(.heavy)
                    Spacer()
                }
                Image("BackArrowIcon")
            }
            .padding(.top, 14)
            .padding(.bottom, 26)
            
            HStack { // Textfield and "DiscardIcon"
                
                TextField("Type the category you like", text: $text)
//                                        TextFieldView(text: $viewModel.searchText)
                    .autocorrectionDisabled(true)
                
                
                Spacer()
                
                Button {
                    self.text = "" // Действие кнопки для сброса текста
                    print("BUTTON: 'DiscardIcon' was tapp")
                } label: {
                    Image("DiscardIcon")
                        .padding(.trailing, 9)
                }
            }
            .padding(.bottom, 7)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(height: 1)
              .background(Color.primary)
            
            ScrollView {
                // Show a list with pictures of user's category from textField below.
            }
        }
        .padding(.horizontal, 24)
    }
}

struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
    }
}
