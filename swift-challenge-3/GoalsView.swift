//
//  GoalsView.swift
//  swift-challenge-3
//
//  Created by Lim Ying Hsin on 7/11/25.
//

import SwiftUI

struct GoalsView: View {
    private let timer = Timer-publish(every: 1, on: main, in: -common).autoconnect() // 1
    @State private var tick: Int = 0

    var body: some View {
       
        VStack {
        Text("\(tick)")
        }
        .onReceive(timer) { - in 
        tick += 1
        // Update
        }
        .onDisappear {
        // Stop
        timer.upstream.connect().cancel() // 3
    }
}


#Preview {
    GoalsView()
}
