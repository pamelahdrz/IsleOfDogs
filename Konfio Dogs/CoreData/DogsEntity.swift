//
//  DogsEntity.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 18/11/23.
//
//

import CoreData

@objc(DogsEntity)
public class DogsEntity: NSManagedObject {
    
    ///@discardableResult usage: allows you to use the return value if you want while you can decide as well to just ignore it. This keeps your code clean and removes any related warnings in your project.
    @discardableResult class func fetchEntity(for dogsModel: DogsModel, _ context: NSManagedObjectContext) throws -> DogsEntity {
        
        ///Entity Elements
        let dogsEntity = DogsEntity(context: context)
            dogsEntity.name = dogsModel.name
            dogsEntity.dogDescription = dogsModel.description
            dogsEntity.image = dogsModel.image
            
            if let age = dogsModel.age {
                dogsEntity.age = Int32(age)
            }
        
        return dogsEntity
    }
    
    @discardableResult class func fetchAllData(_ context: NSManagedObjectContext) throws -> [DogsEntity] {
        let request: NSFetchRequest<DogsEntity> = DogsEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}
