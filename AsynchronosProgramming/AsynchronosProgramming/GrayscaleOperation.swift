//
//  GrayscaleOperation.swift
//  AsynchronosProgramming
//
//  Created by user176866 on 8/15/20.
//

import SwiftImage
import UIKit

class GrayscaleOperation: Operation {
    let uiImage: UIImage
    var grayscaleUIImage: UIImage?
    
    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    override func main() {
        let originalImage = Image<RGBA<UInt8>>(uiImage: self.uiImage)
        let grayscaleImage: Image<UInt8> = originalImage.map { $0.gray }
        self.grayscaleUIImage = grayscaleImage.uiImage
    }
}
