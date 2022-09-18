//
//  StockViewController.swift
//  MoneyManagement
//
//  Created by 代田　武 on 2022/08/25.
//

import UIKit

class StockViewController: UIViewController {

    
    @IBOutlet weak var champagneStockLabel: UILabel!
    @IBOutlet weak var tequilaStockLabel: UILabel!
    @IBOutlet weak var startTequilaSalesCount: UILabel!
    @IBOutlet weak var mid1TequilaSalesCount: UILabel!
    @IBOutlet weak var mid2TequilaSalesCount: UILabel!
    @IBOutlet weak var endTequilaSalesCount: UILabel!
    @IBOutlet weak var sumTequilaSalesCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stockCheck()
        salesCheck()
        
        PrepareViewController.setDefaultPrepare()
        DrinkViewController.setDefaultDrink()
        EntranceViewController.setDefaultEntrance()
    }
    
    private func stockCheck(){
        champagneStockLabel.text = (PrepareViewController.userDefaultsPrepare.object(forKey: "champagneStock") as! Int).description
        tequilaStockLabel.text = (PrepareViewController.userDefaultsPrepare.object(forKey: "tequilaStock") as! Int).description
    }
    
    @IBAction func plusChampgneStock(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(PrepareViewController.userDefaultsPrepare.object(forKey: "champagneStock") as! Int + 1, forKey: "champagneStock")
        stockCheck()
    }
    @IBAction func minusChampagneStock(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(PrepareViewController.userDefaultsPrepare.object(forKey: "champagneStock") as! Int - 1, forKey: "champagneStock")
        stockCheck()
    }
    
    @IBAction func plusTequilaStock(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(PrepareViewController.userDefaultsPrepare.object(forKey: "tequilaStock") as! Int + 1, forKey: "tequilaStock")
        stockCheck()
    }
    @IBAction func minusTequilaStock(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(PrepareViewController.userDefaultsPrepare.object(forKey: "tequilaStock") as! Int - 1, forKey: "tequilaStock")
        stockCheck()
    }
    
    private func salesCheck(){
        startTequilaSalesCount.text = (((DrinkViewController.userDefaultsDrink.object(forKey: "startTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) / 500).description
        mid1TequilaSalesCount.text = (((DrinkViewController.userDefaultsDrink.object(forKey: "mid1Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) / 500).description
        mid2TequilaSalesCount.text = (((DrinkViewController.userDefaultsDrink.object(forKey: "mid2Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) / 500).description
        endTequilaSalesCount.text = (((DrinkViewController.userDefaultsDrink.object(forKey: "endTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) / 500).description
        sumTequilaSalesCount.text = (((            (DrinkViewController.userDefaultsDrink.object(forKey: "startTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid1Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid2Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "endTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int))) / 500).description
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
