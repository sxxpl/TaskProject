//
//  ViewController.swift
//  TasksProject
//
//  Created by Артем Тихонов on 24.08.2022.
//

import UIKit

class ViewController: UIViewController {

    var tasks:TaskProtocol = Tasks(description: "main", inTasks: [])
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
        setupConstrains()
    }
    
    private func setupTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identificator)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupNavigationItem(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addTask(){
        let addWindow = UIAlertController(title: "Add task:", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let textField = addWindow.textFields?.first,
                   let text = textField.text
            {
                if text != "" {
                    DispatchQueue.main.async {
                        let task = Tasks(description: text, inTasks: [])
                        self.tasks.inTasks.append(task)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        addWindow.addTextField { textField in
            textField.placeholder = "Task"
        }
        addWindow.addAction(alertAction)
        addWindow.addAction(cancelAction)
        self.present(addWindow, animated: true)
        
    }
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identificator, for: indexPath) as! TaskTableViewCell
        cell.selectionStyle = .none
        cell.configure(description: tasks.inTasks[indexPath.row].description)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.inTasks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = ViewController()
        nextViewController.tasks = self.tasks.inTasks[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

