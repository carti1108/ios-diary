//
//  CoreDataManager.swift
//  Diary
//
//  Created by Kiseok on 1/13/24.
//

import Foundation
import CoreData

extension HomeViewController: CoreDataManagable {
    
    var context: NSManagedObjectContext {
        return AppDelegate().persistentContainer.viewContext
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveData(_ diary: Diary) {
        let entity = NSEntityDescription.entity(forEntityName: "DiaryModel", in: context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(diary.title, forKey: "title")
            managedObject.setValue(diary.body, forKey: "body")
            managedObject.setValue(diary.createdAt, forKey: "createdAt")
            managedObject.setValue(diary.id, forKey: "id")
            
            saveContext()
        }
    }
    
    func fetchData() -> [Diary] {
        var diaryArray: [Diary] = []
        
        do {
            let diaries = try context.fetch(DiaryMO.fetchRequest())
            diaries.forEach { diary in
                if let diaryId = diary.id,
                   let diaryTitle = diary.title,
                   let diaryBody = diary.body,
                   let diaryDate = diary.createdAt {
                    let diaryData = Diary(
                        title: diaryTitle,
                        body: diaryBody,
                        createdAt: diaryDate,
                        id: diaryId
                    )
                    diaryArray.append(diaryData)
                }
            }
            try context.save()
            
            return diaryArray
        } catch {
            print(error.localizedDescription)
        }
        
        return diaryArray
    }
    
    func updateData(_ data: Diary) {
        let fetchRequest = DiaryMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        
        do {
            let diary = try context.fetch(fetchRequest)
            let diaryUpdate = diary[0] as NSManagedObject
            diaryUpdate.setValue(data.title, forKey: "title")
            diaryUpdate.setValue(data.body, forKey: "body")
            diaryUpdate.setValue(data.createdAt, forKey: "createdAt")
            
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(_ data: Diary) {
        let fetchRequest = DiaryMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        
        do {
            let diary = try context.fetch(fetchRequest)
            let diaryUpdate = diary[0] as NSManagedObject
            context.delete(diaryUpdate)
            
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
