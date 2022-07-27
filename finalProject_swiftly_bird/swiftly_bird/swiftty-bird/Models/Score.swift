//
//  Score.swift
//  edu.ntut.csie.swifttybird
//

import Foundation
import FirebaseFirestoreSwift

struct Score: Codable, Identifiable {
    @DocumentID var id: String?
    let deviceId: String
    let score: Int
}
