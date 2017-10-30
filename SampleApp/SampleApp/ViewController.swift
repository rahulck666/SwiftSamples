//
//  ViewController.swift
//  SampleApp
//
//  Created by RAHUL CK on 10/27/17.
//  Copyright © 2017 Armino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstRoundView: UIView!

    @IBOutlet weak var secondRoundMiddleView: UIView!
    @IBOutlet weak var firstRoundMiddleView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var secondRoundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setup()  {
        firstRoundView.layer.cornerRadius = firstRoundView.bounds.size.width/2
        secondRoundView.layer.cornerRadius = secondRoundView.bounds.size.width/2
        firstRoundMiddleView.layer.cornerRadius = firstRoundMiddleView.bounds.size.width/2
        secondRoundMiddleView.layer.cornerRadius = secondRoundMiddleView.bounds.size.width/2

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()

    }
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    


}
