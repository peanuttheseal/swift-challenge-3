//
//  TestView.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 7/11/25.
//

import SwiftUI
import AVKit

struct TestView: View {
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 300) // Adjust frame as needed
                    .onAppear {
                        player.play() // Optional: Automatically play when the view appears
                    }
                    .onDisappear {
                        player.pause() // Optional: Pause when the view disappears
                    }
            } else {
                Text("Loading video...")
            }
        }
        .onAppear(perform: setupPlayer)
    }

    private func setupPlayer() {
        guard let videoURL = Bundle.main.url(forResource: "ChickenRest", withExtension: "mp4") else {
            print("Video file not found.")
            return
        }
        player = AVPlayer(url: videoURL)
    }
}

#Preview {
    TestView()
}
