////
////  DefaultPosterImagesRepository.swift
////  BoxOffice
////
////  Created by rae on 2022/11/25.
////
//
//import Foundation
//
//final class DefaultPosterImagesRepository {
//    private let networkImageSerivce: NetworkImageService
//    
//    init(networkImageSerivce: NetworkImageService) {
//        self.networkImageSerivce = networkImageSerivce
//    }
//}
//
//extension DefaultPosterImagesRepository: PosterImagesRepository {
//    func fetchImage(with path: String) async throws -> Data {
//        let urlString = "https://image.tmdb.org/t/p/w500\(path)"
//        let imageData = try await networkImageSerivce.getImage(with: urlString)
//        return imageData
//    }
//}
