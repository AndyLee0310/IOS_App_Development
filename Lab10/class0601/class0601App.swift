//
//  class0601App.swift
//  class0601
//
//  Created by Andy Lee on 2022/6/1.
//

import SwiftUI
import Firebase

@main
struct class0601App: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
