//
//  Login.swift
//  class0601
//
//  Created by Andy Lee on 2022/6/1.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isregistered = false
    @State private var acc:String = ""
    @State private var pwd:String = ""
    
    var body: some View {
        VStack {
            TextField("Email Address", text: $acc)
                .textFieldStyle(.roundedBorder)
            TextField("Password", text: $pwd)
                .textFieldStyle(.roundedBorder)
//            TextField("username", text: $acc, prompt: Text("username"))
//                .textFieldStyle(.roundedBorder)
//                .padding()
//            TextField("password", text: $pwd, prompt: Text("password"))
//                .textFieldStyle(.roundedBorder)
//                .padding()
            Button("Login") {
                Auth.auth().signIn(withEmail: acc, password: pwd) { result, error in
                    guard error == nil else {
                        print(error?.localizedDescription)
                        dismiss()
                        return
                    }
                    print("success")
                    dismiss()
                }
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50, alignment: .center)
            .background(.blue)
            .frame(width: nil)
            .cornerRadius(20)
            HStack {
                Text("Not registered?")
                Button("Create an account") {
                    
                }
            }
        }.padding()
            .navigationTitle("Login")
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
