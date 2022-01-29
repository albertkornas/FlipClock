//
//  GradientView.swift
//  FlipClock
//
//  Created by Albert Kornas on 1/3/22.
//  Copyright © 2022 Maciej Gomółka. All rights reserved.
//

import SwiftUI

extension LinearGradient {
    public static var morning: LinearGradient {
        let top = Color(red: 42/255, green: 210/255, blue: 255/255)
        let mid = Color(red: 255/255, green: 246/255, blue: 108/255)
        let bottom = Color(red: 245/255, green: 166/255, blue: 63/255)
        return LinearGradient(colors: [top, mid, bottom], startPoint: .top, endPoint: .bottom)
    }
    
    public static var afternoon: LinearGradient {
        let top = Color(red: 20/255, green: 132/255, blue: 205/255)
        let mid = Color(red: 42/255, green: 210/255, blue: 255/255)
        let bottom = Color(red: 123/255, green: 217/255, blue: 246/255)
        return LinearGradient(colors: [top, mid, bottom], startPoint: .top, endPoint: .bottom)
    }
}

struct GradientView: View {
    @EnvironmentObject var clockViewModel: ClockViewModel
    
    var body: some View {
        GeometryReader { geo in
        Rectangle()
                .fill(currentGradient(codes: clockViewModel.gradientValues))
                .frame(width: geo.size.width, height: geo.size.height)
            
        }
    }
}

func currentGradient(codes: [[Double]]) -> LinearGradient {
    let top = Color(red: codes[0][0]/255, green: codes[0][1]/255, blue: codes[0][2]/255)
    let mid = Color(red: codes[1][0]/255, green: codes[1][1]/255, blue: codes[1][2]/255)
    let bottom = Color(red: codes[2][0]/255, green: codes[2][1]/255, blue: codes[2][2]/255)
    return LinearGradient(colors: [top, mid, bottom], startPoint: .top, endPoint: .bottom)
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
