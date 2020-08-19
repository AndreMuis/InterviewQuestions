//
//  OperationQueuesViewController.swift
//  AsynchronosProgramming
//
//  Created by user176866 on 8/15/20.
//

import UIKit

class OperationQueuesViewController: UIViewController {
    @IBOutlet weak var transformedImageView1: UIImageView!
    @IBOutlet weak var transformedImageView2: UIImageView!
    @IBOutlet weak var transformedImageView3: UIImageView!
    
    let operationQueue = OperationQueue()
    var operation1: GrayscaleOperation?
    var operation2: GrayscaleOperation?
    var operation3: GrayscaleOperation?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.transformedImageView1.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.transformedImageView2.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.transformedImageView3.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
    }
    
    @IBAction func transformButtonTapped(_ sender: Any) {
        print("transforming images . . .")
        
        self.transformedImageView1.image = nil
        self.transformedImageView2.image = nil
        self.transformedImageView3.image = nil
        
        self.operation1 = GrayscaleOperation(uiImage: UIImage(named: "landscape")!)
        self.operation2 = GrayscaleOperation(uiImage: UIImage(named: "lion")!)
        self.operation3 = GrayscaleOperation(uiImage: UIImage(named: "city")!)
        
        operation2?.addDependency(operation1!)
        operation3?.addDependency(operation2!)
        
        self.operation1?.completionBlock = {
            DispatchQueue.main.async {
                self.transformedImageView1.image = self.operation1?.grayscaleUIImage
            }
        }
        
        self.operation2?.completionBlock = {
            DispatchQueue.main.async {
                self.transformedImageView2.image = self.operation2?.grayscaleUIImage
            }
        }
        
        self.operation3?.completionBlock = {
            DispatchQueue.main.async {
                self.transformedImageView3.image = self.operation3?.grayscaleUIImage
            }
        }
        
        self.operationQueue.addOperation(self.operation1!)
        self.operationQueue.addOperation(self.operation2!)
        self.operationQueue.addOperation(self.operation3!)
    }
    
    @IBAction func cancelAllOperationsButtonTapped(_ sender: Any) {
        print("cancelling all operations")
        
        self.operationQueue.cancelAllOperations()
    }
}
