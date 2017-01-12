//
//  GIFImageViewController.swift
//  ProtoOne
//
//  Created by Don on 2016-08-08.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class GIFImageViewController: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let breatheGif = UIImage.gifWithName("breathe-gif")
        let imageView = UIImageView(image: breatheGif)
        imageView.frame = CGRect(x: 0.0, y: 180.0, width: 320.0, height: 180.0)
        
        view.addSubview(imageView)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

