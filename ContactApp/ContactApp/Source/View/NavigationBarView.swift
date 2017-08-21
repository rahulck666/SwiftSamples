//
//  NavigationBarView.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/20/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

protocol NavigationBarViewDelegate:NSObjectProtocol {
    
    func didTapNavigationLeftButton(sender:Any)
    func didTapNavigationRightButton(sender:Any)
}

class NavigationBarView: UIView {
    
    
    @IBOutlet weak var leftButton: UIButton?
    @IBOutlet weak var rightButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    weak var delegate:NavigationBarViewDelegate?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func leftButtonTapped(_ sender:Any) {
        delegate?.didTapNavigationLeftButton(sender: sender)
        
    }
    @IBAction func rightButtonTapped(_ sender:Any) {
        delegate?.didTapNavigationRightButton(sender: sender)
    }
    
    func configure(title:String,isLeftButtonHidden:Bool,isRightButtonHidden:Bool)  {
        leftButton?.isHidden = isLeftButtonHidden
        rightButton?.isHidden = isRightButtonHidden
        titleLabel?.text = title
    }
    func setLeftButtonTitle(_ title:String)  {
        leftButton?.setTitle(title, for: .normal)
    }
    func setRightButtonTitle(_ title:String)  {
        rightButton?.setTitle(title, for: .normal)
    }
  

}
