//
//  TaskViewModel.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 22.11.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//
import RxSwift
import RxCocoa

class TaskViewModel {
    
    let taskModel: Task
    let disposeBag = DisposeBag()
        
    init( _ taskModel: Task) {
        self.taskModel = taskModel
    }
    

    var title: Observable<String>{
        return Observable<String>.just(taskModel.title ?? "")
    }
    
    var aimTitle: Observable<String>{
        return Observable<String>.just(taskModel.aim.title)
    }
    
    var aimColor: Observable<UIColor>{
        return Observable<UIColor>.just(taskModel.aim.color)
    }
    
}
