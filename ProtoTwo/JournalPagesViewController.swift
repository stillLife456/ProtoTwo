//
//  JournalPagesViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-02-07.
//  Copyright © 2017 Don. All rights reserved.
//

import UIKit

class JournalPagesViewController: UIPageViewController,  UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: Delgate
    
    func viewControllerAtIndex(index: Int) -> UINavigationController! {
        
        //but I dont want to change VC just data?
    
            
            return self.storyboard!.instantiateViewControllerWithIdentifier("JournalPagesNavController") as! UINavigationController // added two(!)
            
    
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
       
        return self.viewControllerAtIndex(1) // I just gave it an int to shut it up
        
    }
    
    func pageViewController(pageViewController: UIPageViewController!, viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
        
        let identifier = viewController.restorationIdentifier
        //let index = self.identifiers.indexOfObject(identifier)
        
//        //if the index is 0, return nil since we dont want a view controller before the first one
//        if index == 0 {
//            
//            return nil
//        }
//        
//        //decrement the index to get the viewController before the current one
//       // self.index = self.index - 1
        return self.viewControllerAtIndex(1)
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return Journal.sharedInstance.sortedJournalDict.count // should be one for each day that has a journal entry
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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


