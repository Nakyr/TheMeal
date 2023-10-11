//
//  ViewController.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 06/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: MealTableViewCell.reuseIdentifier)
        viewModel.didLoad()
    }
}

extension ViewController {
    func bind() {
        viewModel.showActivityIndicator = { [weak self] show in
            DispatchQueue.main.async {
                if show {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
        
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.reuseIdentifier, for: indexPath)
        if let mealTableViewCell = cell as? MealTableViewCell {
            let item = viewModel.itemAt(index: indexPath.row)
            mealTableViewCell.fillWith(name: item.strMeal, urlImage: item.strMealThumb)
        }
        
        return cell
    }
}
