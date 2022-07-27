//
//  ContentView.swift
//  class0518
//
//  Created by Andy Lee on 2022/5/18.
//

import SwiftUI

struct ContentView: View {
    @State private var isFan = true
    @State private var age = 30
    @State private var birthday = Date()
    @State private var score:Double = 1
    @State private var anyText:String = ""
    @State private var selectedIndex = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    let songList = ["說好不哭", "等你下課", "告白氣球", "我是如此相信"]
    
    var body: some View {
//        ScrollView {
            VStack {
                Text("周杰倫")
                    .font(.largeTitle)
                    .padding()
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
//                List{
                Toggle(isOn: $isFan) {
                    Text("是粉絲嗎？")
                }
                
                Stepper("年齡: \(age) 歲", value: $age)

                DatePicker("生日：", selection: $birthday, displayedComponents: .date)

                HStack {
                    Text("喜歡程度：\(Int(score))分")
                    Slider(value: $score, in: 0...10, step: 1)
                }
                
                HStack {
                    Text("喜歡的歌：")
                    
                    Picker("喜歡的歌：", selection: $selectedIndex) {
                        ForEach(songList.indices) { song in
                            Text(songList[song])
                        }
                    }
                    .pickerStyle(.wheel)
                }
//                Text("要是能重來，我要選\(songList[selectedIndex])")
                
                TextField("請說點什麼...", text: $anyText, prompt: Text("請說點什麼..."))
                    .textFieldStyle(.roundedBorder)
                    .padding()
//                }
                Button("送出") {
                    showAlert = true
                    alertTitle = isFan ? "我是粉絲" : "我不是粉絲"
                }
                .foregroundColor(.white)
                .frame(width: 90, height: 50, alignment: .center)
                .background(.blue)
                .frame(width: nil)
                .cornerRadius(20)
                .alert(alertTitle, isPresented: $showAlert, actions: {
                    Button("OK") { }
                }, message: {
                    Text("年齡是 \(age) 歲\n他的生日是 \(birthday.formatted(date: .long, time: .omitted))\n我喜歡他的程度是 \(Int(score)) 分\n喜歡的歌曲是 \(songList[selectedIndex])\n想跟他說 \(anyText)")
                })
            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
