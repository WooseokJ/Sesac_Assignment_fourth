//
//  ViewController.swift
//  SeSacWeek1617
//
//  Created by useok on 2022/10/18.
//

import UIKit

class SimpleTableViewController: UITableViewController {

    let list = ["슈비버거","프랭크","자갈치","고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //기존
//        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
//        cell.textLabel?.text = list[indexPath.row] // deprecated 될 예정
        
        // 변경
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration() // 셀에 default list content 설정을 구성해줌.
        content.text = list[indexPath.row] // textlabel
        content.secondaryText = "안녕하세요" //detailTextLabel
        cell.contentConfiguration = content //
        return cell
        
    }

}

