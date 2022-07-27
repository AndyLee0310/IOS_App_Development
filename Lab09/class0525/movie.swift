//
//  movie.swift
//  class0525
//
//  Created by Andy Lee on 2022/5/25.
//

import Foundation

struct Movie : Identifiable,Codable {
    let id = UUID()
    var movieType: String
    var Name: String
}
