//
//  ResultScreenView.swift
//  Wallie
//
//  Created by Le Chris on 01.08.2023.
//

import SwiftUI

struct ResultScreenView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack { // "BackArrowIcon" button and "DownloadSaveIcon" button
                Image("BackArrowIcon")
                    .foregroundColor(.primary)
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
                .overlay(Image("CloudImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                )
                .cornerRadius(15)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            
            HStack {
                ExtractedView(name: "Home Screen")
                Spacer()
                ExtractedView(name: "Lock Screen")
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResultScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreenView()
    }
}

struct ExtractedView: View {
    
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
