//
//  FirebaseRepository.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import Foundation

import FirebaseDatabase

final class FirebaseRepository {
    
    func postReview(movieCode: String, review: Review) {
        let databasePath = Database.database().reference().child("\(movieCode)")
        let data = try? JSONEncoder().encode(review)
        databasePath.setValue(data)
    }
}
