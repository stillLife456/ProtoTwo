//
//  CostBenefitTableViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-22.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit





class CostBenefitTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    var passedArray = [DescriptionAndRating]()
    var allArrays = [DescriptionAndRating]()
    var benSmoke = [DescriptionAndRating]()
    var costSmoke = [DescriptionAndRating]()
    var benNotSmoke = [DescriptionAndRating]()
    var costNotSmoke = [DescriptionAndRating]()
    
    let sectionLabels = ["Benefits Of Smoking","Cost Of Smoking","Beneftis Of Not Smoking","Costs of Not Smoking", "Totals"]
    let footerLabels = ["Total Benefits Of Smoking","Total Costs Of Smoking","Total Benefits Of Not Smoking","Total Costs Of Not Smoking","Shouldn't be Seen",]
    let totalLabels = ["Total For Smoking","Total For Not Smoking"]
    
    let pickerValues = [1,2,3,4,5]
    let picker = UIPickerView()
    var passInt = 0
    var currentSection = 0
    var sectionTotals = [Int]()
    var tempDescription = ""
    var tempRating = 0
    
    var currentSmokeTotal = 0
    var currentNotSmokeTotal = 0
    
    var arrayToSave = [AnyObject]()
    
    var pastSheetFlag = false
    
    
    
    let addButtonImage = ImageBank.sharedInstance.addButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        if passedArray.isEmpty{
            fakeDataForNow()
        }
        else{
            
            print("Should have sorted")
            sortArrayIntoSections()
            print("Should have filled")
            getRatingTotals()
        }
        
        
        setUpTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Done, target: self, action: #selector(saveButtonPressed))
        
        
        picker.dataSource = self
        picker.delegate = self
        
        
        simpleUpdateTableView()
        
    }
    
    func printArrays(){
    
        print("BenSmoke Count is:")
        for i in benSmoke {
            print(i.descriptionString)
            print(i.rating)
            print(i.sectionInt)
        
        }
        print("CostSmoke Count is:")
        for i in costSmoke {
            print(i.descriptionString)
            print(i.rating)
            print(i.sectionInt)
            
        }
        print("BenNotSmoke Count is:")
        for i in benNotSmoke {
            print(i.descriptionString)
            print(i.rating)
            print(i.sectionInt)
            
        }
        print("CostNotSmoke Count is:")
        for i in costNotSmoke {
            print(i.descriptionString)
            print(i.rating)
            print(i.sectionInt)
            
        }
    
    }
    
    func sortArrayIntoSections(){
        for item in passedArray{
            switch item.sectionInt {
                
            case (0):
                benSmoke.append(item)
            case(1):
                costSmoke.append(item)
            case(2):
                benNotSmoke.append(item)
            case(3):
                costNotSmoke.append(item)
            default:
                print("Thing was out of range")
                
            }
            
        }
        print("First array has")
        
        print(benSmoke.count)
        
    }
    
    func fillInFields(){
        
        
    }
    
    
    
    func saveButtonPressed(){
        print("Save Pressed")
        
        allArrays.appendContentsOf(benSmoke)
        allArrays.appendContentsOf(costSmoke)
        allArrays.appendContentsOf(benNotSmoke)
        allArrays.appendContentsOf(costNotSmoke)
        
        //print(allArrays)
        
        let tempSheet = CostBenefitSheetModel(contents: allArrays, dateMade: NSDate())
        AllCostBenefitSheets.sharedInstance.allSheetsArray.append(tempSheet)
        AllCostBenefitSheets.sharedInstance.saveCostBenSheets()
        
        self.performSegueWithIdentifier("backAfterSave", sender: self)
        
        
    }
    
    func setUpTableView(){
        print("Settin it UP")
    }
    
    func fakeDataForNow(){
        
        let blankMessage = ""
        let blankRating = 0
        let blankCellData = DescriptionAndRating(description: blankMessage, rating: blankRating, sectionInt: 4)
        
        benSmoke.append(blankCellData)
        costSmoke.append(blankCellData)
        benNotSmoke.append(blankCellData)
        costNotSmoke.append(blankCellData)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark: Picker Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerValues[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.passInt = pickerValues[row]
        print(pickerValues[row])
        self.view.endEditing(true)
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if benSmoke.count > 0{
                return benSmoke.count
            }else{
                return 1
            }
        case 1:
            if costSmoke.count > 0{
                return costSmoke.count
            }else{
                return 1
            }
        case 2:
            if benNotSmoke.count > 0{
                return benNotSmoke.count
            }else{
                return 1
            }
        case 3:
            if costNotSmoke.count > 0{
                return costNotSmoke.count
            }else{
                return 1
            }
        case 4:
            return 2
        case 5:
            print("index confusion")
            return 1
        default:
            return 0
        }
        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Benefits of Smoking"
            
        case 1:
            return "Costs Of Smoking"
        case 2:
            return "Benefits Of Not Smoking"
        case 3:
            return "Costs Of Not Smoking"
        case 4:
            return "Totals"
            
        default:
            return "I'm So Sad"
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 22))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 22))
        //label.font = UIFont.
        label.text = sectionLabels[section]
        
        let btn = UIButton(type: UIButtonType.Custom) as UIButton
        btn.frame = CGRect(x: view.frame.width - 62, y: 0, width: 50, height: 39)
        btn.addTarget(self, action: #selector(CostBenefitTableViewController.pressed(_:)), forControlEvents: .TouchUpInside)
        
        btn.setImage(addButtonImage, forState: .Normal)
        btn.tag = section
        
        if section == 4 {
            btn.hidden = true
        }
        if pastSheetFlag {
            btn.enabled = false
        }
        
        
        view.addSubview(btn)
        view.addSubview(label)
        view.backgroundColor = UIColor.grayColor() // Set your background color
        
        return view
    }
    //MARK: Footer View Set Up
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section{
        case 0...3:
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
            
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width - 40, height: 20))
            //label.font = UIFont.systemFont(ofSize: 18)
            label.text = footerLabels[section]
            
            let totalLabel = UILabel(frame: CGRect(x: label.frame.size.width + 10, y: 5, width: 30, height: 18))
            //totalLabel.font = UIFont.systemFont(ofSize: 14)
            
            let currentTotal = getSectionRatingTotals(section)
            totalLabel.text = String(currentTotal)
            
            footerView.addSubview(label)
            footerView.addSubview(totalLabel)
            
            return footerView
            
        case 4:
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return footerView
            
        default:
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return footerView
        }
        
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    @objc func pressed(sender: UIButton){
        
        let section = sender.tag
        switch section {
        case 0:
            createBlankCellData(section)
            insertNewRowIntoSection(benSmoke.count, section: section )
        case 1:
            createBlankCellData(section)
            insertNewRowIntoSection(costSmoke.count, section: section )
        case 2:
            createBlankCellData(section)
            insertNewRowIntoSection(benNotSmoke.count, section: section )
        case 3:
            createBlankCellData(section)
            insertNewRowIntoSection(costNotSmoke.count, section: section )
        case 4:
            print("This should be deleted")
        default:
            break
            
        }
    }
    
    func getSectionRatingTotals(section: Int)-> Int{
        
        var currentTotal = 0
        switch section {
            
        case 0:
            for item in benSmoke {
                currentTotal += item.rating
            }
        case 1:
            for item in costSmoke {
                currentTotal += item.rating
            }
        case 2:
            for item in benNotSmoke {
                currentTotal += item.rating
            }
        case 3:
            for item in costNotSmoke {
                currentTotal += item.rating
            }
        case 4:
            print("")
        default:
            break
        }
        return currentTotal
    }
    
    func getRatingTotals(){
        let forSmoking = getSectionRatingTotals(0) + getSectionRatingTotals(3)
        let againstSmoking = getSectionRatingTotals(1) + getSectionRatingTotals(2)
        
        self.currentSmokeTotal = forSmoking
        self.currentNotSmokeTotal = againstSmoking
        
    }
    
    func insertNewRowIntoSection(row: Int, section: Int){
        
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([
            NSIndexPath(forRow: row-1, inSection: section)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    func simpleUpdateTableView(){
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
        
    }
    
    func createBlankCellData(section: Int){
        let blankMessage = ""
        let blankRating = 0
        
        let blankCellData = DescriptionAndRating(description: blankMessage, rating: blankRating, sectionInt: 4 )
        
        
        switch section {
        case 0:
            
            benSmoke.append(blankCellData)
        case 1:
            
            costSmoke.append(blankCellData)
        case 2:
            
            benNotSmoke.append(blankCellData)
        case 3:
            
            costNotSmoke.append(blankCellData)
        case 4:
            print("This should be deleted")
        default:
            break
            
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let pointInTable = textField.convertPoint(textField.bounds.origin, toView: self.tableView)
        let textFieldIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        let section = textFieldIndexPath?.section
        let row = textFieldIndexPath?.row
        
        switch textField.tag {
        case 0:
            print("") // Cause I have to have something in here
            tempDescription = textField.text!
        case 1:
            textField.text = String(passInt)
            tempRating = passInt
        default:
            break
        }
        
        
        print("text flied dismissed")
        updateArrays(section!, row: row!)
        getRatingTotals()
        simpleUpdateTableView()
        printArrays()   
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
    
    func updateArrays(section: Int, row: Int){
        let tempPair = DescriptionAndRating(description: tempDescription, rating: tempRating, sectionInt: section)
        
        switch section {
            
        case 0:
            if benSmoke.indices.contains(row){
                benSmoke[row] = tempPair
            }
            else{
                benSmoke.append(tempPair)
            }
        case 1:
            if costSmoke.indices.contains(row){
                costSmoke[row] = tempPair
            }
            else{
                costSmoke.append(tempPair)
            }
        case 2:
            if benNotSmoke.indices.contains(row){
                benNotSmoke[row] = tempPair
            }
            else{
                benNotSmoke.append(tempPair)
            }
        case 3:
            if costNotSmoke.indices.contains(row){
                costNotSmoke[row] = tempPair
            }
            else{
                costNotSmoke.append(tempPair)
            }
        case 4:
            print("")
        default:
            break
            
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let labelNumber = indexPath.row + 1
        let tempData = ["",""]
        let section = indexPath.section
        
        switch section {
            
        case 0...3:
            let cell = tableView.dequeueReusableCellWithIdentifier("costBenefitCell", forIndexPath: indexPath) as! CostBenefitCell
            cell.message.delegate = self
            cell.ratingTextField.delegate = self
            
            //I might regret this
            cell.message.tag = 0
            cell.ratingTextField.tag = 1
            
            
            cell.ratingTextField.inputView = picker
            cell.numberLabel.text = String(labelNumber)
            
            if pastSheetFlag {
                switch indexPath.section{
                    
                case 0:
                    if !benSmoke.isEmpty {
                        let tempDescription =  benSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 1:
                    if !costSmoke.isEmpty {
                        let tempDescription =  costSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 2:
                    if !benNotSmoke.isEmpty {
                        let tempDescription =  benNotSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 3:
                    if !costNotSmoke.isEmpty {
                        let tempDescription =  costNotSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 4:
                    print("la la ")
                default:
                    print("Alram?")
                    
                    //let temp =
                    
                }
            } else{
                switch indexPath.section{
                case 0:
                    if !benSmoke.isEmpty && benSmoke[indexPath.row].descriptionString != "" {
                        
                        let tempDescription =  benSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                        
                    }
                case 1:
                    if !costSmoke.isEmpty && costSmoke[indexPath.row].descriptionString != ""{
                        let tempDescription =  costSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 2:
                    if !benNotSmoke.isEmpty && benNotSmoke[indexPath.row].descriptionString != ""{
                        let tempDescription =  benNotSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 3:
                    if !costNotSmoke.isEmpty && costNotSmoke[indexPath.row].descriptionString != ""{
                        let tempDescription =  costNotSmoke[indexPath.row]
                        cell.message.text = tempDescription.descriptionString
                        cell.ratingTextField.text = String(tempDescription.rating)
                    }
                case 4:
                    print("la la ")
                default:
                    print("Alram?")

                
                
                
                
                
                }
                
//                cell.message.placeholder = tempData[0]
//                cell.ratingTextField.placeholder = tempData[1]
            }
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("totalsCell", forIndexPath: indexPath) as! TotalsCell
            cell.totalDescriptionLabel.text = totalLabels[indexPath.row]
            
            switch indexPath.row {
                
            case 0:
                cell.totalRatingLabel.text = String(currentSmokeTotal)
            case 1:
                cell.totalRatingLabel.text = String(currentNotSmokeTotal)
            default:
                cell.totalRatingLabel.text = "!!"
            }
            return cell
            
        default:
            let cell = UITableViewCell()
            cell.textLabel!.text = "Its all going to hell"
            return cell
        }
        //        }else{
        //            let cell = tableView.dequeueReusableCellWithIdentifier("totalsCell", forIndexPath: indexPath) as! TotalsCell
        //
        //        }
        
        
        
        //        switch indexPath.section {
        //        case 0:
        //            cell.message.placeholder = tempData[0]
        //            cell.ratingTextField.placeholder = tempData[1]
        //        case 1:
        //            cell.message.placeholder = tempData[0]
        //            cell.ratingTextField.placeholder = tempData[1]
        //        case 2:
        //            cell.message.placeholder = tempData[0]
        //            cell.ratingTextField.placeholder = tempData[1]
        //        case 3:
        //            cell.message.placeholder = tempData[0]
        //            cell.ratingTextField.placeholder = tempData[1]
        //        case 4:
        //            cell.message.placeholder = tempData[0]
        //            cell.ratingTextField.placeholder = tempData[1]
        //        default:
        //            print("whyyyyyyy")
        //            break
        //
        //
        //
        //        }
        //        cell.numberLabel.text = String(labelNumber)
        //        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
