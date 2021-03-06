//
//  ViewController.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView?
    
    override func loadView(){
        super.loadView()
        
        self.webView = WKWebView()
    
        self.view = self.webView
    
        
    }
    
    func loadUrl() {
        
        let url = URL(string: "https://tw.feature.appledaily.com/collection/dailyquote")
        
        guard let url = url else { return }
        
        let req = URLRequest(url: url)
        
        self.webView!.load(req)
    }
    
    private var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var orders: [Mask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        saveDataToLocal()
        
        setUpTableView()
        
        loadUrl()
        
    }
    
    let maskProvider = MaskProvider()
    
    
    var masks = [Feature]() {
        
        didSet {
            
            manageMaskData()
        }
    }
    var empty = [Feature]()
    
    var 南投縣 = [Feature]()
    
    var 嘉義市 = [Feature]()
    
    var 嘉義縣 = [Feature]()
    
    var 基隆市 =  [Feature]()
    
    var 宜蘭縣 = [Feature]()
    
    var 屏東縣 = [Feature]()
    
    var 彰化縣 = [Feature]()
    
    var 新北市 = [Feature]()
    
    var 新竹市 = [Feature]()
    
    var 新竹縣 = [Feature]()
    
    var 桃園市 = [Feature]()
    
    var 澎湖縣 = [Feature]()
    
    var 臺中市 = [Feature]()
    
    var 臺北市 = [Feature]()
    
    var 臺南市 = [Feature]()
    
    var 臺東縣 = [Feature]()
    
    var 花蓮縣 = [Feature]()
    
    var 苗栗縣 = [Feature]()
    
    var 連江縣 = [Feature]()
    
    var 金門縣 = [Feature]()
    
    var 雲林縣 = [Feature]()
    
    var 高雄市 = [Feature]()
    
    
    func manageMaskData() {
        
        for route in self.masks {
            
            switch route.properties.county {
                
            case .empty:
                empty.append(route)
            case .南投縣:
                南投縣.append(route)
            case .嘉義市:
                嘉義市.append(route)
            case .嘉義縣:
                嘉義縣.append(route)
            case .基隆市:
                基隆市.append(route)
            case .宜蘭縣:
                宜蘭縣.append(route)
            case .屏東縣:
                屏東縣.append(route)
            case .彰化縣:
                彰化縣.append(route)
            case .新北市:
                新北市.append(route)
            case .新竹市:
                新竹市.append(route)
            case .新竹縣:
                新竹縣.append(route)
            case .桃園市:
                桃園市.append(route)
            case .澎湖縣:
                澎湖縣.append(route)
            case .臺中市:
                臺中市.append(route)
            case .臺北市:
                臺北市.append(route)
            case .臺南市:
                臺南市.append(route)
            case .臺東縣:
                臺東縣.append(route)
            case .花蓮縣:
                花蓮縣.append(route)
            case .苗栗縣:
                苗栗縣.append(route)
            case .連江縣:
                連江縣.append(route)
            case .金門縣:
                金門縣.append(route)
            case .雲林縣:
                雲林縣.append(route)
            case .高雄市:
                高雄市.append(route)
            }
        }
        
    }
    
    // MARK: - Action
    
    func saveDataToLocal() {
        
        maskProvider.fetchMaskData(completion: { [weak self] result in
            
            switch result {
                
            case .success(let products):
                
                self?.saveToDB(products)
                
                self?.masks = products.features
                
                self?.tableView.reloadData()
                
            case .failure:
 
                print("讀取資料失敗！")
            }
        })
    }
    
    func saveToDB(_ product: MaskData) {
        
        StorageManager.shared.saveOrder(
            product: product ,
            
            completion: { result in
                
                switch result {
                    
                case .success:
                    print ("success")
                case .failure:
                    
                    print("failure")
                    
                }
            })
    }
    
    func setUpTableView() {
        
        tableView = UITableView()
        
        tableView.registerCellWithNib(identifier: MaskTableViewCell.identifier, bundle: nil)
        
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var sender = [Feature]()
        
        switch indexPath.row {
      
            
        case 0 :
            sender = empty
        case 1 :
            sender = 南投縣
        case 2 :
            sender = 嘉義市
        case 3 :
            sender = 嘉義縣
        case 4 :
            sender = 基隆市
        case 5 :
            sender = 宜蘭縣
        case 6 :
            sender = 屏東縣
        case 7 :
            sender = 彰化縣
        case 8 :
            sender = 新北市
        case 9 :
            sender = 新竹市
        case 10 :
            sender =  新竹縣
        case 11 :
            sender = 桃園市
        case 12 :
            sender = 澎湖縣
        case 13 :
            sender = 臺中市
        case 14 :
            sender = 臺北市
        case 15 :
            sender = 臺南市
        case 16 :
            sender = 臺東縣
        case 17 :
            sender = 花蓮縣
        case 18 :
            sender = 苗栗縣
        case 19 :
            sender = 連江縣
        case 20 :
            sender = 金門縣
        case 21 :
            sender = 雲林縣
        case 22 :
            sender = 高雄市
       
        default:
            return
        }
        push(sender: sender)
        
    }
    
    func push(sender: Any?) {
        
        
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as? NextViewController {
            
            if let feature = sender as? [Feature] {
                nextViewController.feature = feature
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
     
    }
}




extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        CitiesType.allCases.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MaskTableViewCell = tableView.dequeueCell(for: indexPath)
        
        cell.setUpCell(object: CitiesType.allCases[indexPath.row].rawValue)
        
        return cell
        
        
    }
    
    
    
}

