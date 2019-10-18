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

    var context: CIContext!
    var filter: CIFilter!
    var originalImage: CIImage!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var amountSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.url(forResource: "image", withExtension: "JPG")

        let originalImage = CIImage(contentsOf: filePath!)

        filter = CIFilter(name: "CISepiaTone")
        filter.setValue(originalImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
        let newImage = filter.outputImage
        let image = convert(ciImage: newImage!)

        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func convert(ciImage:CIImage) -> UIImage {
        context = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    @IBAction func amountSliderValueChanged(_ sender: UISlider) {
        
        let sliderValue = sender.value
        filter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        let newImage = filter.outputImage
        self.imageView.image = convert(ciImage: newImage!)
    }
}




