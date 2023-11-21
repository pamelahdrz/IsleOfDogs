//
//  GeneralRequestDispatcher.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import Foundation
import UIKit
import Alamofire

protocol ServiceProvider {
    func fetchDogsResponse(completionHandler: @escaping (AFDataResponse<[DogsModel]>) -> ())
}

public typealias FetchSuccessful = (_ success : Bool, _ error : NSError?) -> ()


final class GeneralRequestDispatcher: ServiceProvider {
    static let shared = GeneralRequestDispatcher()
    
    private init(){ }
    
    let endpointServer = "https://jsonblob.com/api/1151549092634943488"
    
    func fetchDogsResponse(completionHandler: @escaping (AFDataResponse<[DogsModel]>) -> ()) {
        AF.request(endpointServer, method: .get)
            .validate()
            .responseDecodable(of: [DogsModel].self) { (response : AFDataResponse<[DogsModel]>) in
                completionHandler(response)
                
                guard let statusCode = response.response?.statusCode else { return }
                
                guard let responseData = response.data else {
                    print("Error en Server: Dogs: \(statusCode)")
                    print("nil data received from Response")
                    return
                }
                
                
                let strData = String(data: responseData, encoding: .utf8)
                print("-----------Response Starts: DogsServer--------------")
                print("----------------------------------------------------")
                print("-----------------StatusCode: \(statusCode)--------------------")
                print("\(strData ?? "")")
                print("----------------------------------------------------")
                print("------------Response Ends: DogsServer---------------")
            }
    }
}
