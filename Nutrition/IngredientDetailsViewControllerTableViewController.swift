//
//  IngredientDetailsViewControllerTableViewController.swift
//  Nutrition
//
//  Created by Cass Tao on 2/2/19.
//  Copyright © 2019 Cass Tao. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = String()
}

class IngredientDetailsViewControllerTableViewController: UITableViewController {
    var myDic : [String: String] = [:]
    var name_string = ""
   // var myArray = [String]()
    //var myArray2 = [String]()
    var tableViewData = [cellData]()
    //MARK: Properties
    
    

    @IBAction func CancelButton(_ sender: Any) {

        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        for item in myDic{
            tableViewData.append(cellData(opened: false, title: item.key, sectionData: item.value))
            //myArray.append(item.key)
           // myArray2.append(item.value)
        }
        
        print(tableViewData)
        
    
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if tableViewData[section].opened == true {
            return 2
        } else {
            return 1
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.textLabel?.font = UIFont(name: "Verdana", size: 14)
            
            cell.textLabel?.sizeToFit()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell") else {return UITableViewCell()}
            cell.textLabel?.font = UIFont(name: "Verdana", size: 12)
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData
            
            cell.textLabel?.sizeToFit()
            return cell
            
        }
        
//        let cellIdentifier = "IngredientTableViewCell"
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell else {
//            fatalError("The deqeued cell is not an instance of IngredientTableViewCell.")
//        }
//        let ingredient = myArray[indexPath.row]
//
//       // print(ingredient)
//        cell.nameLabel?.text = ingredient
//
//
//        // Configure the cell...
//
    }
    func tableView(_ tableView:UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
          
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
