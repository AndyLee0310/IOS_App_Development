//
//  ContentView.swift
//  class0601
//
//  Created by Andy Lee on 2022/6/1.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var islogin = false
    @State var isregistered = false
    
    var body: some View {
        if let user = Auth.auth().currentUser {
            Text("Hello, \(user.displayName ?? "error")")
            Text("Email Address: \(user.email ?? "error")")
            Button("Logout") {
                do {
                    try Auth.auth().signOut()
                } catch {
                    print(error)
                }
            }
        } else {
            VStack {
                Button("登入") {
                    islogin = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .sheet(isPresented: $islogin) {
                    LoginView()
                }
                .padding()
                Button("註冊") {
                    isregistered = true
                    self.presentationMode.wrappedValue.dismiss()
                }
                .sheet(isPresented: $isregistered) {
                    RegisteredView()
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
