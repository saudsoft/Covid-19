//
//  CountryDetailsViewController.swift
//  Covid19
//
//  Created by Saud Almutlaq on 09/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import GTProgressBar

class CountryDetailsViewController: UIViewController {
    var countryData: StatisticsByCountryElement! = nil
    
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
    @IBOutlet weak var progressView: GTProgressBar!
    @IBOutlet weak var progressViewDeath: GTProgressBar!

    override func viewWillAppear(_ animated: Bool) {
        numLang = UserDefaults.standard.string(forKey: "numberLang") ?? "AR"
        dateType = UserDefaults.standard.string(forKey: "dateType") ?? "ar_SA"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if countryData.countryInfo?.iso2 == nil {
            self.title = countryData.country
        } else {
            let (_, arName) = getArabicCountriesName(from: countryData.countryInfo?.iso2 ?? "")
            
            self.title = arName
        }
        
        let totalActiveVal = formatNumber(number: countryData.active ?? 0, lang: numLang)
        let currentCriticalVal = formatNumber(number: countryData.critical ?? 0, lang: numLang)
        let todayCassesVal = formatNumber(number: countryData.todayCases ?? 0, lang: numLang)
        let totalConfirmedVal = formatNumber(number: countryData.cases ?? 0, lang: numLang)
        let newDeathsVal = formatNumber(number: countryData.todayDeaths ?? 0, lang: numLang)
        let totalRecoverdVal = formatNumber(number: countryData.recovered ?? 0, lang: numLang)
        let newRecoverdVal = formatNumber(number: countryData.todayRecovered ?? 0, lang: numLang)
        let totalDeathsVal = formatNumber(number: countryData.deaths ?? 0, lang: numLang)
        let totalTestVal = formatNumber(number: countryData.tests ?? 0, lang: numLang)
        let lastUpdateVal = countryData.updated
        
        DispatchQueue.main.async {
            self.lastUpdate.text = "آخر تحديث: \(getFormatedDateTime(byTimestamp: (Double(lastUpdateVal!) / 1000.0),type: dateType))"
            self.totalConfirmed.text = "\(totalConfirmedVal)"
            self.newConfirmed.text = "+\(todayCassesVal)"
            
            self.totalRecovered.text = "\(totalRecoverdVal)"
            self.newRecovered.text = "+\(newRecoverdVal)"
            
            self.totalDeaths.text = "\(totalDeathsVal)"
            self.newDeaths.text = "+\(newDeathsVal)"

            self.totalTests.text = "\(totalTestVal)"
            
            self.totalActive.text = "\(totalActiveVal)"
            self.totalCritical.text = "الحرجة: \(currentCriticalVal)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            self.showProgressBar()
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showProgressBar() {
        let healingPersentage:Float = Float(countryData.recovered ?? 0) / Float(countryData.cases ?? 0)
        
        let deathPersentage:Float = Float(countryData.deaths ?? 0) / Float(countryData.cases ?? 0)
        
        if healingPersentage >= 0.60 {
            self.progressView.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
            self.progressView.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        } else if healingPersentage < 0.60 && healingPersentage >= 0.20 {
            self.progressView.barBorderColor = UIColor(red: 0.85, green: 0.66, blue: 0.26, alpha: 1.00)
            self.progressView.barFillColor = UIColor(red: 0.85, green: 0.66, blue: 0.26, alpha: 1.00)
        } else if healingPersentage < 0.20 {
            self.progressView.barBorderColor = UIColor(red: 0.87, green: 0.25, blue: 0.25, alpha: 1.00)
            self.progressView.barFillColor = UIColor(red: 0.87, green: 0.25, blue: 0.25, alpha: 1.00)
        }
        
        if deathPersentage >= 0.60 {
            self.progressViewDeath.barBorderColor = UIColor(red: 0.87, green: 0.25, blue: 0.25, alpha: 1.00)
            self.progressViewDeath.barFillColor = UIColor(red: 0.87, green: 0.25, blue: 0.25, alpha: 1.00)
        } else if deathPersentage < 0.60 && deathPersentage >= 0.20 {
            self.progressViewDeath.barBorderColor = UIColor(red: 0.85, green: 0.66, blue: 0.26, alpha: 1.00)
            self.progressViewDeath.barFillColor = UIColor(red: 0.85, green: 0.66, blue: 0.26, alpha: 1.00)
        } else  if deathPersentage < 0.20 {
            self.progressViewDeath.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
            self.progressViewDeath.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        }
        
        print("ProgressValue \(healingPersentage)")
        self.progressView.animateTo(progress: CGFloat(healingPersentage))
        self.progressViewDeath.animateTo(progress: CGFloat(deathPersentage))
    }
}
