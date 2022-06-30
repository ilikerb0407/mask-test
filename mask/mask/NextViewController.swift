//
//  NextViewController.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit

class NextViewController: UIViewController {
    
    
    private var themeLabel = ""
    
    private var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    var test = [Feature]() {
        didSet {
            
            setUpLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
        
        setUpThemeTag()
        
    }
    
    func setUpTableView() {
        
        tableView = UITableView()
        
        tableView.registerCellWithNib(identifier: NextTableViewCell.identifier, bundle: nil)
        
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func setUpLabel() {
        
        if let label = test.first?.properties.county {
            
            switch label {
            
            case.empty:
                themeLabel = CitiesType.empty.rawValue
            
                
            default:
                return
            }
        }
    }
    
    func setUpThemeTag() {
        
        let view = UIView(frame: CGRect(x: -20, y: 80, width: 80, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 80 , width: 120, height: 35))
        
        view.backgroundColor = UIColor.red
        
        view.layer.cornerRadius = 20
        
        view.layer.masksToBounds = true
        
        label.text = themeLabel
        
        label.textColor = .blue
        
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        self.view.addSubview(view)
        
        self.view.addSubview(label)
    }


}

extension NextViewController: UITableViewDelegate {
    
    
}

extension NextViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell: RoutesTableViewCell = tableView.dequeueCell(for: indexPath)
//
//        cell.setUpCell(model: self.routes[indexPath.row])
//
//        cell.rideBtn.tag = indexPath.row
//
//        return cell
        
        return UITableViewCell()
    }
    
    
    
    
    
}
