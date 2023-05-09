//
//  BookCell.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/03.
//

import SwiftUI

struct BookCell: View {
    var thumbnailURL: String?
    let titleStatement: String
    
    var body: some View {
        AsyncImage(url: URL(string: thumbnailURL ?? "")) { phase in
            if let image = phase.image {
                ZStack {
                    backgroundColor
                    BookImage(image: image)
                }
            } else if phase.error != nil || phase.image == nil {
                ZStack {
                    backgroundColor
                    PlaceholderImage()
                }
            } else {
                ProgressView()
            }
        }
        .overlay {
            gradientLayer
            bookTitle
        }
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private var backgroundColor: some View {
        Color(.secondarySystemFill)
            .frame(
                width: (DeviceSize.width / 3) - 16,
                height: 200
            )
    }
    
    private var gradientLayer: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .clear ,
                .clear,
                .black.opacity(0.8)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var bookTitle: some View {
        VStack {
            Spacer()
            Text(titleStatement)
                .padding()
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
        }
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(
            thumbnailURL: "https://image.aladin.co.kr/product/26761/87/cover/k602730482_1.jpg",
            titleStatement: "파리의 도서관 : 자넷 스케슬린 찰스 장편소설"
        )
    }
}
