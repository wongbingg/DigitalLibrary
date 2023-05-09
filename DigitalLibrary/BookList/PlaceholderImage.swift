//
//  PlaceholderImage.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/05.
//

import SwiftUI

struct PlaceholderImage: View {
    var font: Font = .callout
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "book.closed")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(.secondary)
            Text("책 표지 이미지를\n 준비중입니다.")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct PlaceholderImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImage()
    }
}
