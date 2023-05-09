//
//  HorizontalDivider.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/05.
//

import SwiftUI

struct HorizontalDivider: View {
    let color: Color
    let height: CGFloat
    
    init(color: Color, height: CGFloat = 0.5) {
        self.color = color
        self.height = height
    }
    
    var body: some View {
        color
            .frame(height: height)
    }
}
