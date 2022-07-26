//
//  ContentView.swift
//  class0504
//
//  Created by Andy Lee on 2022/5/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Image("health_photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                HStack(alignment: .bottom, spacing: 50.0) {
                    Text("Health Sharing")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                HStack {
                    Image("health1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("You're in Control")
                            .font(.system(size: 15))
                        Text("Keep friends and family up to date on \nhow you're doing by securely sharing \nyour Health data.")
                            .foregroundColor(Color.gray)
                    }
                }
                HStack {
                    Image("health2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Dashboard and Notifications")
                            .font(.system(size: 15))
                        Text("Data you share will appear in their       \nHealth app. They can also get \nnotifications if there's an update.")
                            .foregroundColor(Color.gray)
                    }
                }
                HStack {
                    Image("health3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Private and Secure")
                            .font(.system(size: 15))
                        Text("Only a summary of each topic is \nshared, not the details. The \ninformation is encrypted and you can \nstop sharing at any time.")
                            .foregroundColor(Color.gray)
                    }
                }
            }.padding(15)

            Button {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            } label: {
                Text("Share with Someone")
                    .font(.system(size: 20))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        
        ZStack(alignment: .top) {
            VStack {
                Image("news")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                HStack(alignment: .bottom, spacing: 35.0) {
                    Text(" New+")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(10)
                }
                HStack(alignment: .bottom, spacing: 35.0) {
                    Text("Great news!")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
                HStack(alignment: .bottom, spacing: 35.0) {
                    Text("Audio stories are here.")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)
                }
                HStack(alignment: .bottom, spacing: 35.0) {
                    Text("Listen only in Apple News+.")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }

                Button ("Get Started") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50, alignment: .center)
                .background(.pink)
                .frame(width: nil)
                .cornerRadius(17)
                
                HStack(alignment: .bottom, spacing: 35.0) {
                    Text("Plan auto-renews for $9.99/month until canceled.")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
