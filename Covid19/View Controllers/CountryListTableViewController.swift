//
//  CountryListTableViewController.swift
//  Covid19
//
//  Created by Saud Almutlaq on 09/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit

class CountryListTableViewController: UITableViewController {

    var organizedData = [[StatisticsByCountryElement](),[StatisticsByCountryElement]()]
    
    let sectionsHeader = ["دول الخليج", "دول العالم"]
    
    override func viewWillAppear(_ animated: Bool) {

        var gccArray = [StatisticsByCountryElement]()
        var worldArray = [StatisticsByCountryElement]()
        for ctr in countriesTodayStatistics {
            if ctr.countryInfo?.iso3 == "SAU" || ctr.countryInfo?.iso3 == "KWT" || ctr.countryInfo?.iso3 == "BHR" || ctr.countryInfo?.iso3 == "QAT" || ctr.countryInfo?.iso3 == "OMN" || ctr.countryInfo?.iso3 == "ARE" {
                
                gccArray.append(ctr)
                
            } else {
                
                worldArray.append(ctr)
                
            }
        }
        
        organizedData[0].append(contentsOf: gccArray)
        organizedData[1].append(contentsOf: worldArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
        }
//        print(organizedData[1].count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return organizedData.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.text = sectionsHeader[section]
        myLabel.textAlignment = .center
        myLabel.backgroundColor = UIColor.systemGray3
        return myLabel
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return organizedData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        if organizedData[indexPath.section][indexPath.row].countryInfo?.iso2 != nil {
            let (englishName, arabicName) = getArabicCountriesName(from: organizedData[indexPath.section][indexPath.row].countryInfo?.iso2 ?? "")
            
            if englishName == "" {
                cell.textLabel?.text = organizedData[indexPath.section][indexPath.row].country
            }
            cell.textLabel?.text = englishName
            cell.detailTextLabel?.text = arabicName
        } else {
            cell.textLabel?.text = organizedData[indexPath.section][indexPath.row].country
            cell.detailTextLabel?.text = ""
        }
        
//        let (englishName, arabicName) = getArabicCountriesName(from: organizedData[indexPath.section][indexPath.row].countryInfo?.iso2 ?? "")
//
//        if englishName == "" {
//            cell.textLabel?.text = organizedData[indexPath.section][indexPath.row].country
//        }
//        cell.textLabel?.text = englishName
//        cell.detailTextLabel?.text = arabicName
        
        return cell
    }
    
    var countryData: StatisticsByCountryElement! = nil

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("prepare first")
        
        let indexPath = tableView.indexPathForSelectedRow!
//        countryData = countriesTodayStatistics[indexPath.row]
        countryData = organizedData[indexPath.section][indexPath.row]
        
        if (segue.identifier == "showDetails") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! CountryDetailsViewController
            // your new view controller should have property that will store passed value
            viewController.countryData = self.countryData
        }
    }
}
