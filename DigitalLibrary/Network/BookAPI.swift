//
//  BookAPI.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/04.
//

import LWBNetwork

struct BookAPI: API {
    typealias ResponseType = BookAPIResponseDTO
    
    var configuration: APIConfiguration?
    
    init(offset: String) {
        self.configuration = APIConfiguration(
            method: .get,
            baseURL: "https://library.me.go.kr",
            path: "/pyxis-api/2/collections/2/search",
            parameters: ["all": "k|a|library", "offset": offset],
            headerField: nil
        )
    }
}
