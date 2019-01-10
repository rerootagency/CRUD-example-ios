//
//  MainViewController.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//
import UIKit
import Alamofire

final class MainViewController: UIViewController {
    
    var students: [StudentViewModel] = [StudentViewModel]()
    
    private let tableView: UITableView = {
        
        let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Read"
        self.addCreateBarButton()
        self.loadData()
        self.loadViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    private func addCreateBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonTapped(_:)))
    }
    
    func loadData() {
        
        Alamofire.request(StudentRouter.read)
            .responseJSON { [weak self] (response) in
                
                guard let self = self, let jsonData = response.data else { return }
                
                let students = try! JSONDecoder().decode([StudentModel].self, from: jsonData).sorted(by: { (first, second) -> Bool in
                    return first.id < second.id
                })
                
                self.students = students.map({ StudentViewModel(m: $0) })
                self.tableView.reloadData()
        }
    }
    
    private func loadViews() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        setupViews()
    }
    
    private func setupViews() {
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
    }
    
}

//MARK: Table view delegate/datasource
extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.configure(with: students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(DetailsViewController(viewModel: students[indexPath.row], completion: {
            self.navigationController?.popToRootViewController(animated: true)
            print("completed")
        }), animated: true)
    }
    
}

//MARK: Button actions
extension MainViewController {
    
    @objc private func createButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(DetailsViewController(viewModel: StudentViewModel(id: -1, name: "", lastName: "", email: "", position: "", loginDate: ""), type: .creation, completion: {
            self.navigationController?.popToRootViewController(animated: true)
            print("completed")
        }), animated: true)
    }
    
}
