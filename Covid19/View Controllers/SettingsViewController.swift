//
//  SettingsViewController.swift
//  Covid19
//
//  Created by Saud Almutlaq on 10/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var dateSettings: UISegmentedControl!
    @IBOutlet weak var dateLang: UISegmentedControl!
    @IBOutlet weak var numberSettings: UISegmentedControl!
    
    @IBAction func dateSettingsChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        if sender.selectedSegmentIndex == 0 {
            changeDate(greg: true)
        } else {
            changeDate(greg: false)
        }
        if dateSettings.selectedSegmentIndex == 0 && dateLang.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("en_US", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 0 && dateLang.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("ar_US", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 1 && dateLang.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("en_SA", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 1 && dateLang.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("ar_SA", forKey: "dateType")
        }
    }
    
    @IBAction func dateLangChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        if dateSettings.selectedSegmentIndex == 0 && dateLang.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("en_US", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 0 && dateLang.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("ar_US", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 1 && dateLang.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("en_SA", forKey: "dateType")
        }
        if dateSettings.selectedSegmentIndex == 1 && dateLang.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("ar_SA", forKey: "dateType")
        }
    }
    
    @IBAction func numberSettingsChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("EN", forKey: "numberLang")
        } else {
            UserDefaults.standard.set("AR", forKey: "numberLang")
        }
    }
    
    func changeDate(greg:Bool) {
        if greg {
            dateLang.setTitle("Wednesday, 10 Jun 2020", forSegmentAt: 0)
            dateLang.setTitle("الأربعاء, ١٠ يونيو ٢٠٢٠", forSegmentAt: 1)
        } else {
            dateLang.setTitle("Wednesday, 18 Shaw. 1441", forSegmentAt: 0)
            dateLang.setTitle("الأربعاء, ١٨ شوال ١٤٤١", forSegmentAt: 1)
        }
    }
    
    /**
     الأربعاء, ١٨ شوال ١٤٤١
    الأربعاء, ١٠ يونيو ٢٠٢٠
      Wednesday, 18 Shaw. 1441
      Wednesday, 10 Jun 2020
     */
    override func viewWillAppear(_ animated: Bool) {
        let currenNumLang = UserDefaults.standard.string(forKey: "numberLang")
        
        if currenNumLang == "AR" || currenNumLang == nil {
            numberSettings.selectedSegmentIndex = 1
        } else {
            numberSettings.selectedSegmentIndex = 0
        }
        
        let dateLanguage = UserDefaults.standard.string(forKey: "dateType") ?? "ar_SA"
        
        if dateLanguage == "en_US" {
            dateSettings.selectedSegmentIndex = 0
            dateLang.selectedSegmentIndex = 0
        }
        if dateLanguage == "ar_US" {
            dateSettings.selectedSegmentIndex = 0
            dateLang.selectedSegmentIndex = 1
        }
        if dateLanguage == "en_SA" {
            dateSettings.selectedSegmentIndex = 1
            dateLang.selectedSegmentIndex = 0
        }
        if dateLanguage == "ar_SA" {
            dateSettings.selectedSegmentIndex = 1
            dateLang.selectedSegmentIndex = 1
        }
        
        if dateSettings.selectedSegmentIndex == 0 {
            changeDate(greg: true)
        } else {
            changeDate(greg: false)
        }
        
        print(numberSettings.selectedSegmentIndex)
        print(dateSettings.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
