//
//  ViewController.swift
//  animator-trainer
//
//  Created by Derik Flanary on 10/23/18.
//  Copyright © 2018 Derik Flanary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var panGestureRecognizer: InstantPanGestureRecognizer!

    var animator = UIViewPropertyAnimator()
    var startLocation: CGPoint = .zero
    var fractionComplete: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: {
            self.visualEffectView.alpha = 0.0
        })
        animator.pausesOnCompletion = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator.stopAnimation(true)
    }


    @IBAction func playTapped(_ sender: Any) {
        switch animator.state {
        case .inactive:
            animator.startAnimation()
        case .stopped, .active:
            animator.isReversed = !animator.isReversed
            animator.startAnimation()
        }
    }

    @IBAction func panned(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            startLocation = sender.location(in: self.view)
            if animator.isRunning {
                animator.pauseAnimation()
            }
            fractionComplete = animator.fractionComplete
            animator.isReversed = false
        case .changed:
            animator.fractionComplete = fractionComplete + sender.translation(in: view).x / 200
        case .ended:
            animator.pauseAnimation()
        default:
            return
        }
    }
    
}


class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
    }

}

