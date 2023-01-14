//
//  Review.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import Foundation
import FirebaseFirestoreSwift

struct Review: Codable {
    @DocumentID var id: String?
    
    let rating: Double
    let username: String
    let password: String
    let content: String
}
