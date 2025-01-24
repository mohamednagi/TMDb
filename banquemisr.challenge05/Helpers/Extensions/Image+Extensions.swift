//
//  Image+Extensions.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import SwiftUI

extension Image {
    // Helper method to convert SwiftUI Image to UIImage
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = CGSize(width: 300, height: 300)
        view?.frame = CGRect(origin: .zero, size: targetSize)
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
    }
}
