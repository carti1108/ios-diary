//
//  DiaryMO+CoreDataProperties.swift
//  Diary
//
//  Created by Kiseok on 1/12/24.
//
//

import Foundation
import CoreData


extension DiaryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryMO> {
        return NSFetchRequest<DiaryMO>(entityName: "DiaryModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?

}

extension DiaryMO : Identifiable {

}
