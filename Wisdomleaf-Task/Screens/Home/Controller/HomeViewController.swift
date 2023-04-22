//
//  HomeViewController.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import UIKit
import Kingfisher


class HomeViewController: UIViewController {
    
    private var dataSource: [PicsumPhotosModel] = []
    private var currentPage = 1
    private var isLoading = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "The Lorem Ipsum for photos"
        addViewsAndConstraints()
        fetchPhotosList(page: currentPage)
    }
    
    private func addViewsAndConstraints() {
        view.addSubview(tableView)
        view.addSubview(loader)
        tableView.addSubview(refreshControl)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: .ratioHeight(50)),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func refresh() {
        currentPage = 1
        dataSource = []
        tableView.reloadData()
        fetchPhotosList(page: currentPage)
    }
    
    private func fetchPhotosList(page: Int){
        isLoading = true
        loader.startAnimating()
        Services.getPhotosList(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataModel):
                self.dataSource.append(contentsOf: dataModel ?? [])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                    self.loader.stopAnimating()
                    self.refreshControl.endRefreshing()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.loader.stopAnimating()
                    self.refreshControl.endRefreshing()
                }
                break
            }
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Unexpected cell type dequeued")
        }
        cell.selectionStyle = .none
        cell.configureCell(dataSource: dataSource[indexPath.row])
        cell.didTapCheckbox = { [weak self] isChecked in
            self?.dataSource[indexPath.row].isChecked = isChecked
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Check the state of the table view and determine whether to load more data.
        switch (indexPath.row, isLoading, currentPage) {
        case (dataSource.count - 1, false, ..<10):
            isLoading = true
            currentPage += 1
            fetchPhotosList(page: currentPage)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
