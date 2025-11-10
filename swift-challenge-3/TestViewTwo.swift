//
//  TestViewTwo.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 10/11/25.
//

import SwiftUI
import WebKit

struct TestViewTwo: UIViewRepresentable {
    let name: String
    @State private var replayGIF = false
    
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
        TestViewTwo(name: "ChickenRest")
                .frame(width: 200, height: 200)
                .allowsHitTesting(false)
                .onTapGesture {
                    self.replayGIF.toggle()
               
        }
    }
}

#Preview {
    TestViewTwo(name: "ChickenRest")
}
