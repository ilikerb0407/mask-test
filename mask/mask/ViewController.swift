//
//  ViewController.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    
    var product: MaskData?
    
    var containerView : UIView? = nil
    
    var webView: WKWebView?
    
    override func loadView(){
        super.loadView()
        
        self.webView = WKWebView()
        
        self.view = self.webView
    }
    
    private var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        fetchData()
        
        testtest()
        
        setUpTableView()
        
        let url = URL(string: "https://tw.feature.appledaily.com/collection/dailyquote")
        
        guard let url = url else { return }
        
        let req = URLRequest(url: url)
        
        self.webView!.load(req)
        
        
    }
    
    let maskProvider = MaskProvider()
    
    var datas: MaskData?
    
    var test = [Feature]() {
        
        didSet {
            
            manageMaskData()
        }
    }
    
    var empty = [Feature]()
    
    var taichung = [Feature]()
    
    var taipei = [Feature]()
    
    func manageMaskData() {
        
        empty = []
        
        taichung = []
        
        taipei = []
        
        for route in self.test {
            
            switch route.properties.county {
                
            case County.臺北市:
                
                taipei.append(route)
                
            case County.empty :
                
                empty.append(route)
                
            case County.臺中市:
                taichung.append(route)
                
          
                
            default:
                return
            }
        }
        
        
        
        
    }
    
    // MARK: - Action
    func fetchData() {

        maskProvider.getMaskData (completion: { [weak self] result in
            
            switch result {

            case .success(let products):

//                self?.datas = products
            print ("\(products)")

            case .failure:

//                LKProgressHUD.showFailure(text: "讀取資料失敗！")
                print("讀取資料失敗！")
            }
        })
    }
    // MARK: can show statuscode
    func testtest() {
        
        maskProvider.fetchMaskData(completion: { [weak self] result in
            
            switch result {

            case .success(let products):

                self?.test = products.features
                
                self?.tableView.reloadData()
                
//                self?.saveToDB(products)

            case .failure:

//                LKProgressHUD.showFailure(text: "讀取資料失敗！")
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

                    print("success")

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
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func push(sender: Any?) {
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as? NextViewController {
            
            if let routes = sender as? [Feature] {
                nextViewController.test = routes
            }
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            RecordManager.shared.deleteStorageRecords(fileName: records[indexPath.row].recordName) { result in
//                switch result {
//
//                case .success(_):
                    self.test.remove(at: indexPath.row)

                    self.tableView.deleteRows(at: [indexPath], with: .left)

//                    LKProgressHUD.showSuccess(text: "刪除成功")
//
//                case .failure(let error):
//                    print ("delete error: \(error)")
//                }
//            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var sender = [Feature]()
        
        switch indexPath.row {
            
        case 0 :
            sender = empty
        case 1 :
            sender = taichung
        case 2 :
            sender = taipei
        
        default:
            return
        }
        push(sender: sender)
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        test.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MaskTableViewCell = tableView.dequeueCell(for: indexPath)
        
        
        cell.setUpCell(object: taipei[indexPath.row])
        
        return cell
        
        
    }
    
    
    
}

