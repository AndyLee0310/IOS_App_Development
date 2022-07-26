//
//  MovieDetail.swift
//  class0511
//
//  Created by Andy Lee on 2022/5/11.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    var body: some View {
        VStack {
            Image(movie.name)
                .resizable()
                .scaledToFit()
            Text(movie.about)
                .padding()
        }
        .navigationTitle(movie.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: .demoMovie)
    }
}
