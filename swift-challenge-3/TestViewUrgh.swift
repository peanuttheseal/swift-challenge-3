//
//  TestViewUrgh.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 10/11/25.
//

import SwiftUI
import UIKit
import ImageIO

struct TestViewUrgh: UIViewRepresentable {
    let gifName: String
    @Binding var replayTrigger: Bool
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.image = animatedImage(from: gifName)
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        if replayTrigger {
            uiView.stopAnimating()
            uiView.image = animatedImage(from: gifName)
            uiView.startAnimating()
            DispatchQueue.main.async { replayTrigger = false }
        }
    }
    
    private func animatedImage(from name: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        var images: [UIImage] = []
        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(count) / 24.0)
    }
    
    @State private var replay = false
    
    var body: some View {
        TestViewUrgh(gifName: "ChickenRest", replayTrigger: $replay)
            .onTapGesture {
                replay = true
            }
    }
}

#Preview{
    TestViewUrgh(gifName: "ChickenRest", replayTrigger: $replayTrigger)
}
