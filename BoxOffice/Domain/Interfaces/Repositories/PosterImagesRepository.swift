//
//  PosterImagesRepository.swift
//  BoxOffice
//
//  Created by rae on 2022/11/24.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with path: String) async throws -> Data
}
