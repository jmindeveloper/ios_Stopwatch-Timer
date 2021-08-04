import UIKit

class TimerViewController: UIViewController {
    
    var time = 0
    var timer = Timer()
    var count = 0
    let interval = 1
    let timeSelector: Selector = #selector(TimerViewController.updateTime)
    var a = 1
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var btnStartTxt: UIButton!
    @IBOutlet weak var btnHidden: UIButton!
    @IBOutlet weak var btnHidden2: UIButton!
    @IBOutlet weak var btnHidden3: UIButton!
    @IBOutlet weak var btnHidden4: UIButton!
    @IBOutlet weak var btnHidden5: UIButton!
    @IBOutlet weak var btnHidden6: UIButton!
    
    override func viewDidLoad() {
        
    }
    
    func displayTime() {
        let a = time - count
        let hour = String(format: "%02d", a / 3600)
        let minute = String(format: "%02d", (a % 3600) / 60)
        let second =  String(format: "%02d", (a % 3600) % 60)
        timeLabel.text = "\(hour):\(minute):\(second)"
    }
    
    func noMinus() {
        if time < 0 {
            time = 0
        }
    }
    
    @objc func updateTime() {
        count = count + 1
        displayTime()
        
        if time == count {
            let alert = UIAlertController(title: "완료", message: "타이머가 종료됩니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            timer.invalidate()
            count = 0
            time = 0
            a = 1
            btnStartTxt.setTitle("시작", for: .normal)
            displayTime()
            btnHidden.isHidden = false
            btnHidden2.isHidden = false
            btnHidden3.isHidden = false
            btnHidden4.isHidden = false
            btnHidden5.isHidden = false
            btnHidden6.isHidden = false
        }
        
    }
    
    @IBAction func btnStart(_ sender: Any) {
        
        if time != 0 {
            if a == 1 {
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: timeSelector, userInfo: nil, repeats: true)
                btnStartTxt.setTitle("일시정지", for: .normal)
                
                btnHidden.isHidden = true
                btnHidden2.isHidden = true
                btnHidden3.isHidden = true
                btnHidden4.isHidden = true
                btnHidden5.isHidden = true
                btnHidden6.isHidden = true
                
                a = 0
            } else {
                timer.invalidate()
                btnStartTxt.setTitle("시작", for: .normal)
                a = 1
            }
        } else {
            let alert = UIAlertController(title: nil, message: "시간을 설정해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func btnStop(_ sender: Any) {
        
        timer.invalidate()
        count = 0
        time = 0
        a = 1
        btnStartTxt.setTitle("시작", for: .normal)
        displayTime()
        btnHidden.isHidden = false
        btnHidden2.isHidden = false
        btnHidden3.isHidden = false
        btnHidden4.isHidden = false
        btnHidden5.isHidden = false
        btnHidden6.isHidden = false
    }
    @IBAction func btnUpHour(_ sender: Any) {
        time = time + 3600
        displayTime()
    }
    @IBAction func btnDownHour(_ sender: Any) {
        time = time - 3600
        noMinus()
        displayTime()
    }
    @IBAction func btnUpMIn(_ sender: Any) {
        time = time + 60
        displayTime()
    }
    @IBAction func btnDownMin(_ sender: Any) {
        time = time - 60
        noMinus()
        displayTime()
    }
    @IBAction func btnUpSec(_ sender: Any) {
        time = time + 1
        displayTime()
    }
    @IBAction func btnDownSec(_ sender: Any) {
        time = time - 1
        noMinus()
        displayTime()
    }
    
    
}

