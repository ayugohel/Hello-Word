//
//  ViewController.swift
//  Hello World
//
//  Created by Ayushi on 2019-10-29.
//  Copyright © 2019 Ayushi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    
    
    // MARK: - Variables
    
    fileprivate var arrData : [Dictionary<String , Any>] = []
    
    // MARK: - Custom Methods
    
    
    fileprivate func setUP() {
        
        var tempData = Dictionary<String,Any>()
        tempData["is_bold"] = false
        self.arrData = [Dictionary<String,Any>](repeatElement(tempData, count: 100))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUP()
        
    }
    
}

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var lblText: UILabel!
}


// MARK: UITableviewDelegate

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskTableViewCell
        
        cell.lblText.text = "Hello World"
        //        debugPrint("Data:-",self.arrData[indexPath.row])
        
        if let is_bold = self.arrData[indexPath.row]["is_bold"] as? Bool , is_bold {
            cell.lblText.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        } else {
            cell.lblText.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if let cell = tblView.cellForRow(at: indexPath) as? TaskTableViewCell {
            
            DispatchQueue.main.async {
                if let is_bold = self.arrData[indexPath.row]["is_bold"] as? Bool , is_bold {
                    cell.lblText.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
                } else {
                    cell.lblText.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
                }
            }
        }
        
        QueueManager.shared.getIndexQueue( indexPath: indexPath) { (indexPathh, error) in
            
            DispatchQueue.main.async {
                
                if let getCell = tableView.cellForRow(at: indexPathh!) as? TaskTableViewCell{
                    //                    debugPrint(indexPath)
                    
                    if let is_bold = self.arrData[indexPath.row]["is_bold"] as? Bool , is_bold {
                        getCell.lblText.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
                        
                    } else {
                        getCell.lblText.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
                        var tempData = Dictionary<String,Any>()
                        tempData["is_bold"] = true
                        
                        if let indexPaths = tableView.indexPathsForVisibleRows{
                            for item in indexPaths {
                                self.arrData[item.row] = tempData
                            }
                        }
                        
                        //                        debugPrint("Changed Data", self.arrData[indexPath.row])
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var tempData = Dictionary<String,Any>()
        tempData["is_bold"] = true
        self.arrData[indexPath.row] = tempData
        
        if let getCell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
            //            debugPrint(indexPath)
            
            DispatchQueue.main.async {
                getCell.lblText.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
            }
            
            var tempData = Dictionary<String,Any>()
            tempData["is_bold"] = true
            
            if let indexPaths = tableView.indexPathsForVisibleRows{
                for item in indexPaths {
                    self.arrData[item.row] = tempData
                }
            }
            //            debugPrint("Changed Data", self.arrData[indexPath.row])
        }
    }
}
