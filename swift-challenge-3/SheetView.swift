//
//  SheetView.swift
//  swift-challenge-3
//
//  Created by Sophie Tjhi on 10/11/25.
//

import SwiftUI

struct SheetView: View {
    
        @Binding var isPresented: Bool

        var body: some View {
            VStack {
                Text("Set your daily time goal!")
                    .font(.title)
                    .padding()
                    .monospaced()
                HStack {
                    Spacer()
                    Text("You won’t see this popup again. You can edit your goal in Settings.")
                        .font(.title3)
                        .padding()
                        .monospaced()
                    Spacer()
                }
            }
        }
    }
