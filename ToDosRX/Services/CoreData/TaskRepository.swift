//
//  TaskRepository.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 22.11.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TaskRepository {
    
    let tasks = BehaviorRelay<[Task]>(value: [])
    let context = CoreDataStack.instance.managedContext
    let backgroundContext = CoreDataStack.instance.backgroundContext
    
    public func getAll() -> Void{
        let request = Task.getFetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            let result: [Task]
            try result = backgroundContext.fetch(request)
            tasks.accept(result)
        } catch {
            
        }
    }
    
    public func add(withTitle title: String, withAim aim: Aim) {
        let task = Task.createNew()
        
        task.title = title
        task.aim = aim
        
        do {
            try backgroundContext.save()
            _ = getAll()
        } catch {
            fatalError("Can not save task")
        }
    }
    
    public func delete(index: Int) -> Void {
        do {            
            backgroundContext.delete(tasks.value[index])
            _ = getAll()
        } catch {
            fatalError("Can not delete")
        }
        
    }
    
}
