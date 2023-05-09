//
//  BookListView.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/03.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var bookData = DefaultBookData()
    @State private var shouldFetchMoreBooks: Bool = false
    @State private var isSuccessAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    private var columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            gridView
                .navigationTitle("📚 디지털 도서관")
                .coordinateSpace(name: "scroll")
                .background(Color(.tertiarySystemBackground))
                .overlay {
                    VStack {
                        Spacer()
                        ToastMessage(
                            isSuccessAlert: $isSuccessAlert,
                            showAlert: $showAlert,
                            message: $alertMessage
                        )
                    }
                }
                .onChange(of: shouldFetchMoreBooks) {
                    guard $0 == true else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        fetchData()
                        shouldFetchMoreBooks = false
                    }
                }
        }
    }
    
    private var gridView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(bookData.bookList, id: \.id) { book in
                        NavigationLink {
                            BookDetailView(book: book)
                        } label: {
                            BookCell(
                                thumbnailURL: book.thumbnailUrl,
                                titleStatement: book.titleStatement
                            )
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetKey.self,
                        value: proxy.frame(in: .named("scroll")).height +
                        proxy.frame(in: .named("scroll")).minY
                    )
                })
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    let atBottomValue = DeviceSize.height - CGFloat(160)
                    let scrollOffset = atBottomValue - value
                    
                    if scrollOffset > 100 {
                        guard shouldFetchMoreBooks == false else { return }
                        shouldFetchMoreBooks = true
                    }
                }
                
                if shouldFetchMoreBooks {
                    ProgressView()
                }
            }
        }
    }
}

// MARK: - Methods
private extension BookListView {
    
    func fetchData() {
        Task {
            do {
                try await bookData.fetchBooks()
            } catch let error {
                guard let error = error as? BookDataError else {
                    print(error.localizedDescription)
                    return
                }
                showAlert(
                    isSuccess: false,
                    message: error.localizedDescription
                )
            }
        }
    }
    
    func showAlert(isSuccess: Bool, message: String) {
        isSuccessAlert = isSuccess
        alertMessage = message
        showAlert = true
    }
}

// MARK: - Previews
struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
