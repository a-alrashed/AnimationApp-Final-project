//
//  HomeViewController.swift
//  AnimationApp
//
//  Created by Azzam R Alrashed on 09/12/2020.
//

import UIKit

enum SwipeDirection {
    case right
    case left
    case up
    case down
}

class HomeViewController: UIViewController {

    @IBOutlet weak var FrontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var likeIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        
        FrontImage.layer.cornerRadius = 10
        backImage.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
        
    }
    

    @IBAction func didDoubleTap(_ sender: Any) {
        let likeIconOriginalSize = likeIcon.frame.size
        let likeIconOriginalPoint = likeIcon.center
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.likeIcon.alpha = 0.8
            self.likeIcon.frame.size = CGSize(width: 200, height: 200)
            self.likeIcon.center = likeIconOriginalPoint
        } completion: { (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.likeIcon.alpha = 0
                self.likeIcon.frame.size = likeIconOriginalSize
                self.likeIcon.center = likeIconOriginalPoint
            } completion: { (_) in
                //user did like the photo
            }
        }
    }
    
    @IBAction func didSwipeRight(_ sender: Any) {
        showNewImageAnimation(swipe: .right)
    }
    
    @IBAction func didSwipeLeft(_ sender: Any) {
        showNewImageAnimation(swipe: .left)
    }
    
    @IBAction func didSwipeUp(_ sender: Any) {
        showNewImageAnimation(swipe: .up)
    }
    @IBAction func didSwipeDown(_ sender: Any) {
        showNewImageAnimation(swipe: .down)
    }
    
    
    func showNewImageAnimation(swipe: SwipeDirection) {
        let backimageOriginalSize = backImage.frame.size
        let backimageOriginalPoint = backImage.center
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.FrontImage.transform = CGAffineTransform.identity.rotated(by: .pi )
            switch swipe {
            case .right: self.FrontImage.center = CGPoint(x: self.view.frame.maxX * 1.5, y: self.view.frame.midY - 200)
            case .left: self.FrontImage.center = CGPoint(x: -self.view.frame.maxX * 1.5, y: self.view.frame.midY - 200)
            case .up: self.FrontImage.center = CGPoint(x: self.view.frame.midX , y: -self.view.frame.maxY * 1.5)
            case .down: self.FrontImage.center = CGPoint(x: self.view.frame.midX , y: self.view.frame.maxY * 1.5)
            }
            self.backImage.frame.size = self.FrontImage.frame.size
            self.backImage.center = self.view.center
        } completion: { (_) in
            self.FrontImage.transform = CGAffineTransform.identity
            self.FrontImage.image = self.backImage.image
            self.FrontImage.center = self.view.center
            self.backImage.frame.size = backimageOriginalSize
            self.backImage.center = backimageOriginalPoint
            
        }
    }
    
    func setGradientBackground() {
        let colorTop =  #colorLiteral(red: 0.2274509804, green: 0.5490196078, blue: 0.8352941176, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0, green: 0.8235294118, blue: 1, alpha: 1).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
    }
    
}
