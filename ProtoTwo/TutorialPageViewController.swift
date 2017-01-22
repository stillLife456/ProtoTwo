//
//  TutorialPageViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-18.
//  Copyright © 2017 Don. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    //var storyboard: UIStoryboard?
    
    var viewControllerArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        getViewControllersForArray()
        
        if let firstViewController = viewControllerArray[0] as? UIViewController {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func getViewControllersForArray() {
        
        var storyboard: UIStoryboard?
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard!.instantiateViewControllerWithIdentifier("IntroSurvey")
        
        let firstVC = storyboard!.instantiateViewControllerWithIdentifier("TootA")
        let secondVC = storyboard!.instantiateViewControllerWithIdentifier("IntroSurvey")
        let thirdVC = storyboard!.instantiateViewControllerWithIdentifier("TootB")
        
        viewControllerArray.append(firstVC)
        viewControllerArray.append(secondVC)
        viewControllerArray.append(thirdVC)
    
    }
    

}


// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerArray.count > previousIndex else {
            return nil
        }
        
        return viewControllerArray[previousIndex]
        //return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = viewControllerArray.count
        
        guard viewControllersCount != nextIndex else {
            return nil
        }
        
        guard viewControllersCount > nextIndex else {
            return nil
        }
        
        return viewControllerArray[nextIndex]
        //return nil
    }
    
}
