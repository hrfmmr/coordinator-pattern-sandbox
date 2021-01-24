//
//  ItemListViewController.swift
//  coordinator-pattern-sandbox
//
//  Created by hrfm mr on 2021/01/24.
//

import UIKit

protocol ItemListViewControllerDelefgate: AnyObject {
    func itemListViewController(_ viewController: ItemListViewController, didSelect item: Item)
}

struct Item {
    let value: String
}

final class ItemListViewController: UIViewController {
    weak var delegate: ItemListViewControllerDelefgate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    private lazy var items: [Item] = {
        return [
            Item(value: "a"),
            Item(value: "b"),
            Item(value: "c")
        ]
    }()

    override func loadView() {
        view = .init(frame: UIScreen.main.bounds)
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension ItemListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.value
        return cell
    }
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.itemListViewController(self, didSelect: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
