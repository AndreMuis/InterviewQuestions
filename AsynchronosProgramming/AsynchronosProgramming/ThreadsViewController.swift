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
        
        self.originalImageView.image = UIImage(named: "LargeImage")
        
        NotificationCenter.default.addObserver(self, selector: #selector(threadWIllExit), name: .NSThreadWillExit, object: nil)
    }
    
    @IBAction func transformButtonTapped(_ sender: Any) {
        print("Transforming image . . .")
        
        self.thread = Thread(block: {
            let originalImage = Image<RGBA<UInt8>>(named: "LargeImage")!
            let binarizedImage: Image<Bool> = originalImage.map { $0.gray >= 127 }
            self.transformedImage = binarizedImage.uiImage
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
