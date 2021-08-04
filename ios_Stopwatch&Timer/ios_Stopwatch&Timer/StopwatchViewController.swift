//
//  StopwatchViewController.swift
//  ios_Stopwatch&Timer
//
//  Created by J_Min on 2021/08/04.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timer = Timer()
    let interval = 0.01
    let timeSelector: Selector = #selector(StopwatchViewController.updateTime)
    var count = 0
    var a = 0
    var timeLab = [String]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var btnStartLabel: UIButton!
    @IBOutlet var btnTimeLabLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func updateTime() {
        count = count + 1
        
        let mSecond = String(format: "%02d", count % 100)
        let second = String(format: "%02d", (count / 100) % 60)
        let minute = String(format: "%02d", ((count / 100) / 60) % 60)
        let hour = String(format: "%02d", ((count / 100) / 60) / 60)
        
        if hour == "00" {
            timeLabel.text = "\(minute):\(second).\(mSecond)"
        } else {
            timeLabel.text = "\(hour):\(minute):\(second).\(mSecond)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeLab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.timeLabLabel.text = timeLab[(indexPath as NSIndexPath).row]
        
        return cell
    }

    @IBAction func start(_ sender: UIButton) {
        if a == 0 {
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            btnStartLabel.setTitle("중지", for: .normal)
            btnTimeLabLabel.setTitle("랩", for: .normal)
            a = 1
        } else {
            timer.invalidate()
            btnStartLabel.setTitle("시작", for: .normal)
            btnTimeLabLabel.setTitle("재설정", for: .normal)
            a = 0
        }
    }
    
    @IBAction func timeLab(_ sender: Any) {
        if a == 0 {
            count = 0
            timeLabel.text = "00:00.00"
            timeLab.removeAll()
            self.tableView.reloadData()
        } else {
            timeLab.append(timeLabel.text!)
            self.tableView.reloadData()
        }
    }
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabLabel.text = ""
        
    }
    
}
