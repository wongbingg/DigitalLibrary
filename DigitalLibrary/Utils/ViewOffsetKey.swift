//
//  ViewOffsetKey.swift
//  DigitalLibrary
//
//  Created by 이원빈 on 2023/05/04.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
