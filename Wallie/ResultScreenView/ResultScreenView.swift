//
//  ResultScreenView.swift
//  Wallie
//
//  Created by Le Chris on 01.08.2023.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct ResultScreenView: View {
    
    @State private var loadedImage: UIImage? = nil
    @State var messageToUser: Bool = false
    
    var router: Router
    var url: String
    
    init(router: Router, url: String) {
        self.router = router
        self.url = url
    }
    
    private func saveImageToGallery() {
        if let loadedImage {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: loadedImage)
            } completionHandler: { success, error in
                if success {
                    print("Изображение успешно сохранено в Фото")
                    DispatchQueue.main.async {
                        withAnimation(Animation.spring(response: 0.8, dampingFraction: 0.3, blendDuration: 0.6)) {
                            messageToUser = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            messageToUser = false
                        }
                    }
                } else if let error = error {
                    print("Ошибка при сохранении изображения: \(error.localizedDescription)")
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        router.dismiss(animated: true)
                    }, label: {
                        Image("BackArrowIcon")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                    })
                    Spacer()
                    Button(action: {
                        saveImageToGallery()
                    }, label: {
                        Image("DownloadSaveIcon")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                    })
                }
                .padding(.top, 14)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                Rectangle()
                    .aspectRatio(9/16, contentMode: .fit)
                    .foregroundColor(.clear)
                    .overlay(
                        ZStack {
                            ProgressView()
                                .progressViewStyle(.circular)
                            KFImage(URL(string: url))
                                .onSuccess { result in
                                    loadedImage = result.image
                                }
                                .onFailure { error in
                                    print("Ошибка загрузки изображения: \(error)")
                                }
                                .resizable()
                                .scaledToFill()
                                .aspectRatio(9/16, contentMode: .fit)
                        }
                    )
                    .cornerRadius(15)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                
//                HStack {
//                    ButtonView(name: "Home Screen")
//                    Spacer()
//                    ButtonView(name: "Lock Screen")
//                }
//                .padding(.horizontal, 24)
            }
            Text("Изображение сохранено")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
                .colorInvert()
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.secondary)
                }
                .offset(y: messageToUser ? 0 : 150)
        }
    }
}

struct ResultScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreenView(router: Router(),
                         url: "https://images.unsplash.com/photo-1611556538519-6616ee7c55b0?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NzA1OTN8MHwxfHNlYXJjaHw4fHxUaW1lc3xlbnwwfDF8fHwxNjkxODgxNDY3fDA&ixlib=rb-4.0.3&q=85")
    }
}

//struct ButtonView: View {
//
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//    var body: some View {
//        HStack { // Buttons "Home Screen" and "Lock Screen"
//
//            HStack(alignment: .center) {
//                Text(name)
//                    .foregroundColor(.primary)
//                    .font(.system(size: 16))
//                    .fontWeight(.bold)
//                    .padding(.vertical, 8)
//                    .padding(.horizontal, 25)
//            }
//            .background(.white)
//            .cornerRadius(50)
//            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
//            .overlay(
//                RoundedRectangle(cornerRadius: 50)
//                    .inset(by: 0.33)
//                    .stroke(Color(red: 0.81, green: 0.81, blue: 0.81).opacity(0.35), lineWidth: 0.65)
//            )
//        }
//    }
//}
