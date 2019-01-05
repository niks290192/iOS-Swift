//
//  ViewController.swift
//  NavTransition
//
//  Created by Simon Ng on 1/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var transitionImages = ["Doodle Icons-41", "Doodle Icons-42", "Doodle Icons-43", "Doodle Icons-44"]
    var transitions = ["Slide Down", "Slide Right", "Pop", "Rotate"]
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    let slideDownTransition = SlideDownTransitionAnimator()
    let slideRightTransition = SlideRightTransitionAnimator()
    let popTransition = PopTransitionAnimator()
    let rotateTransition = RotateTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transitionImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        cell.thumbnailImageView.image = UIImage(named: transitionImages[indexPath.row])
        cell.titleLabel.text = transitions[indexPath.row]
        
        return cell
        
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular) ? 80.0 : 100.0
        let height = (traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular) ? 105.0: 130.0
        return CGSize(width: width, height: height)
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            collectionView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController
        let sourceViewController = segue.sourceViewController as! ViewController
        
        if let selectedIndexPaths = sourceViewController.collectionView.indexPathsForSelectedItems() {
            switch selectedIndexPaths[0].row {
            case 0: toViewController.transitioningDelegate = slideDownTransition
            case 1: toViewController.transitioningDelegate = slideRightTransition
            case 2: toViewController.transitioningDelegate = popTransition
            case 3: toViewController.transitioningDelegate = rotateTransition
            default: break
            }
        }
    }
}

