//
//  ViewController.swift
//  Covid19
//
//  Created by Saud Almutlaq on 11/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import iProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var newConfirmed: UILabel!
    @IBOutlet weak var totalConfirmed: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalCritical: UILabel!
    @IBOutlet weak var totalActive: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var totalTests: UILabel!
    @IBOutlet weak var totalPopulation: UILabel!
    @IBOutlet weak var totalInfectedCountries: UILabel!
    
    @IBAction func refreshView(_ sender: Any) {
        showProgressAndGetGlobalInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numLang = UserDefaults.standard.string(forKey: "numberLang") ?? "AR"
        dateType = UserDefaults.standard.string(forKey: "dateType") ?? "ar_SA"
        if (self.totalConfirmed.text == "0") {
        showProgressAndGetGlobalInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadCountriesTodayStatistics()
    }
    
    func showProgressAndGetGlobalInfo() {
        showProgress(self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.getGlobalInfo()
        }
    }
    
    func getGlobalInfo() {
        let url = URL(string: "https://corona.lmao.ninja/v2/all?today=")!
        let task = URLSession.shared.globalStatisticsTask(with: url) { global, response, error in
            if let global = global {
                
                let lastUpdateDate = global["updated"]
                
                let cases = formatNumber(number: Int(global["cases"] ?? 0),lang: numLang)
                let todayCases = formatNumber(number: Int(global["todayCases"] ?? 0),lang: numLang)
                let deaths = formatNumber(number: Int(global["deaths"] ?? 0),lang: numLang)
                let todayDeaths = formatNumber(number: Int(global["todayDeaths"] ?? 0),lang: numLang)
                let recovered = formatNumber(number: Int(global["recovered"] ?? 0),lang: numLang)
                let todayRecovered = formatNumber(number: Int(global["todayRecovered"] ?? 0),lang: numLang)
                let active = formatNumber(number: Int(global["active"] ?? 0),lang: numLang)
                let critical = formatNumber(number: Int(global["critical"] ?? 0),lang: numLang)

                let tests = formatNumber(number: Int(global["tests"] ?? 0),lang: numLang)

                let population = formatNumber(number: Int(global["population"] ?? 0),lang: numLang)
                
                let affectedCountries = formatNumber(number: Int(global["affectedCountries"] ?? 0),lang: numLang)
                
                DispatchQueue.main.async {
                    self.totalConfirmed.text = cases
                    self.newConfirmed.text = "+\(todayCases)"
                    self.totalDeaths.text = deaths
                    self.newDeaths.text = "+\(todayDeaths)"
                    self.totalRecovered.text = recovered
                    self.newRecovered.text = "+\(todayRecovered)"
                    self.totalActive.text = active
                    self.totalCritical.text = "الحرجة: \(critical)"
                    self.totalTests.text = tests
                    self.totalPopulation.text = population
                    self.totalInfectedCountries.text = affectedCountries
                    
                    self.lastUpdate.text = "آخر تحديث: \(getFormatedDateTime(byTimestamp: (lastUpdateDate! / 1000.0),type: dateType))"
                    hideProgress(self.view)
                }
            }
        }
        task.resume()
    }
}

