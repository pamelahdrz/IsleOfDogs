//
//  DogsDashboardViewModel.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import Foundation
import UIKit

final class DogsDashboardViewModel: NSObject {
    
    var dogsData = [DogsCellModel]()
    var dogsCoreData = DogsCoreData.shared
    
    weak var viewController: UIViewController?
    weak var delegate: DogsDashboardViewModelDelegate?
    
    init(delegate: DogsDashboardViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
}

extension DogsDashboardViewModel: FetchDogsData {
    @MainActor
    func fetchDogsService(completionHandler: @escaping FetchSuccessful) async {
        GeneralRequestDispatcher.shared.fetchDogsResponse { (response) in
            switch response.result {
            case .success(let data):
                
                self.dogsData.append(.dogs(data))
                
                ///Save Dogs Data
                data.forEach { dogs in
                    self.dogsCoreData.saveDogsData(for: dogs)
                }
                
                completionHandler(true, nil)
            case .failure(let error):
                completionHandler(false, error as NSError)
                self.configureAlertView(with: .externalIssue)
            }
        }
    }
    
    @MainActor
    func fetchSavedDogs(completionHandler: @escaping FetchSuccessful) async {
        do {
            let saveDogsData = try await self.dogsCoreData.getDogsData()
            guard let savedData = saveDogsData else { return }
            
            savedData.isEmpty ? 
            configureAlertView(with: .internalIssue) :
            self.dogsData.append(.dogs(savedData))
            
            completionHandler(true, nil)
            
        } catch {
            print(error.localizedDescription)
            completionHandler(false, error as NSError)
        }
    }
}

extension DogsDashboardViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.dogsData[section] {
        case .dogs(let data):
            self.delegate?.hideActivityMonitor(data.isEmpty)
            return data.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dogsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogsCell.id, for: indexPath) as? DogsCell else { return UITableViewCell() }
        
        switch self.dogsData[indexPath.section] {
        case .dogs(let data):
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.configure(with: data[indexPath.row])
        }
        return cell
    }
    
}

extension DogsDashboardViewModel {
    func configureAlertView(with problemType: ErrorHandler) {
        var title = ""
        var message = ""
        
        switch problemType {
        case .externalIssue:
            title = "External Issue"
            message = """
                       There is an external issue.
                       Please try again.
                       """
        case .internalIssue:
            title = "Internal Issue"
            message = """
                       There is an internal issue.
                       Please try again.
                       """
        case .connectionIssue:
            title = "Connection Issue"
            message = """
                       No internet connection found.
                       Please check your internet settings and try again.
                       """
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.delegate?.listenToReachability()
        }
        alert.addAction(OKAction)
        
        self.viewController?.navigationController?.present(alert, animated: true, completion: nil)
    }
}


