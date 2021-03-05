//
//  ViewController.swift
//  CountDownTimer
//
//  Created by user on 2021/02/08.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // タイマーの変数を作成
    var timer : Timer?
    var actualTime = 25
    var intervalTime = 0

    
    // 分カウントを生成
    var minCount = 00
    // 秒カウントを生成
    var secCount = 00
    // ボタン表示を切り替える変数を生成
    var changeButtonName = "Start"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // minPickerViewのデリゲートになる
        minPickerView.delegate = self
        // minPickerViewのデリゲートになる
        minPickerView.dataSource = self
        
        minCountLabel.text = String(format: "%02d", actualTime)
    }
        
    // プロパティ宣言
    @IBAction func settingButtonAction(_ sender: Any) {
    }
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var minPickerView: UIPickerView!
    let compo = ["作業２５分　休憩５分","作業６０分　休憩１０分","作業９０分　休憩１５分"]
    let actual = [25,60,90]
    let interval  = [5,10,15]
    // pickerViewのコンポーネントの個数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // pickerViewのコンポーネントの行数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let row = compo.count
        return row
    }
    // 指定のコンポーネント、行の項目を返す
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 指定のコンポーネントから指定行の項目名を取り出す
        let item = compo[row]
        return item
    }
    // ドラムが回転して項目が選ばれた
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 選ばれた項目
        let item = compo[row]
        print("\(item)が選ばれた")
        // 現在選択されている行番号
        let row = pickerView.selectedRow(inComponent: 0)
        print("現在選択されている行番号\(row)")
        actualTime = actual[row]
        intervalTime = interval[row]
        minCountLabel.text = String(format: "%02d", actualTime)
    }
    @IBOutlet weak var minCountLabel: UILabel!
    @IBOutlet weak var colonLabel: UILabel!
    @IBOutlet weak var secCountLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBAction func startStopButtonAction(_ sender: Any) {
        // スタートボタンを押すとストップボタンに変わるようにする
        if changeButtonName == "Start" {
            if let nowTimer = timer {
                if nowTimer.isValid == true {
                    return
                }
            }
            minPickerView.isHidden = true
            selectLabel.isHidden = true
            countDown(actual: actualTime, interval: intervalTime)
            startStopButton.setTitle("Stop", for: .normal)
            changeButtonName = "Stop"
        } else if changeButtonName == "Stop" {
            if let nowTimer = timer {
                if nowTimer.isValid == true {
                    nowTimer.invalidate()
                }
            }
            startStopButton.setTitle("Start", for: .normal)
            changeButtonName = "Start"
        }
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        minPickerView.isHidden = false
        selectLabel.isHidden = false
        minCount = actualTime
        secCount = 00
        minCountLabel.text = String(format: "%02d", minCount)
        secCountLabel.text = String(format: "%02d", secCount)
    }
    
    func countDown(actual: Int, interval: Int){
        minCount = actual
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            if secCount > 0 {
                secCount -= 1
            } else if minCount > 0 {
                minCount -= 1
                secCount = 59
            } else {
                timer?.invalidate()
                let soundAlarm : SystemSoundID = 1332
                AudioServicesPlaySystemSoundWithCompletion(soundAlarm, nil)
                minCount = interval
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
                    if secCount > 0 {
                        secCount -= 1
                    } else if minCount > 0 {
                        minCount -= 1
                        secCount = 59
                    } else {
                        timer?.invalidate()
                    }
                    minCountLabel.text = String(format: "%02d", minCount)
                    secCountLabel.text = String(format: "%02d", secCount)
                }

            }
            minCountLabel.text = String(format: "%02d", minCount)
            secCountLabel.text = String(format: "%02d", secCount)
        }
    }
    
}

