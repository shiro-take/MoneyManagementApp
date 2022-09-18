//
//  PrepareViewController.swift
//  MoneyManagement
//
//  Created by 代田　武 on 2022/08/05.
//

import UIKit

class PrepareViewController: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var champagneTextField: UITextField!
    @IBOutlet weak var tequilaTextField: UITextField!
    @IBOutlet weak var changeChampagneTextField: UITextField!
    @IBOutlet weak var changeTequilaTextField: UITextField!
    @IBOutlet weak var changeEntranceTextField: UITextField!
    
    /*フィールド変数*/
    var champagneStockCount: Int? // シャンパン在庫数
    var tequilaStockCount: Int? // テキーラ在庫数
    
    
    public static let userDefaultsPrepare = UserDefaults.standard // 事前設定のデータ保存
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        champagneTextField.keyboardType = UIKeyboardType.numberPad
        tequilaTextField.keyboardType = UIKeyboardType.numberPad
        changeChampagneTextField.keyboardType = UIKeyboardType.numberPad
        changeTequilaTextField.keyboardType = UIKeyboardType.numberPad
        changeEntranceTextField.keyboardType = UIKeyboardType.numberPad // 数値のみ入力可
        champagneTextField.tintColor = UIColor.black
        tequilaTextField.tintColor = UIColor.black
        changeChampagneTextField.tintColor = UIColor.black
        changeTequilaTextField.tintColor = UIColor.black
        changeEntranceTextField.tintColor = UIColor.black // カーソルの色をblackに
        champagneTextField.placeholder = "シャンパンの在庫数を入力してください"
        tequilaTextField.placeholder = "テキーラの在庫数を入力してください"
        changeChampagneTextField.placeholder = "シャンパンのお釣り額を入力してください"
        changeTequilaTextField.placeholder = "テキーラのお釣り額を入力してください"
        changeEntranceTextField.placeholder = "エントランスのお釣り額を入力してください"
        
        PrepareViewController.setDefaultPrepare()
        
        okButton.isEnabled = false
    }
    
    public static func setDefaultPrepare(){
        PrepareViewController.userDefaultsPrepare.register(defaults: ["changeChampagne" : 0])
        PrepareViewController.userDefaultsPrepare.register(defaults: ["changeTequila" : 0])
        PrepareViewController.userDefaultsPrepare.register(defaults: ["changeEntrance" : 0])
        PrepareViewController.userDefaultsPrepare.register(defaults: ["champagneStock" : 0])
        PrepareViewController.userDefaultsPrepare.register(defaults: ["tequilaStock" : 0])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.champagneTextField.endEditing(true)
        self.tequilaTextField.endEditing(true)
        self.changeChampagneTextField.endEditing(true)
        self.changeTequilaTextField.endEditing(true)
        self.changeEntranceTextField.endEditing(true)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(Int(champagneTextField.text!), forKey: "champagneStock")
        PrepareViewController.userDefaultsPrepare.set(Int(tequilaTextField.text!), forKey: "tequilaStock")
        PrepareViewController.userDefaultsPrepare.set(Int(changeChampagneTextField.text!), forKey: "changeChampagne")
        PrepareViewController.userDefaultsPrepare.set(Int(changeTequilaTextField.text!), forKey: "changeTequila")
        PrepareViewController.userDefaultsPrepare.set(Int(changeEntranceTextField.text!), forKey: "changeEntrance")
        champagneTextField.endEditing(true)
        tequilaTextField.endEditing(true)
        changeChampagneTextField.endEditing(true)
        changeTequilaTextField.endEditing(true)
        changeEntranceTextField.endEditing(true)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.set(0, forKey: "champagneStock")
        PrepareViewController.userDefaultsPrepare.set(0, forKey: "tequilaStock")
       
        PrepareViewController.userDefaultsPrepare.set(0, forKey: "changeChampagne")
        PrepareViewController.userDefaultsPrepare.set(0, forKey: "changeTequila")
        PrepareViewController.userDefaultsPrepare.set(0, forKey: "changeEntrance")
    }
    
    @IBAction func buttonEnable1(_ sender: Any) {
        if(champagneTextField.text == "" || tequilaTextField.text == "" || changeChampagneTextField.text == "" || changeTequilaTextField.text == "" || changeEntranceTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    @IBAction func buttonEnable2(_ sender: Any) {
        if(champagneTextField.text == "" || tequilaTextField.text == "" || changeChampagneTextField.text == "" || changeTequilaTextField.text == "" || changeEntranceTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    @IBAction func buttonEnable3(_ sender: Any) {
        if(champagneTextField.text == "" || tequilaTextField.text == "" || changeChampagneTextField.text == "" || changeTequilaTextField.text == "" || changeEntranceTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    @IBAction func buttonEnable4(_ sender: Any) {
        if(champagneTextField.text == "" || tequilaTextField.text == "" || changeChampagneTextField.text == "" || changeTequilaTextField.text == "" || changeEntranceTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
    }
    @IBAction func buttonEnable5(_ sender: Any) {
        if(champagneTextField.text == "" || tequilaTextField.text == "" || changeChampagneTextField.text == "" || changeTequilaTextField.text == "" || changeEntranceTextField.text == ""){
            okButton.isEnabled = false
        }else {
            okButton.isEnabled = true
        }
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
