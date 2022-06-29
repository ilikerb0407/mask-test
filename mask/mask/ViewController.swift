//
//  ViewController.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit

class ViewController: UIViewController {

    
    var product: MaskData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        fetchData()
        
        testtest()
        
        
    }
    
    let maskProvider = MaskProvider()
    
    var datas: MaskData?
    
    var test: MaskData?
    
    // MARK: - Action
    func fetchData() {

        maskProvider.getMaskData (completion: { [weak self] result in
            
            switch result {

            case .success(let products):

                self?.datas = products
            

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

                self?.test = products
                
                self?.saveToDB(products)

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
    
    
    


}

