//
//  ViewController.swift
//  FGInitialCircleImage
//
//  Created by Feng Guo on 19/01/2016.
//  Copyright © 2016 Feng Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var initialIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialIcon.image = FGInitialCircleImage.circleImage("John", lastName: "Appleseed", size: initialIcon.frame.size.width, borderWidth: 5, borderColor: UIColor.greenColor(), backgroundColor: UIColor.blueColor(), textColor: UIColor.whiteColor());
    }
}

