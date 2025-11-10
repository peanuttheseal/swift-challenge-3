//
//  swift_challenge_3App.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI

@main
struct swift_challenge_3App: App {
    var body: some Scene {
        WindowGroup {
            TestViewUrgh(gifName: "ChickenRest", replayTrigger: .constant(false))
        }
    }
}

// MAIN COLOUR SCHEME
    // #FFFCF4 -> Main colour, super super super pale yellow, use as background
    // #FFF4D1 -> Main colour, pale yellow
    // #F5B678 -> Side colour, medium orange, use for the goals ring
    // #F5C978 -> Side colour, light-medium orange
    // #F5E778 -> Side colour, yellow tinted orange
    // #F5D878 -> Side colour, yellow bordering on light orange
    // #F1F578 -> Side colour, bright yellow bordering on neon, use as a last resort
