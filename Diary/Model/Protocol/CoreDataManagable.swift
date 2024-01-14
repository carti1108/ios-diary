//
//  CoreDataManagable.swift
//  Diary
//
//  Created by Kiseok on 1/14/24.
//

import Foundation

protocol CoreDataManagable {
    associatedtype T
    
    func saveContext()
    func saveData(_ data: T)
    func fetchData() -> [T]
    func updateData(_ data: T)
    func deleteData(_ data: T)
}
