//
//  Book.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/03.
//

import Foundation

struct Book: Decodable {
    let id: Int
    let thumbnailUrl: String?
    let titleStatement: String
    let author: String?
    let publication: String
}

extension Book {
    static func stub(id: Int = 0,
                     thumbnailUrl: String = "",
                     titleStatement: String = "",
                     author: String = "",
                     publication: String = ""
    ) -> Self {
        .init(id: id,
              thumbnailUrl: thumbnailUrl,
              titleStatement: titleStatement,
              author: author,
              publication: publication
        )
    }
}
