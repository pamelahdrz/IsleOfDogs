//
//  DogsCore.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 19/11/23.
//

import CoreData

///@MainActor usage: You can use it instead of: 'DispatchQueue.main.async' (introduced in Swift 5.5)
@MainActor
final class DogsCoreData {
    
    static let shared: DogsCoreData = DogsCoreData()
    
    private init() { }
}

extension DogsCoreData {
    
    func getDogsData() async throws -> [DogsModel]? {
        AppDelegate.shared.container.viewContext.performAndWait {
            let data = try? DogsEntity.fetchAllData(AppDelegate.shared.container.viewContext)
            let dogsData = data?.map { DogsModel(entity: $0) }
            guard let dogs = dogsData else { return nil }
            return dogs
        }
    }
    
    func saveDogsData(for model: DogsModel) {
        AppDelegate.shared.container.viewContext.perform {
            do {
                try DogsEntity.fetchEntity(
                    for: model,
                    AppDelegate.shared.container.viewContext
                )
                AppDelegate.saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
