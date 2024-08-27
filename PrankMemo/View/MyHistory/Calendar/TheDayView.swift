//
//  TheDayView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/26.
//

import SwiftUI

struct TheDayView: View {
    
    public let theDay: SCDate
    
    private var poopIconWidth: CGFloat {
        DeviceSizeUtility.deviceWidth / 7
    }

    var body: some View {
        VStack {
            if theDay.day == -1 {
                Color.black
                    .opacity(0.7)
            } else {
                NavigationLink {
                    
                } label: {
                    VStack(spacing: 0) {
                        Text("\(theDay.day)")
                            .frame(width: 40, height: 40)
                            .fontWeight(.bold)
                            .background(theDay.isToday ? Color.red : Color.clear)
                            .font(.system(size: DeviceSizeUtility.isSESize ? 14 : 18))
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .foregroundStyle(theDay.isToday ? Color.white : theDay.dayColor())
                            .foregroundStyle(.white)
                            .padding(.top, 3)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(.themaBlack)
    }
}

#Preview {
    TheDayView(theDay: SCDate.demo)
}
