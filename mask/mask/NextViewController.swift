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
                
            case .empty:
                themeLabel = "其他縣市"
            case .南投縣:
                themeLabel = CitiesType.南投縣.rawValue
            case .嘉義市:
                themeLabel = CitiesType.嘉義市.rawValue
            case .嘉義縣:
                themeLabel = "嘉義縣"
            case .基隆市:
                themeLabel = "基隆市"
            case .宜蘭縣:
                themeLabel = "宜蘭縣"
            case .屏東縣:
                themeLabel = "屏東縣"
            case .彰化縣:
                
                themeLabel = "彰化縣"
            case .新北市:
                
                themeLabel = "新北市"
            case .新竹市:
                themeLabel = "新竹市"
            case .新竹縣:
                themeLabel = "新竹縣"
            case .桃園市:
                themeLabel = "桃園市"
            case .澎湖縣:
                themeLabel = "澎湖縣"
            case .臺中市:
                
                themeLabel = "臺中市"
            case .臺北市:
                
                themeLabel = "臺北市"
            case .臺南市:
                
                themeLabel = "臺南市"
            case .臺東縣:
                
                themeLabel = "臺東縣"
            case .花蓮縣:
                
                themeLabel = "花蓮縣"
            case .苗栗縣:
                
                themeLabel = "苗栗縣"
            case .連江縣:
                
                themeLabel = "連江縣"
            case .金門縣:
                themeLabel = "金門縣"
            case .雲林縣:
                
                themeLabel = "雲林縣"
            case .高雄市:
                
                themeLabel = "高雄市"
                
                
            default:
                return
            }
        }
    }
    
    func setUpThemeTag() {
        
        let view = UIView(frame: CGRect(x: -20, y: 110, width: 120, height: 40))
        
        let label = UILabel(frame: CGRect(x: 0, y: 110 , width: 120, height: 35))
        
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 20
        
        view.layer.masksToBounds = true
        
        label.text = themeLabel
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.font = UIFont.systemFont(ofSize: 20)
        
        self.view.addSubview(view)
        
        self.view.addSubview(label)
    }
    
    
}

extension NextViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.test.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .left)
            
        }
        
    }
    
}

extension NextViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: NextTableViewCell = tableView.dequeueCell(for: indexPath)
        
        cell.setUpCell(model: test[indexPath.row])
        
        return cell
        
    }
    
    
    
    
    
}
