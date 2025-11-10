//
//  TestView.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 7/11/25.
//

import SwiftUI
import WebKit

struct TestView: UIViewRepresentable {
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
        TestView(name: "ChickenRest")
            .frame(width: 200, height: 200) // Set appropriate frame
    }
}

#Preview {
    TestView(name: "ChickenRest")
}
