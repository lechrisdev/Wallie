//
//  ResultScreenView.swift
//  Wallie
//
//  Created by Le Chris on 01.08.2023.
//

import SwiftUI
import Kingfisher

struct ResultScreenView: View {
    
    var router: Router
    
    var url: String
    
    init(router: Router, url: String) {
        self.router = router
        self.url = url
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack { // "BackArrowIcon" button and "DownloadSaveIcon" button
                Button(action: {
//                    router.back()
                    router.dismiss(animated: true)
                    print("BUTTON: Back to previous Screen")
                }, label: {
                    Image("BackArrowIcon")
                        .foregroundColor(.primary)
                })
                Spacer()
                Image("DownloadSaveIcon")
                    .foregroundColor(.primary)
            }
            .padding(.top, 14)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            
            Rectangle()
                .aspectRatio(9/16, contentMode: .fit)
                .foregroundColor(.clear)
                .overlay(KFImage(URL(string: url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(15)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            
            HStack {
                ButtonView(name: "Home Screen")
                Spacer()
                ButtonView(name: "Lock Screen")
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResultScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreenView(router: Router(),
                         url: "https://images.unsplash.com/photo-1684144004516-305d67b7352d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=927&q=80")
    }
}

struct ButtonView: View {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    var body: some View {
        HStack { // Buttons "Home Screen" and "Lock Screen"
            
            HStack(alignment: .center) {
                Text(name)
                    .foregroundColor(.primary)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 25)
            }
            .background(.white)
            .cornerRadius(50)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .inset(by: 0.33)
                    .stroke(Color(red: 0.81, green: 0.81, blue: 0.81).opacity(0.35), lineWidth: 0.65)
            )
        }
    }
}
