//
//  MaskProvider.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation

typealias Hanlder = (Result<MaskData>) -> Void

class MaskProvider {
    
    let decoder = JSONDecoder()
    
    // MARK: get mask
    func fetchMaskData(completion: @escaping Hanlder) {
        
        let urlString = URL(string: "\(Bundle.ValueForString(key: MaskConstant.urlKey))")
        
        guard let urlString = urlString else {
            return
        }
        
        let url = URLRequest(url: urlString)
        
        HTTPClient.shared.request(
            url,
            completion: { [weak self] result in

                guard let strongSelf = self else { return }

                switch result {

                case .success(let data):

                    do {
                        let products = try strongSelf.decoder.decode(
                            MaskData.self,
                            from: data
                        )

                        DispatchQueue.main.async {

                            completion(Result.success(products))
                        }

                    } catch {

                        completion(Result.failure(error))
                    }

                case .failure(let error):

                    completion(Result.failure(error))

                }
        })
        
        
    }
    
    func getMaskData(completion: @escaping Hanlder) {
        
        
        let urlString = URL(string: "\(Bundle.ValueForString(key: MaskConstant.urlKey))")
        
        guard let urlString = urlString else {
            return
        }
        
        let url = URLRequest(url: urlString)
        
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                
                
                let userData = try decoder.decode(MaskData.self, from: data)
                
                DispatchQueue.main.async {

                   completion(Result.success(userData))
                }
                
            } catch {
                
                completion(Result.failure(error))
            }
            
        }) .resume()
        
        
        
    }
}
