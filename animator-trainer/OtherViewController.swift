//
//  OtherViewController.swift
//  animator-trainer
//
//  Created by Derik Flanary on 10/23/18.
//  Copyright © 2018 Derik Flanary. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    var animator = UIViewPropertyAnimator()
    var panGestureRecognizer = UIPanGestureRecognizer()
    var currentFractionComplete: CGFloat = 0.0

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var object: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        object.clipsToBounds = true
        imageView.clipsToBounds = true
        resetAnimator()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator.stopAnimation(true)
    }

    @IBAction func panned(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            animator.isReversed = false
        case .changed:
            animator.fractionComplete = abs(sender.translation(in: object).y / 150)
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }

    @IBAction func undo(_ sender: Any) {
        animator.isReversed = true
        animator.startAnimation()
    }

    @IBAction func magicButtonTapped(_ sender: Any) {
        animator.addAnimations {
            self.object.backgroundColor = .cyan
            self.imageView.alpha = 1.0
            self.imageView.layer.cornerRadius = 20
        }
    }

    func resetAnimator() {
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeOut, animations: {
            self.object.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.object.layer.cornerRadius = 20
        })
        animator.pausesOnCompletion = true
        animator.pauseAnimation()
    }
    
}
