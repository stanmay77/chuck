import UIKit

class AllQuotesVC: UIViewController {
    
    let realmManager = RealmManager()
    var inputCategoryJokes: [JokeRealm]? = nil
    var vcTitle: String? = nil
    
    var jokesSorted: [JokeRealm] {
        if let inputCategoryJokes {
            return inputCategoryJokes.sorted(by:{$0.dateDownloaded < $1.dateDownloaded})
        } else {
            self.inputCategoryJokes = realmManager.jokes
            return inputCategoryJokes!.sorted(by:{$0.dateDownloaded < $1.dateDownloaded})
        }
    }

    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "jokesCell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title =  vcTitle ?? "Все цитаты"
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

extension AllQuotesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokesCell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YY HH:MM:ss"
        var dateDownloaded = dateFormatter.string(from: jokesSorted[indexPath.row].dateDownloaded)
        
        config.text = "🤣 "+jokesSorted[indexPath.row].joke
        config.secondaryText = dateDownloaded
        cell.contentConfiguration = config
        return cell
    }
}
