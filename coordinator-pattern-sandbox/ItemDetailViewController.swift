//
//  ItemDetailViewController.swift
//  coordinator-pattern-sandbox
//
//  Created by hrfm mr on 2021/01/24.
//

import UIKit

final class ItemDetailViewController: UIViewController {
    private let item: Item

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = .init(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        title = item.value
    }
}
