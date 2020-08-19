//
//  ThreadsViewController.swift
//  AsynchronosProgramming
//
//  Created by user176866 on 8/11/20.
//

import SwiftImage
import UIKit

class ThreadsViewController: UIViewController {
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var transformedImageView: UIImageView!
    
    var thread: Thread?
    var transformedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.originalImageView.image = UIImage(named: "landscape")
        self.transformedImageView.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(threadWIllExit), name: .NSThreadWillExit, object: nil)
    }
    
    @IBAction func transformButtonTapped(_ sender: Any) {
        print("Transforming image . . .")
        
        self.thread = Thread(block: {
            let originalImage = Image<RGBA<UInt8>>(named: "landscape")!
            let grayscaleImage: Image<UInt8> = originalImage.map { $0.gray }
            self.transformedImage = grayscaleImage.uiImage
        })
        self.thread?.start()
    }
    
    @objc func threadWIllExit() {
        if Thread.current == self.thread {
            DispatchQueue.main.async {
                self.transformedImageView.image = self.transformedImage
            }
        }
    }
}
