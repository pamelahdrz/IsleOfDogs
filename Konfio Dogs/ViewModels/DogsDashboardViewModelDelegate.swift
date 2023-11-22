//
//  DogsDashboardViewModelDelegate.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 20/11/23.
//

import UIKit

protocol DogsDashboardViewModelDelegate: AnyObject {
    func hideActivityMonitor(_ isEmpty: Bool)
    func listenToReachability()
    func presentUIAlert(_ alert: UIAlertController)
}
