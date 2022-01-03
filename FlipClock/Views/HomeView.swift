//
//  HomeView.swift
//  FlipClock
//
//  Created by Albert Kornas on 1/3/22.
//  Copyright © 2022 Maciej Gomółka. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .center) {
            ClockView()
            OptionsButton()
        }
    }
}

typealias OptionFunction = () -> Void
struct OptionToggleView: View {
    @State var text: String
    @Binding var toggled: Bool
    var body: some View {
        HStack {
            Toggle(isOn: $toggled) {
                Text(text)
            }
        }
    }
}

struct OptionsSheet: View {
    @EnvironmentObject var clockViewModel: ClockViewModel
    
    var body: some View {
        List {
            OptionToggleView(text: "Military time", toggled: $clockViewModel.militaryTime)
        }
    }
}

struct OptionsButton: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Options", action: {
            showingSheet.toggle()
        }).sheet(isPresented: $showingSheet) {
            OptionsSheet()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
