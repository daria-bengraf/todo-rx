//
//  ToDoListController.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 11.10.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class ToDoListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let reuseIdentifier = "Cell"
    
    let taskListViewModel = TasksListViewModel()
    let disposeBag = DisposeBag()

    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListViewModel.list.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoCell
            else { fatalError("no cell")}
        
        let taskViewModel = taskListViewModel.list.value[indexPath.row]
        
        taskViewModel.title
            .asDriver(onErrorJustReturn:"")
            .drive(cell.taskTitle.rx.text)
            .disposed(by: disposeBag)
        
        taskViewModel.aimTitle
            .asDriver(onErrorJustReturn:"")
            .drive(cell.aimTitle.rx.text)
            .disposed(by: disposeBag)
        
        taskViewModel.aimColor
            .asDriver(onErrorJustReturn: UIColor())
            .drive(cell.taskTitle.rx.textColor)
            .disposed(by: disposeBag)
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskListViewModel.delete(withIndex: indexPath.row)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.register(ToDoCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupViews()
        
        
        taskListViewModel
            .list
            .observeOn(MainScheduler.instance)
            .bind(onNext: { (tasks: [TaskViewModel]) -> Void in
                self.reloadTableView()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "What do you do today?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .done,
            target: self,
            action: #selector(addTapped)
        )
        view.addSubview(tableView)
        addConstraints ()
        
    }
    
    
    private func addConstraints () {
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant:10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        
    }
    
    
    @objc func addTapped () {
        let addTaskController = AddTaskController()
        
        addTaskController.taskSubject
            .subscribe(onNext: { [weak self] (dto: TaskDTO) in
                guard let self = self else { return }
                self.taskListViewModel.add(
                    withTitle: dto.title,
                    withAim: dto.aim
                )
                
                
            }).disposed(by: disposeBag)
        
        
        addTaskController.segmentedControl.selectedSegmentIndex = 0
        navigationController?.pushViewController(addTaskController, animated: true)
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
