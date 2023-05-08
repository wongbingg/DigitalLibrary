//
//  BookAPIResponseDTO.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/04.
//

import Foundation

struct BookAPIResponseDTO: Decodable {
    let success: Bool
    let code: String
    let message: String
    let data: DataType
    
    struct DataType: Decodable {
        let isFuzzy: Bool
        let totalCount: Int
        let offset: Int
        let max: Int
        let list: [Book]
    }
}
