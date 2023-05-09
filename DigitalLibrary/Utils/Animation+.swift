//
//  Animation+.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/04.
//

import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation
            .spring(dampingFraction: 0.7)
            .speed(2)
    }
}
