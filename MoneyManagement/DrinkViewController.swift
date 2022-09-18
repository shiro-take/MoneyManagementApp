//
//  DrinkViewController.swift
//  MoneyManagement
//
//  Created by 代田　武 on 2022/08/09.
//

import UIKit

/*酒管理を行うためのクラス*/
class DrinkViewController: UIViewController {
    // メニュー表示項目
    enum TimeMenu: String{
        case start = "17:00~18:00"
        case mid1 = "18:00~19:00"
        case mid2 = "19:00~20:00"
        case end = "20:00~21:00"
    }

    @IBOutlet weak var timeMenuButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var salesChampagneTextField: UITextField!
    @IBOutlet weak var salesTequilaTextField: UITextField!
    @IBOutlet weak var startChampagneSalesLabel: UILabel!
    @IBOutlet weak var mid1ChampagneSalesLabel: UILabel!
    @IBOutlet weak var mid2ChampagneSalesLabel: UILabel!
    @IBOutlet weak var endChampagneSalesLabel: UILabel!
    @IBOutlet weak var startTequilaSalesLabel: UILabel!
    @IBOutlet weak var mid1TequilaSalesLabel: UILabel!
    @IBOutlet weak var mid2TequilaSalesLabel: UILabel!
    @IBOutlet weak var endTequilaSalesLabel: UILabel!
    @IBOutlet weak var sumChampagneLabel: UILabel!
    @IBOutlet weak var sumTequilaLabel: UILabel!
    /*フィールド変数*/
    let prepareViewController = PrepareViewController() // インスタンス化
    var selectTimeMenu = TimeMenu.start

    public static let userDefaultsDrink = UserDefaults.standard // 酒管理の情報保持
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        salesChampagneTextField.keyboardType = UIKeyboardType.numberPad
        salesTequilaTextField.keyboardType = UIKeyboardType.numberPad// 数値のみ入力可
        salesChampagneTextField.tintColor = UIColor.black
        salesTequilaTextField.tintColor = UIColor.black// カーソルの色をblackに
        salesChampagneTextField.placeholder = "シャンパンの売上を入力してください"
        salesTequilaTextField.placeholder = "テキーラの売上を入力してください"
        
        configureTimeMenuButton() // メニューボタンを設定するメソッド呼び出し
    
        
        DrinkViewController.setDefaultDrink()
        

        salesCheck()
        okButton.isEnabled = false
    }
    
    public static func setDefaultDrink(){
        DrinkViewController.userDefaultsDrink.register(defaults: ["startChampagne" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["mid1Champagne" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["mid2Champagne" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["endChampagne" : 0])
        
        DrinkViewController.userDefaultsDrink.register(defaults: ["startTequila" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["mid1Tequila" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["mid2Tequila" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["endTequila" : 0])
        
        DrinkViewController.userDefaultsDrink.register(defaults: ["sumChampagne" : 0])
        DrinkViewController.userDefaultsDrink.register(defaults: ["sumTequila" : 0])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.salesChampagneTextField.endEditing(true)
        self.salesTequilaTextField.endEditing(true)
    }
    
    // メニューボタンを設定するメソッド
    private func configureTimeMenuButton() {
        var actions = [UIMenuElement]()
        // 17:00~18:00
        actions.append(UIAction(title: TimeMenu.start.rawValue, image: nil, state: self.selectTimeMenu == TimeMenu.start ? .on : .off, handler: { (_) in
            self.selectTimeMenu = .start
            self.configureTimeMenuButton()
        }))
        // 18:00~19:00
        actions.append(UIAction(title: TimeMenu.mid1.rawValue, image: nil, state: self.selectTimeMenu == TimeMenu.mid1 ? .on : .off, handler: { (_) in
            self.selectTimeMenu = .mid1
            self.configureTimeMenuButton()
        }))
        // 19:00~20:00
        actions.append(UIAction(title: TimeMenu.mid2.rawValue, image: nil, state: self.selectTimeMenu == TimeMenu.mid2 ? .on : .off, handler: { (_) in
            self.selectTimeMenu = .mid2
            self.configureTimeMenuButton()
        }))
        // 20:00~21:00
        actions.append(UIAction(title: TimeMenu.end.rawValue, image: nil, state: self.selectTimeMenu == TimeMenu.end ? .on : .off, handler: { (_) in
            self.selectTimeMenu = .end
            self.configureTimeMenuButton()
        }))
        // UIButtonにUIMenuを設定
        timeMenuButton.menu = UIMenu(title: "", options: .displayInline, children: actions)
        timeMenuButton.showsMenuAsPrimaryAction = true
        timeMenuButton.setTitle(self.selectTimeMenu.rawValue, for: .normal)
        
    }
    
    // 適用ボタンを押せるようにするメソッド
    @IBAction func buttonEnable1(_ sender: Any) {
        if(salesTequilaTextField.text == "" || salesChampagneTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    
    @IBAction func buttonEnable2(_ sender: Any) {
        if(salesTequilaTextField.text == "" || salesChampagneTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    
    
    // 時間帯ごとにそれぞれの売り上げを適用するためのメソッド
    @IBAction func drinkConfirmButton(_ sender: Any) {
        
        if(self.selectTimeMenu == .start) { // 17:00~18:00
            DrinkViewController.userDefaultsDrink.set(Int(salesChampagneTextField.text ?? "0"), forKey: "startChampagne")
                        DrinkViewController.userDefaultsDrink.set(Int(salesTequilaTextField.text ?? "0"), forKey: "startTequila")
            salesCheck()
        } else if(self.selectTimeMenu == .mid1) { // 18:00~19:00
                        DrinkViewController.userDefaultsDrink.set(Int(salesChampagneTextField.text ?? "0"), forKey: "mid1Champagne")
                        DrinkViewController.userDefaultsDrink.set(Int(salesTequilaTextField.text ?? "0"), forKey: "mid1Tequila")
            salesCheck()
        } else if(self.selectTimeMenu == .mid2) { // 19:00~20:00
                        DrinkViewController.userDefaultsDrink.set(Int(salesChampagneTextField.text ?? "0"), forKey: "mid2Champagne")
                        DrinkViewController.userDefaultsDrink.set(Int(salesTequilaTextField.text ?? "0"), forKey: "mid2Tequila")
            salesCheck()
        } else if(self.selectTimeMenu == .end) { // 20:00~21:00
                        DrinkViewController.userDefaultsDrink.set(Int(salesChampagneTextField.text ?? "0"), forKey: "endChampagne")
                        DrinkViewController.userDefaultsDrink.set(Int(salesTequilaTextField.text ?? "0"), forKey: "endTequila")
            salesCheck()
        }
        self.salesChampagneTextField.endEditing(true)
        self.salesTequilaTextField.endEditing(true)
    }
    
    // 売り上げを表示するメソッド
    private func salesCheck(){
        
        // シャンパンの部分
        startChampagneSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "startChampagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)).description
        mid1ChampagneSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid1Champagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)).description
        mid2ChampagneSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid2Champagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)).description
        endChampagneSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "endChampagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)).description
        
        // テキーラの部分
        startTequilaSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "startTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)).description
        mid1TequilaSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid1Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)).description
        mid2TequilaSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid2Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)).description
        endTequilaSalesLabel.text = "¥" + ((            DrinkViewController.userDefaultsDrink.object(forKey: "endTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)).description
        
        // 合計の部分
        sumChampagneLabel.text = "¥" + (((            DrinkViewController.userDefaultsDrink.object(forKey: "startChampagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid1Champagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid2Champagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "endChampagne") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeChampagne") as! Int))).description
        
        sumTequilaLabel.text = "¥" + (((            DrinkViewController.userDefaultsDrink.object(forKey: "startTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid1Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "mid2Tequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int)) + ((            DrinkViewController.userDefaultsDrink.object(forKey: "endTequila") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeTequila") as! Int))).description
    }

    
    @IBAction func resetButton(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "startChampagne")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid1Champagne")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid2Champagne")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "endChampagne")
        
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "startTequila")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid1Tequila")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid2Tequila")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "endTequila")
        
        salesCheck()
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
