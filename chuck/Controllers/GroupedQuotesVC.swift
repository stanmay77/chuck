//
//  GroupedQuotesVC.swift
//  chuck
//
//  Created by STANISLAV MAYBORODA on 8/15/23.
//

import UIKit

class GroupedQuotesVC: UIViewController {

    let realmManager = RealmManager()
    var categories:[String] {
        let catArr = realmManager.jokes.map({$0.category})
        return catArr.unique()
    }

    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "categoriesCell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Категории цитат"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }

}

extension GroupedQuotesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        
        config.text = categories[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AllQuotesVC()
        vc.inputCategoryJokes = realmManager.jokes.filter({$0.category == categories[indexPath.row]})
        vc.vcTitle = "Цитаты из категории \(categories[indexPath.row])"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
