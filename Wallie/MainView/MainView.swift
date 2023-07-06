//
//  ContentView.swift
//  Wallie
//
//  Created by Le Chris on 04.07.2023.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    var categories: [String] = [
        "Abstract", "Flowers", "Clouds", "Animals", "Drinks", "Food", "Sweet", "Mountains", "Holidays", "Nature", "People", "Sports", "Cars", "World"
    ]
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140, maximum: 200), spacing: 18)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Wallpapers")
                    .font(.system(size: 26))
                    .fontWeight(.heavy)
                Spacer()
                Button(action: {
                    // Here must be router to the 2nd screen - SearchScreen.
                    print("BUTTON: Search Icon was tapp")
                }, label: {
                    Image("SearchIcon")
                })
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .padding(.bottom, 27)
            
            // Elements - Categories - HorizontalScroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(categories), id: \.self) { category in
                        Button(action: {
                            // Update ScrollView with pictures below.
                            print("BUTTON: Load pictures for category on tap")
                            print(category)
                        }, label: {
                            Text(category)
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                        })
                    }
                }
            }
            .padding(.leading, 24)
            .padding(.bottom, 38)
            
            
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 20,
                    pinnedViews: []
                ) {
                    Section() {
                        ForEach(0...10, id: \.self) { index in
                            Rectangle()
//                              .frame(height: 235) - size from design
                                .aspectRatio(9/16, contentMode: .fit)
                                .overlay(Image("CloudImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                )
                                .cornerRadius(15)
//                              .foregroundColor([.red, .yellow, .green, .blue, .pink, .cyan].randomElement())
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}
