//
//  ImagesGridView.swift
//  Wallie
//
//  Created by Le Chris on 01.08.2023.
//

import SwiftUI

struct ImagesGridView: View {
    
    var router: Router
    
//    let images: [ImageModel]
    
    init(router: Router) {
        self.router = router
    }
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140, maximum: 200), spacing: 18)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 20,
                pinnedViews: []
            ) {
                Section() {
                    ForEach(0...10, id: \.self) { index in
                        
                        Button(action: {
                            // Here must be router to the 3rd screen - ResultScreenView.
                            router.showResultScreenView()
                            print("TAP on IMAGE: switch to ResultScreenView")
                            
                        }, label: {
                            Rectangle()
                                .aspectRatio(9/16, contentMode: .fit)
                                .overlay(Image("CloudImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                )
                                .cornerRadius(15)
                            //  .foregroundColor([.red, .yellow, .green, .blue, .pink, .cyan].randomElement())
                        })
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ImagesGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesGridView(router: Router())
    }
}
