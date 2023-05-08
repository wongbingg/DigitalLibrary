//
//  BookData.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/03.
//

import Foundation

protocol BookDataInput {
    func fetchBooks() async throws
}

protocol BookDataOutput {
    var bookList: [Book] { get }
}

protocol BookData: BookDataInput, BookDataOutput {}

final class DefaultBookData: BookData, ObservableObject {
    @Published var bookList: [Book] = []
    private var pageOffset = 0
    private var totalCount = 1
    
    @MainActor
    func fetchBooks() async throws {
        guard totalCount > pageOffset else {
            throw BookDataError.noMorePage
        }
        let api = BookAPI(offset: String(pageOffset))
        let response = try await api.execute()
        bookList += response.data.list
        pageOffset += 20
        
        guard totalCount == 1 else {
            return
        }
        totalCount = response.data.totalCount
    }
}

enum BookDataError: LocalizedError {
    case noMorePage
    
    var errorDescription: String? {
        switch self {
        case .noMorePage:
            return "더 이상 페이지가 존재하지 않습니다."
        }
    }
}
