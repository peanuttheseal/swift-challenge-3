//
//  StudyBreakView 2.swift
//  swift-challenge-3
//
//  Created by T Krobot on 17/11/25.
//


//
//  StudyBreakView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 14/11/25.
//


import SwiftUI
import WebKit

struct StudyCookedView: UIViewRepresentable {
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
        StudyCookedView(name: "ChickenCooked")
            .frame(width: 300, height: 500)// Set appropriate frame
    }
}

#Preview {
    StudyCookedView(name: "ChickenCooked")
}
