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
        tableView.delegate = self
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
        
        viewModel.showMealDetail = { [weak self] mealDetailViewModel in
            guard let self = self else { return }
            let mealDetailViewcontroller = MealDetailViewController.make(viewModel: mealDetailViewModel)
            let navigationController = UINavigationController(rootViewController: mealDetailViewcontroller)
            let barButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close(_:)))
            mealDetailViewcontroller.navigationItem.leftBarButtonItem = barButton
            DispatchQueue.main.async {
                self.present(navigationController, animated: true)
            }
        }
        
        viewModel.showFullScreenError = { [weak self] message in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.showFullScreenError(message: message)
            }
        }
        
        viewModel.hideFullScreenError = { [weak self] in
            DispatchQueue.main.async {
                self?.dismissFullScreenError()
            }
        }
    }
    
    @objc func close(_ sender: UIButton) {
        self.dismiss(animated: true)
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
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowWasSelected(row: indexPath.row)
    }
}

extension ViewController: FullScreenErrorPresenter {
    func retryFullScreenErrorBlockCalled() {
        viewModel.retryButtonWasTapped()
    }
}
