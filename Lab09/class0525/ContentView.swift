//
//  ContentView.swift
//  class0525
//
//  Created by Andy Lee on 2022/5/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var moviesData = movieData()
    
    var body: some View {
        TabView {
            FirstTab(iphoneData: self.moviesData)
                .tabItem {
                    Label("首頁", systemImage: "house")
                }
            SecondTab(iphoneData: self.moviesData)
                .tabItem {
                    Label("紀錄", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
