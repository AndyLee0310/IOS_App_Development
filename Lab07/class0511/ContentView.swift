//
//  ContentView.swift
//  class0511
//
//  Created by Andy Lee on 2022/5/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieView()
                .tabItem {
                    Label("電影", systemImage: "house")
                }
            Link("臺北科技大學", destination: URL(string: "https://www.ntut.edu.tw/")!)
                .tabItem {
                    Label("製作中", systemImage: "hammer")
                }
            ThirdView()
                .tabItem {
                    Label("電影", systemImage: "star")
                }
            
        }
//        NavigationView {
//            VStack {
//                NavigationLink {
//                    MovieView()
//                } label: {
//                    VStack {
//                        Text("大家一起來看電影")
//                        Image(systemName: "video")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 200, height: 200)
//                    }
//                }
//            }
//            .navigationTitle("首頁")
//            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
