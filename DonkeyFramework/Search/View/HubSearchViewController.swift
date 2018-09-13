//
//  HubSearchViewController.swift
//  DonkeyFramework
//
//  Created by Aleksander Maj on 13/09/2018.
//  Copyright © 2018 HTD. All rights reserved.
//

import UIKit

protocol HubSearchViewType: class {
    func showResults(_: [String])
}

class HubSearchViewController: UITableViewController {

    var viewModel: HubsSearchViewModelInput

    var results = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: HubsSearchViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HubSearchViewController.self),
                   bundle: Bundle(for: HubSearchViewController.self))
        self.viewModel.view = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setUp() {
    let search = UISearchController(searchResultsController: nil)
    search.searchResultsUpdater = self
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = "Search hubs"
    navigationItem.searchController = search
    navigationItem.hidesSearchBarWhenScrolling = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(atIndex: indexPath.row)
    }

}

extension HubSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
            !query.isEmpty else { return }
        viewModel.search(query: query)
    }
}

extension HubSearchViewController: HubSearchViewType {
    func showResults(_ results: [String]) {
        self.results = results
    }
}
