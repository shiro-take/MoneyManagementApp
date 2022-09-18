//
//  EntranceViewController.swift
//  MoneyManagement
//
//  Created by 代田　武 on 2022/08/18.
//

import UIKit

// エントランス管理クラス
class EntranceViewController: UIViewController {
    // メニュー表示項目
    enum TimeMenu: String{
        case start = "17:00~18:00"
        case mid1 = "18:00~19:00"
        case mid2 = "19:00~20:00"
        case end = "20:00~21:00"
    }
    
    @IBOutlet weak var timeMenuButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var entranceTextField: UITextField!
    @IBOutlet weak var startEntranceLabel: UILabel!
    @IBOutlet weak var mid1EntranceLabel: UILabel!
    @IBOutlet weak var mid2EntranceLabel: UILabel!
    @IBOutlet weak var endEntranceLabel: UILabel!
    @IBOutlet weak var sumEntranceLabel: UILabel!
    
    var selectTimeMenu = TimeMenu.start // メニューボタンのメニュー
    public static let userDefaultsEntrance = UserDefaults.standard // エントランスの情報保持
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        entranceTextField.keyboardType = UIKeyboardType.numberPad// 数値のみ入力可
        entranceTextField.tintColor = UIColor.black// カーソルの色をblackに
        entranceTextField.placeholder = "エントランスの売り上げを入力してください"
        configureTimeMenuButton()
        
       
        EntranceViewController.setDefaultEntrance()
        
        salesCheck()
        
        okButton.isEnabled = false
    }
    
    public static func setDefaultEntrance(){
        EntranceViewController.userDefaultsEntrance.register(defaults: ["startEntrance" : 0])
        EntranceViewController.userDefaultsEntrance.register(defaults: ["mid1Entrance" : 0])
        EntranceViewController.userDefaultsEntrance.register(defaults: ["mid2Entrance" : 0])
        EntranceViewController.userDefaultsEntrance.register(defaults: ["endEntrance" : 0])
        
        EntranceViewController.userDefaultsEntrance.register(defaults: ["sumEntrance" : 0])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.entranceTextField.endEditing(true)
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
    @IBAction func entranceConfirmButton(_ sender: Any) {
        if(self.selectTimeMenu == .start) { // 17:00~18:00
            EntranceViewController.userDefaultsEntrance.set(Int(entranceTextField.text ?? "0"), forKey: "startEntrance")
            salesCheck()
        } else if(self.selectTimeMenu == .mid1) { // 18:00~19:00
            EntranceViewController.userDefaultsEntrance.set(Int(entranceTextField.text ?? "0"), forKey: "mid1Entrance")
            salesCheck()
        } else if(self.selectTimeMenu == .mid2) { // 19:00~20:00
            EntranceViewController.userDefaultsEntrance.set(Int(entranceTextField.text ?? "0"), forKey: "mid2Entrance")
            salesCheck()
        } else if(self.selectTimeMenu == .end) { // 20:00~21:00
            EntranceViewController.userDefaultsEntrance.set(Int(entranceTextField.text ?? "0"), forKey: "endEntrance")
            salesCheck()
        }
        self.entranceTextField.endEditing(true)
    }
    
    // 売り上げを表示するメソッド
    private func salesCheck(){
        startEntranceLabel.text = "¥" + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "startEntrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)).description
        mid1EntranceLabel.text = "¥" + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "mid1Entrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)).description
        mid2EntranceLabel.text = "¥" + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "mid2Entrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)).description
        endEntranceLabel.text = "¥" + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "endEntrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)).description
        
        sumEntranceLabel.text = "¥" + (((            EntranceViewController.userDefaultsEntrance.object(forKey: "startEntrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)) + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "mid1Entrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)) + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "mid2Entrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int)) + ((            EntranceViewController.userDefaultsEntrance.object(forKey: "endEntrance") as! Int) - (PrepareViewController.userDefaultsPrepare.object(forKey: "changeEntrance") as! Int))).description
    }
    
    @IBAction func resetButton(_ sender: Any) {
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "startEntrance")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid1Entrance")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "mid2Entrance")
        PrepareViewController.userDefaultsPrepare.removeObject(forKey: "endEntrance")
        
        salesCheck()
    }
    @IBAction func buttonEnable(_ sender: Any) {
        if(entranceTextField.text  == ""){
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
