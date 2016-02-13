//
//  ViewController.swift
//  Hitta
//
//  Created by Gustaf Kugelberg on 13/02/16.
//  Copyright © 2016 Unfair. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UITableViewController {
    let animator = Animator()
    
    @IBOutlet weak var mapCell: UITableViewCell!
    @IBOutlet weak var mapView: MKMapView!

    private var expandMap = false
    
    // MARK: Lifetime

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: User actions
    
    @IBAction func tappedMap(sender: AnyObject) {
        expandMap = !expandMap
        tableView.beginUpdates()
        tableView.endUpdates()

        if expandMap {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), atScrollPosition: .Top, animated: true)
        }
        tableView.scrollEnabled = !expandMap
        
        //        let map = storyboard!.instantiateViewControllerWithIdentifier("Map")
////        map.transitioningDelegate = self
//        presentViewController(map, animated: true) {
//            print("Presented")
//        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 2 && expandMap ? view.frame.height : super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    // MARK: Overrides

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        animator.originFrame = mapView.superview!.convertRect(mapView.frame, toView: nil)
        
        animator.presenting = true

        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        animator.presenting = false
        return animator
    }
}

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration    = 2.0
    var presenting  = true
    var originFrame = CGRect()
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView(),
            targetView = transitionContext.viewForKey(UITransitionContextToViewKey),
            mapView = presenting ? targetView : transitionContext.viewForKey(UITransitionContextFromViewKey) else { return }
        
        if presenting {
            mapView.frame = originFrame
            mapView.clipsToBounds = true
        }

        containerView.addSubview(targetView)
        containerView.bringSubviewToFront(mapView)
        
        let endFrame = presenting ? mapView.frame : originFrame

        UIView.animateWithDuration(duration, animations: {
            mapView.frame = endFrame
            }, completion: { _ in transitionContext.completeTransition(true) })
    }
}


