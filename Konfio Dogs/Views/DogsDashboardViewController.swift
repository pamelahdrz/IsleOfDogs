//
//  DogsDashboardViewController.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import Foundation
import UIKit
import Alamofire

class DogsDashboardViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dogsTable: UITableView!
    
    private var viewModel: DogsDashboardViewModel!
    
    private var reachabilityManager: NetworkReachabilityManager?
    
    private let launchCounter = UserDefaults.standard.integer(forKey: "launchCounter")
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.viewModel = DogsDashboardViewModel(delegate: self)
        self.viewModel.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.fetchData()
    }
    
    private func configureView() {
        guard let logo = UIGeneral.isleOfDogsLogo else { return }
        self.navigationItem.setLeftBarButton(
            .createBarButtonImage(logo,
                                  frame: (
                                    width: self.view.frame.size.width * 0.3,
                                    height: 45.0)),
            animated: true)
        
        self.activityIndicator.color = .systemGray2
    }
    
    private func configureTableView() {
        self.dogsTable.dataSource = self.viewModel
        self.dogsTable.delegate = self.viewModel
        self.dogsTable.isScrollEnabled = true
        self.dogsTable.separatorStyle = .none
        self.dogsTable.backgroundColor = UIGeneral.clearGray
        self.dogsTable.register(DogsCell.self, forCellReuseIdentifier: DogsCell.id)
    }
    
    private func fetchData() {
        if launchCounter >= 2 {
            self.fetchSavedData()
        } else {
            self.listenToReachability()
        }
    }
}

extension DogsDashboardViewController: DogsDashboardViewModelDelegate {
    func hideActivityMonitor(_ isEmpty: Bool) {
        let hide = isEmpty ? false : true
        self.activityIndicator.isHidden = hide
    }
    
    func listenToReachability() {
        self.reachabilityManager = NetworkReachabilityManager()
        self.reachabilityManager?.startListening { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .reachable:
                guard self.viewModel.dogsData.count == 0 else { return }
                self.fetchDogsServer()
            case .notReachable:
                self.viewModel.configureAlertView(with: .connectionIssue)
            case .unknown:
                break
            }
        }
    }
}

///Saved Data and Endpoint
extension DogsDashboardViewController {
    
    private func fetchSavedData() {
        Task { await self.viewModel.fetchSavedDogs { success, error in
            if success {
                self.configureTableView()
            } else {
                self.activityIndicator.isHidden = false
                print("Error: Table not initialized")
            }
        }
        }
    }
    
    private func fetchDogsServer() {
        Task { await self.viewModel.fetchDogsService { success, error in
            if success {
                self.launchCounter >= 2 ? 
                self.dogsTable.reloadData() : 
                self.configureTableView()
            } else {
                self.activityIndicator.isHidden = false
                print("Error: Table not initialized")
            }
        }
        }
    }
}
