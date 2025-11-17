//
//  PartyHatView.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 17/11/25.
//

import SwiftUI
import WebKit

struct PartyHatView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = Bundle.main.url(forResource: name, withExtension: "img"),
           let data = try? Data(contentsOf: url) {
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        }
        webView.scrollView.isScrollEnabled = false // Optional: disable scrolling
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    var body: some View {
        StudyBreakView(name: "ChickenPartyHat")
            .frame(width: 30, height: 30)// Set appropriate frame
    }
}

#Preview {
    PartyHatView(name: "ChickenPartyHat")
}

