//
//  ViewController.swift
//  ExpandableTableview
//
//  Created by Aqib Ali on 16/02/20.
//  Copyright © 2020 Aqib Ali. All rights reserved.
//

import UIKit


class Section{
    var title:String
    var isExpanded = true
    var items:Array<Item>
    
    init(title:String,items:Array<Item>) {
        self.title = title
        self.items = items
    }
}


struct Item{
    var name:String
    var price:Int
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tbv:UITableView!
    
    var sections = [
        Section(title: "Fruits", items: [
            Item(name: "Apple", price: 50),
            Item(name: "Grapes", price: 60),
            Item(name: "Papaya", price: 40),
            Item(name: "Banana", price: 30)
        ]),
        Section(title: "Vegetables", items: [
            Item(name: "Peas", price: 40),
            Item(name: "Beans", price: 40),
            Item(name: "Cauliflower", price: 30),
            Item(name: "Cabage", price: 30)
        ]),
        Section(title: "Cerals", items: [
            Item(name: "Rajma", price: 90),
            Item(name: "Chana", price: 70),
            Item(name: "Chick Pea", price: 80)
        ])
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.isExpanded ? section.items.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        let item = sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = "Name: \(item.name)"
        cell.detailTextLabel?.text = "Price: $\(item.price)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: .zero)
        v.backgroundColor = #colorLiteral(red: 0.06715562195, green: 0.1882866323, blue: 0.3501978517, alpha: 1)
        
        let frame = CGRect(x: 16, y: 0, width: tableView.frame.width - 32, height: 40)
        let headerLabel = UILabel(frame: frame)
        v.addSubview(headerLabel)
        headerLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        headerLabel.textColor = .white
        headerLabel.text = "\(sections[section].title)"
        
        let btn = UIButton(frame: .init(x: tableView.frame.width - 24 - 32, y: 4, width: 32, height: 32))
        btn.setImage( sections[section].isExpanded ? UIImage(systemName: "minus") : UIImage(systemName: "plus") , for: .normal)
        btn.tintColor = .white
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = false
        btn.addTarget(self, action: #selector(sectionTapped(btn:)), for: .touchUpInside)
        btn.tag = section
        v.addSubview(btn)
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    
    @objc func sectionTapped(btn:UIButton){
        let section = btn.tag
        sections[section].isExpanded = !sections[section].isExpanded
        tbv.reloadSections(IndexSet(arrayLiteral: section), with: .automatic)
    }
    
}


