//
//  GCDViewController.swift
//  AsynchronosProgramming
//
//  Created by user176866 on 8/12/20.
//

import SwiftImage
import UIKit

class GCDViewController: UIViewController {
    @IBOutlet weak var originalImageView: UIImageView!
    
    @IBOutlet weak var transformedImageView: UIImageView!
    
    @IBOutlet weak var transformedImageView1: UIImageView!
    @IBOutlet weak var transformedImageView2: UIImageView!
    @IBOutlet weak var transformedImageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        self.originalImageView.image = UIImage(named: "LargeImage")
        
        self.transformedImageView.backgroundColor = UIColor(white: 0.85, alpha: 1.0)

        self.transformedImageView1.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.transformedImageView2.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.transformedImageView3.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
    }
    
    @IBAction func globalQueueButtonTapped(_ sender: Any) {
        print("Transforming image . . .")
        self.resetScreen()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let uiImage = self.convertToGrayscale(imageName: "LargeImage")
            
            DispatchQueue.main.async {
                self.transformedImageView.image = uiImage
            }
        }
    }
    
    @IBAction func customQueueButtonTapped(_ sender: Any) {
        print("Transforming image . . .")
        self.resetScreen()

        let queue = DispatchQueue(label: "CustomQueue")
        
        queue.async {
            let uiImage = self.convertToGrayscale(imageName: "LargeImage")
                      
            DispatchQueue.main.async {
                self.transformedImageView.image = uiImage
            }
        }
    }
    
    @IBAction func dispatchGroupButtonTapped(_ sender: Any) {
        print("Transforming images . . .")
        self.resetScreen()

        let group = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "CustomQueue1")
        let queue2 = DispatchQueue(label: "CustomQueue2")
        let queue3 = DispatchQueue(label: "CustomQueue3")

        var uiImage1: UIImage?, uiImage2: UIImage?, uiImage3: UIImage?
        
        queue1.async(group: group) {
            uiImage1 = self.convertToGrayscale(imageName: "LargeImage")
        }
        
        queue2.async(group: group) {
            let originalImage = Image<RGBA<UInt8>>(named: "LargeImage")!
            uiImage2 = originalImage.map{ $0.gray >= 128 }.uiImage
        }
        
        queue3.async(group: group) {
            let originalImage = Image<RGBA<UInt8>>(named: "LargeImage")!
            uiImage3 = originalImage.yReversed().uiImage
        }
        
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                self.transformedImageView1.image = uiImage1
                self.transformedImageView2.image = uiImage2
                self.transformedImageView3.image = uiImage3
            }
        }
    }
    
    func convertToGrayscale(imageName: String) -> UIImage {
        let originalImage = Image<RGBA<UInt8>>(named: "LargeImage")!
        let grayscaleImage: Image<UInt8> = originalImage.map { $0.gray }

        return grayscaleImage.uiImage
    }
    
    func resetScreen() {
        self.transformedImageView.image = nil
        
        self.transformedImageView1.image = nil
        self.transformedImageView2.image = nil
        self.transformedImageView3.image = nil
    }
}
