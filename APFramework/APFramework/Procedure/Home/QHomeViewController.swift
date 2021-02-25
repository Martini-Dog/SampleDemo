//
//  QHomeViewController.swift
//  APFramework
//
//  Created by viatom on 2020/4/17.
//  Copyright © 2020 The_X. All rights reserved.
//

import UIKit

class QHomeViewController: QBaseViewController {

    private lazy var dataList = [["PhotoKit": ["", ""]],
                                 ["AVFoundtion": ["\(QAVPlayerViewController.self)", "\(QCameraViewController.self)"]]]
//                                 ["CoreBluetooth": ["", ""]]]
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK - Property
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.dataSource = self; $0.delegate = self
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension QHomeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = dataList[section][dataList[section].keys.first!]
        return s?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailArr = dataList[indexPath.section][dataList[indexPath.section].keys.first!]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "sampleTCell")
        
        cell.textLabel?.text = detailArr?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detail = dataList[indexPath.section][dataList[indexPath.section].keys.first!]?[indexPath.row] else { return }
        let className = "\(Bundle.main.spaceName)" + "." + "\(detail)"
        let vcClass = NSClassFromString(className) as? QBaseViewController.Type
        let VC = vcClass!.init()
        
        navigationController?.pushViewController(VC)
//        present(VC, animated: true, completion: nil)
        
   
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataList[section].keys.first
    }
    
}

// MARK: - Configuration UI

extension QHomeViewController {
    
    override func configNavigationBar() {
        
        navigationItem.title = "Products"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configurtionUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (mask) in
            mask.top.equalTo(view.usnp.top)
            mask.left.bottom.right.equalToSuperview()
        }
    }
}
