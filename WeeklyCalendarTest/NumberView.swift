//
//  NumberView.swift
//  WeeklyCalendarTest
//
//  Created by Sooik Kim on 2023/02/27.
//

import SwiftUI

struct NumberView: View {
    @Binding var numbers: [Int]
    let frameWidt: CGFloat = UIScreen.main
        .bounds.width * 0.13
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numbers.count, id: \.self) { i in
                ZStack {
                    Text("\(numbers[i])")
                }
                .frame(width: frameWidt)
            }
        }
    }
}

