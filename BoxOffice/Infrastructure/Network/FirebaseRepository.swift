//
//  FirebaseRepository.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import Foundation

import RxSwift
import FirebaseFirestore

final class FirebaseRepository {
    
    func postReview(movieCode: String, review: Review, completion: @escaping () -> Void) {
        let databaseReference = Firestore.firestore().collection("movies").document(movieCode).collection("reviews")
        databaseReference.addDocument(data: [
            "date": review.date,
            "rating": review.rating,
            "username": review.username,
            "password": review.password,
            "content": review.content
        ])
        completion()
    }
    
    func fetchReviews(movieCode: String) -> Observable<[Review]> {
        return Observable.create { observer in
            let databaseReference = Firestore.firestore().collection("movies").document(movieCode).collection("reviews")
            databaseReference.addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let reviews = documents.compactMap { queryDocumentSnapshot -> Review? in
                    return try? queryDocumentSnapshot.data(as: Review.self)
                }
                
                observer.onNext(reviews.sorted { $0.date > $1.date })
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
