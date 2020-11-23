//
//  TasksListViewModel.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 22.11.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TasksListViewModel {
    
    let disposeBag = DisposeBag()
    let list = BehaviorRelay<[TaskViewModel]>(value: [])
    let repository = TaskRepository()
    
    init() {
        self.setupTaskObserve()
        repository.getAll()
    }
    
    private func setupTaskObserve() {
        repository.tasks
            .asObservable()
            .map({ $0 })
            .subscribe(onNext: { (tasks: [Task]) in
                self.list.accept(
                    tasks.compactMap { (task) -> TaskViewModel in
                        return TaskViewModel(task)
                    }
                )
            })
            .disposed(by: disposeBag)
    }
    
    public func add(withTitle title: String, withAim aim: Aim) {
        repository.add(withTitle: title, withAim: aim)
    }
    
    public func delete(withIndex index: Int) {
        repository.delete(index: index)
    }
    
}
