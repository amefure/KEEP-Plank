//
//  TheDayView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/26.
//

import SwiftUI

struct TheDayView: View {
    
    public let theDay: SCDate
    
    private func calcBackColor() -> Color {
        if theDay.count == 0 {
            if theDay.isToday {
                return .red
            } else {
                return .clear
            }
        } else {
            return .yellow
        }
    }

    var body: some View {
        VStack {
            if theDay.day != -1 {
                VStack(spacing: 0) {
                    Text("\(theDay.day)")
                        .frame(width: 40, height: 40)
                        .fontWeight(.bold)
                        .background(calcBackColor())
                        .font(.system(size: DeviceSizeUtility.isSESize ? 14 : 18))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .foregroundStyle(theDay.isToday ? Color.white : theDay.dayColor())
                        .foregroundStyle(.white)
                        .padding(.top, 3)
                }.frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(.themaBlack)
            }
        }.frame(maxWidth: .infinity)
            .frame(height: 70)
    }
}

#Preview {
    TheDayView(theDay: SCDate.demo)
}
