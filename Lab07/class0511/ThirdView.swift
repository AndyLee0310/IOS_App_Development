//
//  ThirdView.swift
//  class0511
//
//  Created by Andy Lee on 2022/5/11.
//

import SwiftUI

struct ThirdView: View {
    let movieList = [
        Movie(name: "捍衛戰士：獨行俠", about: "故事敘述服役超過30年，身為海軍頂尖飛行員的「獨行俠」彼得米契爾上校 (湯姆克魯斯 飾) 仍舊堅守他的崗位，以試飛員的身份不斷突破飛行極限，也放棄任何足以終止飛行生涯的晉升。他在訓練一組 TOP GUN 菁英小組去執行一個前所未聞的特殊任務時，遇見了已故搭檔「呆頭鵝」尼克布雷德蕭中尉的兒子-「公雞」布雷德利布雷德蕭中尉 (麥爾斯泰勒 飾) 。在面對不確定的未來和來自過去夢靨的影響下，「獨行俠」在這個要求飛行員奉獻出最終代價的行動裡，被迫面對自己最深層的心魔。"),
        Movie(name: "奇異博士2：失控多重宇宙", about: "漫威影業2022年重磅鉅作，重新定義大銀幕視覺饗宴。 漫威宇宙進入第四階段，格局更宏大的多重宇宙，一個充滿危險，多重現實、奇異交錯的未知世界。奇異博士與信念相合的夥伴、神秘的盟友、還有敵我難分的故人，被迫闖入超乎想像的另類現實，抵抗神秘強大的對手。")
    ]
    var body: some View {
        let columns = Array(repeating: GridItem(), count: 2)
        NavigationView {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(movieList) { item in
                NavigationLink {
                    MovieDetail(movie: item)
                } label: {
                    BookView(movie: item)
                }
                }
            }
        }
        .navigationTitle("電影")
        }
    }
}

struct BookView: View {
    let movie: Movie
    var body: some View {
        VStack {
            Image(movie.name)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 200)
                .clipped()
            Text(movie.name)
        }

    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
