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
                return .themaRed
            } else {
                return .clear
            }
        } else {
            return .themaYellow
        }
    }
    
    private func calcTextColor() -> Color {
        if theDay.count == 0 {
            if theDay.isToday {
                return .white
            } else {
                return theDay.dayColor()
            }
        } else {
            if theDay.week == .sunday || theDay.week == .saturday {
                return theDay.dayColor()
            } else {
                return .themaBlack
            }
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
                        .foregroundStyle(calcTextColor())
                        .foregroundStyle(.white)
                        .padding(.top, 3)
                }.frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.themaBlack)
            } else {
                Color.white
                    .opacity(0.0001)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
            }
        }.frame(maxWidth: .infinity)
            .frame(height: 60)
    }
}

#Preview {
    TheDayView(theDay: SCDate.demo)
}
