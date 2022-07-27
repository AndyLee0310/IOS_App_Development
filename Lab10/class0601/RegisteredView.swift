//
//  RegisteredView.swift
//  class0601
//
//  Created by Andy Lee on 2022/6/1.
//

import SwiftUI
import FirebaseAuth

struct RegisteredView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .textFieldStyle(.roundedBorder)
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            TextField("Name", text: $username)
                .textFieldStyle(.roundedBorder)
            Button("Registered") {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard let user = result?.user, error == nil else {
                        print(error?.localizedDescription)
                        dismiss()
                        return
                    }
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = username
                    changeRequest.commitChanges { error in
                        guard error == nil else {
                            print(error?.localizedDescription)
                            dismiss()
                            return
                        }
                    }
                }
                dismiss()
            }
        }.padding()
            .navigationTitle("Registered")
    }
}

struct RegisteredView_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredView()
    }
}
