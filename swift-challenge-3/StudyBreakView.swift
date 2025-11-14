//
//  StudyBreakView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 14/11/25.
//


import SwiftUI
import WebKit

struct StudyBreakView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url) {
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        }
        webView.scrollView.isScrollEnabled = false // Optional: disable scrolling
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    var body: some View {
        StudyBreakView(name: "ChickenBreak")
            .frame(width: 200, height: 200)// Set appropriate frame
    }
}

#Preview {
    StudyBreakView(name: "ChickenBreak")
}
