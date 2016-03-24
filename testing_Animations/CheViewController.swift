//
//  CheViewController.swift
//  testing_Animations
//
//  Created by user on 3/20/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class CheViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cheImageView: UIImageView!
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceNewCenter: CGPoint!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y - 150)
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapTray(sender: AnyObject) {
        
        if self.trayView.center == trayCenterWhenOpen {
            print(">>>Click it down")
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenClosed!
            })
        }else if self.trayView.center == trayCenterWhenClosed {
            print(">>>Click it up")
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenOpen!
            })
        }
    }
    
    @IBAction func onPanTray(sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocityInView(trayView).y

        let translation = sender.translationInView(mainView)
        let point = sender.locationInView(mainView)
        
        

        
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity > 0 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: velocity/20, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenClosed!
                    }, completion: { (Bool) -> Void in
                        
                })
            }else if velocity < 0 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenOpen!
                })
            }
        }
    
        
    }
 
    @IBAction func onPanChe(sender: UIPanGestureRecognizer) {
        NSLog("Panned Che")
        
        self.trayView.center = self.trayCenterWhenOpen!
        let point = sender.locationInView(self.view)

//        var translation = sender.translationInView(mainView)



        if sender.state == .Began {
            print("began pan")
            let imageView = sender.view as! UIImageView
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.center = imageView.center
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            let tapGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomSmilyPanGesture:")
            newlyCreatedFace.addGestureRecognizer(tapGestureRecognizer)
            newlyCreatedFace.userInteractionEnabled = true
            

            
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        

        })

        } else if sender.state == .Changed {
            print("change pan")
            self.newlyCreatedFace.center = point

  

            
               
        }else if sender.state == .Ended {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.cheImageView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                
                
            }
        

        }
        
    }


    @IBAction func onMainTapGesture(sender: UITapGestureRecognizer) {
        print("You tapped on the View")
        newlyCreatedFace.image = nil
    }
    
    
    
    
    func onCustomSmilyPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        // Absolute (x,y) coordinates in parent view
        let point = panGestureRecognizer.locationInView(self.view)

        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
           
            newlyCreatedFace = panGestureRecognizer.view as! UIImageView

            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.0, 1.0)})
                

            print("CUSTOM PAN BEGAN")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("CUSTOM PAN CHANGED")
            
            
            self.newlyCreatedFace.center = point
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.2, 1.2)})
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)})
        }
        
        
        
    }
    
    






}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


