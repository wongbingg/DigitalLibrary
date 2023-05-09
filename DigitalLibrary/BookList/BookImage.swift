//
//  BookImage.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/05.
//

import SwiftUI

struct BookImage: View {
    let image: Image
    
    var body: some View {
        image.resizable()
            .scaledToFit()
            .cornerRadius(5)
            .frame(width: (DeviceSize.width / 3) - 32)
    }
}

struct BookImage_Previews: PreviewProvider {
    static var previews: some View {
        BookImage(image: Image(systemName: "plus"))
    }
}
