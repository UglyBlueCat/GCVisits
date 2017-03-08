//
//  ViewController.swift
//  GCVisits
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allVisits : NSArray = DB_Interface.sharedInstance.allVisits()
    var resultsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "kDataLoaded"), object: nil)
        createObjects()
        setupObjects()
        positionObjectsWithinSize(size: view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        positionObjectsWithinSize(size: size)
        resultsTable.reloadData()
    }

    func createObjects() {
        
        resultsTable = UITableView()
        self.view.addSubview(resultsTable)
    }
    
    func setupObjects() {
        
        resultsTable.dataSource = self
        resultsTable.delegate = self
        resultsTable.register(GCVisitCell.self, forCellReuseIdentifier: "GCVisitCell")
    }
    
    func positionObjectsWithinSize(size: CGSize) {
        let topMargin : CGFloat = 40.0
        let margin : CGFloat = 10.0
        let viewHeight : CGFloat = self.view.bounds.size.height
        let viewWidth : CGFloat = self.view.bounds.size.width
        
        resultsTable.frame = CGRect(x: margin,
                                    y: topMargin + margin,
                                    width: viewWidth - 2*margin,
                                    height: viewHeight - 2*margin)
    }
    
    func reloadTable() {
        
        DispatchQueue.main.async {
            self.resultsTable!.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allVisits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : GCVisitCell = tableView.dequeueReusableCell(withIdentifier: "GCVisitCell", for: indexPath) as! GCVisitCell
        
        if let visit: NSDictionary = allVisits[indexPath.row] as? NSDictionary {
            if let visitNumber = visit.object(forKey: "visitNumber") as? Int,
                let siteId = visit.object(forKey: "siteId") as? String,
                let client = visit.object(forKey: "client") as? String,
                let site = visit.object(forKey: "site") as? String {
                
                cell.visitNumberLabel!.text = "visit #: \(visitNumber)"
                cell.siteIdLabel!.text = "siteId: \(siteId)"
                cell.clientLabel!.text = "\(client)"
                cell.siteLabel!.text = "\(site)"
            }
        }
        
        return cell;
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
