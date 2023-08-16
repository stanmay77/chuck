//
//  LoadQuoteVC.swift
//  chuck
//
//  Created by STANISLAV MAYBORODA on 8/15/23.
//

import UIKit

class LoadQuoteVC: UIViewController {

    let realmManager = RealmManager()
    
    lazy var loadButton = CustomButton(frame: .zero, buttonTitle: "Загрузить", titleColor: .white)
    
    { [unowned self] in
        
        DispatchQueue.main.async {
            APILoader.shared.getQuote { [self] result in
                switch result {
                case .success(let joke):
                    realmManager.saveData(joke: joke)
                case .failure(let error):
                    print(error)
                }

            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    

    func configureUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title =  "Загрузить цитаты"
        view.addSubview(loadButton)
        
        NSLayoutConstraint.activate([
            loadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadButton.heightAnchor.constraint(equalToConstant: 70),
            loadButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
    }
}
