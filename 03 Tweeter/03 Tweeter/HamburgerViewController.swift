//
//  HamburgerViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/5/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            
            contentView.addSubview(contentViewController.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
    
        let translation = sender.translation(in: self.view)
        
        let velocity = sender.velocity(in: self.view)
        
        if sender.state == UIGestureRecognizerState.began {
            
            originalLeftMargin = leftMarginConstraint.constant
        
        } else if sender.state == UIGestureRecognizerState.changed {
            
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        
        } else if sender.state == UIGestureRecognizerState.ended {
        
            UIView.animate(withDuration: 0.3, animations: {
                
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                
                self.view.layoutIfNeeded()
            })
            
            
        }
    
    }
    

}
