//
//  ImagesGridView.swift
//  Wallie
//
//  Created by Le Chris on 01.08.2023.
//

import SwiftUI
import Kingfisher

struct ImagesGridView: View {
    
    var router: Router
    
    let images: [ImageModel]
    
    init(router: Router, images: [ImageModel]) {
        self.router = router
        self.images = images
    }
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140, maximum: 200), spacing: 18)
    ]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 20,
            pinnedViews: []
        ) {
            Section() {
                ForEach(images, id: \.self) { image in
                    
                    Button(action: {
                        // Here must be router to the 3rd screen - ResultScreenView.
                        router.showResultScreenView(url: image.fullImageUrl)
                        print("TAP on IMAGE: switch to ResultScreenView")
                    }, label: {
                        Rectangle()
                            .aspectRatio(9/16, contentMode: .fit)
                            .overlay(KFImage(URL(string: image.smallImageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            )
                            .cornerRadius(15)
                        //  .foregroundColor([.red, .yellow, .green, .blue, .pink, .cyan].randomElement())
                    })
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ImagesGridView_Previews: PreviewProvider {
    static var previews: some View {
        
        let images = [ImageModel(imageId: "0",
                                 fullImageUrl: "https://images.unsplash.com/photo-1685815450272-806b5c531403?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                                 smallImageUrl: "https://images.unsplash.com/photo-1685815450272-806b5c531403?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80"),
                      ImageModel(imageId: "1",
                                 fullImageUrl: "https://images.unsplash.com/photo-1691040276996-0f70353a52e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                                 smallImageUrl: "https://images.unsplash.com/photo-1691040276996-0f70353a52e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80"),
                      ImageModel(imageId: "2",
                                 fullImageUrl: "https://images.unsplash.com/photo-1684144004516-305d67b7352d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=927&q=80",
                                 smallImageUrl: "https://images.unsplash.com/photo-1684144004516-305d67b7352d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=927&q=80")]
        
        ImagesGridView(router: Router(),
                       images: images) // + RepositoryMock
    }
}
