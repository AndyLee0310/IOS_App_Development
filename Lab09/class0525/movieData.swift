//
//  movieData.swift
//  class0525
//
//  Created by Andy Lee on 2022/5/25.
//

import Foundation
import Combine

class movieData: ObservableObject{
    var cancel: AnyCancellable?
    @Published var movies = [movie]()
    
    init(){
        // 解碼，讀檔
        if let data = UserDefaults.standard.data(forKey: "movies"){
          let decoder = JSONDecoder()
          if let decodedData = try? decoder.decode([movie].self, from: data){
            users = decodedData
          }
        }
        // 編碼，存檔
        cancel = $users
            .sink(receiveValue: { (value) in
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(value) {
              UserDefaults.standard.set(data, forKey: "movies")
             }
            })
    }
}
