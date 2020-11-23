//
//  AimEnum.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 11.10.2020.
//  Copyr.ight © 2020 Dariya Bengraf. All rights reserved.
//

import CoreData
import Foundation

@objc(Task)
final class Task: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var aimEnum: Int16
    
    private static let entityName = "Task"
    
    public var aim: Aim {
        get { Aim.init(rawValue: Int(aimEnum)) ?? .goals }
        set { aimEnum = newValue.getInt() }
    }
    
    convenience init(title: String, aim: Aim) {
        let context = CoreDataStack.instance.backgroundContext
        let entity = NSEntityDescription.entity(forEntityName: Task.entityName, in: context)
        
        self.init(entity: entity!, insertInto: context)
        self.title = title
        self.aim = aim
    }
    
    @nonobjc static func getFetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: Task.entityName)
    }
    
    @nonobjc static func createNew() -> Task {
        return NSEntityDescription.insertNewObject(
            forEntityName: Task.entityName,
            into: CoreDataStack.instance.backgroundContext
        ) as! Task
    }
    
    
}
