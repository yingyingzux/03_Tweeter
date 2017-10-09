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
    
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var accountTopMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!  // for menu view
    
    var originalTopMargin: CGFloat!   // for account view
    
    @IBOutlet var lpgr: UILongPressGestureRecognizer!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var accountViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            
            accountView.addSubview(accountViewController.view)
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

        /*
        lpgr = UILongPressGestureRecognizer(target: self, action: #selector (self.onLongPressGesture(_:)))
        lpgr.minimumPressDuration = 0.3
        contentView.navi.addGestureRecognizer(lpgr)
        
        //let lpgr = UILongPressGestureRecognizer(target: self, action: "onLongPressGesture:")
        */
        
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
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 140
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func onLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.began {
            
            
            
        } else if sender.state == UIGestureRecognizerState.changed {
            
            
            
        } else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }
    
}
