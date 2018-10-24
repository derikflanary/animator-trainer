//
//  PlayPauseViewController.swift
//  animator-trainer
//
//  Created by Derik Flanary on 10/23/18.
//  Copyright © 2018 Derik Flanary. All rights reserved.
//

import UIKit

class PlayPauseViewController: UIViewController {

    var animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut)

    @IBOutlet weak var animatingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        animatingView.layer.cornerRadius = animatingView.frame.width / 2
        animatingView.clipsToBounds = true
        animator.pausesOnCompletion = true
        animator.addAnimations {
            self.animatingView.center.y = 200
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator.stopAnimation(true)
    }

    @IBAction func play(_ sender: Any) {
        animator.isReversed = false
        animator.startAnimation()
    }

    @IBAction func reverse(_ sender: Any) {
        animator.isReversed = true
        animator.startAnimation()
    }

    @IBAction func pause(_ sender: Any) {
        animator.pauseAnimation()
    }

    @IBAction func left(_ sender: Any) {
        animator.addAnimations {
            self.animatingView.center.x = 50
        }
    }

    @IBAction func right(_ sender: Any) {
        animator.addAnimations {
            self.animatingView.center.x = self.view.bounds.width - 50
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        animator.stopAnimation(false)
        animator.finishAnimation(at: .start)
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            self.animatingView.center.y = 200
        })
        animator.pausesOnCompletion = true
    }

}
