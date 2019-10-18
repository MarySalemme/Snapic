//
//  ViewController.swift
//  snapic
//
//  Created by Mary Salemme on 17/10/2019.
//  Copyright © 2019 Mary Salemme. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.url(forResource: "image", withExtension: "JPG")

        let originalImage = CIImage(contentsOf: filePath!)

        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(originalImage, forKey: kCIInputImageKey)
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        guard let newImage = filter?.outputImage else {
            return
        }
        
        let image = convert(ciImage: newImage)

        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func convert(ciImage:CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}




