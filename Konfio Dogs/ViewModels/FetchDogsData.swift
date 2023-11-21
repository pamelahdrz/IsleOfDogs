//
//  FetchDogsData.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 20/11/23.
//

protocol FetchDogsData {
    func fetchDogsService(completionHandler: @escaping FetchSuccessful) async throws
    func fetchSavedDogs(completionHandler: @escaping FetchSuccessful) async throws
}
