//
//  BookDetailView.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/03.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @State private var stretchValue: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(.tertiarySystemBackground)
            ScrollView {
                VStack(spacing: 8) {
                    bookImage
                    HorizontalDivider(
                        color: .gray.opacity(0.1),
                        height: 15
                    )
                    .padding(.top)
                    description
                }
                .padding(.top, 20)
                .navigationTitle("상세정보")
                .navigationBarTitleDisplayMode(.inline)
                .coordinateSpace(name: "scroll")
                .background(GeometryReader { proxy in
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: proxy.frame(in: .named("scroll")).minY
                    )
                })
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    stretchValue = value - 91
                }
            }
        }
    }
    
    var bookImage: some View {
        AsyncImage(url: URL(string: book.thumbnailUrl ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: DeviceSize.width / 2,
                        height: (DeviceSize.height / 3) +
                        (stretchValue > 0 ? stretchValue : 0)
                    )
                    .offset(y: stretchValue > 0 ? -stretchValue : 0)
                    .shadow(radius: 20)
                
            } else if phase.error != nil || phase.image == nil {
                ZStack {
                    Color(.secondarySystemFill)
                        .frame(height: DeviceSize.height / 3)
                    PlaceholderImage(font: .headline)
                }
            } else {
                ProgressView()
            }
        }
    }
    
    var description: some View {
        VStack(spacing: 8) {
            Text(book.titleStatement)
                .font(.title3)
                .bold()
                .padding()
            HStack {
                Text("저자:")
                    .font(.callout)
                    .fontWeight(.black)
                Text(book.author ?? "저자 정보가 없습니다.")
            }
            HStack {
                Text("출판:")
                    .font(.callout)
                    .fontWeight(.black)
                Text(book.publication)
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var exampleURL = "https://image.aladin.co.kr/product/26761/87/cover/k602730482_1.jpg"
    static var previews: some View {
        BookDetailView(
            book: .stub(
                id: 1,
                thumbnailUrl: exampleURL,
                titleStatement: "파리의 도서관 : 자넷 스케슬린 찰스 장편소설",
                author: "스케슬린 찰스, 자넷",
                publication: "서울 : 하빌리스 : 대원씨아이,  2021"
            )
        )
    }
}
