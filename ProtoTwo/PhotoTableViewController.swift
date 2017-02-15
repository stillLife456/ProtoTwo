//
//  PhotoTableViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-30.
//  Copyright © 2017 Don. All rights reserved.
//

import Foundation
import UIKit

class PhotoTableViewController: UITableViewController {
    @IBOutlet weak var navBar: UINavigationItem!

    var photoArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
    loadImages()
        
        print("string count: \(ImageBank.sharedInstance.appPhotoNamesArray.count)")
    
        print("Image count: \(photoArray.count)")
        
        navBar.title = "Your Motivation"
       
    
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func loadImages(){
  
        
        //either not loading or storing properly
        for i in ImageBank.sharedInstance.appPhotoNamesArray{
            
            let temp = i.photoName 
            print("Photo Name in Viewer: \(temp)")
            let fileManager = NSFileManager.defaultManager()
            let parentPath = ImageBank.sharedInstance.imagesDirectoryPath
            let imagePath = parentPath.stringByAppendingString("/\(temp).png")//thinking maybe it was object type?
            
            //let imagePath = (self.getDirectoryPath() as NSString).stringByAppendingPathComponent(i)
            
            print("ImagePath in lookup is: \(imagePath)")
            if fileManager.fileExistsAtPath(imagePath){
                photoArray.append(UIImage(contentsOfFile: imagePath)!)
            }else{
                print("No Image")
            }
            
        
        }
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return photoArray.count /// this might not work if its called before ViewDidLoad
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
               let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        
        cell.imageView!.image = photoArray[row]
        
        return cell
        
    }
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Benefits of Smoking"
//            
//        case 1:
//            return "Costs Of Smoking"
//        case 2:
//            return "Benefits Of Not Smoking"
//        case 3:
//            return "Costs Of Not Smoking"
//        case 4:
//            return "Totals"
//            
//        default:
//            return "I'm So Sad"
//        }
//    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 22))
//        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 22))
//        //label.font = UIFont.
//        label.text = sectionLabels[section]
//        
//        let btn = UIButton(type: UIButtonType.Custom) as UIButton
//        btn.frame = CGRect(x: view.frame.width - 62, y: 0, width: 50, height: 39)
//        btn.addTarget(self, action: #selector(CostBenefitTableViewController.pressed(_:)), forControlEvents: .TouchUpInside)
//        
//        btn.setImage(addButtonImage, forState: .Normal)
//        btn.tag = section
//        
//        if section == 4 {
//            btn.hidden = true
//        }
//        if pastSheetFlag {
//            btn.enabled = false
//        }
//        
//        
//        view.addSubview(btn)
//        view.addSubview(label)
//        view.backgroundColor = UIColor.grayColor() // Set your background color
//        
//        return view
//    }
    //MARK: Footer View Set Up
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    
//        
//        
//    }
//
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    
 
    

}

