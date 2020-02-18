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
        
        tbv.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tbv.separatorStyle = .none
        
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
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HeaderView
        headerView?.label.text = "\(sections[section].title)"
        headerView?.btn.setImage( sections[section].isExpanded ? UIImage(systemName: "minus") : UIImage(systemName: "plus") , for: .normal)
        headerView?.btn.addTarget(self, action: #selector(sectionTapped(btn:)), for: .touchUpInside)
        headerView?.btn.tag = section
        return headerView
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



class HeaderView: UITableViewHeaderFooterView{
    
    
    var label = {  () -> UILabel in
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    var btn = { () -> UIButton in
       let btn = UIButton()
        btn.tintColor = .white
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = false
        return btn
    }()
    
    
    var view = { () -> UIView in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.06715562195, green: 0.1882866323, blue: 0.3501978517, alpha: 1)
        return view
    }()
    
    var seperator = { () -> UIView in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        contentView.backgroundColor = .white
        contentView.addSubview(view)
        view.addSubview(label)
        view.addSubview(btn)
        view.addSubview(seperator)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = .init(x: 16, y: 0, width: frame.width - 32, height: frame.height)
        label.frame = .init(x: 16, y: 0, width: view.frame.width - 32 - 32, height: frame.height)
        btn.frame = .init(x: label.frame.maxX, y: 5, width: 32, height: frame.height - 9)
        seperator.frame = .init(x: 0, y: 0, width: view.frame.width, height: 1)
    }
    
}

