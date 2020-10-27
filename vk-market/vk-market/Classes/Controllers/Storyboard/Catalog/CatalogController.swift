//
//  CatalogController.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class CatalogController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var subcategories: [Subcategory] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadBrands()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationItem.title = "Каталог"
        self.navigationController?.navigationBar.showSeparateView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func loadBrands() {
        self.subcategories = Storage.subcategories
    }
    
    private func showProducts(subcategory: Subcategory) {
        let vc = GroupsController(subcategory: subcategory)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CatalogController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subcategory = self.subcategories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subcategory.name
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subcategory = self.subcategories[indexPath.row]
        self.showProducts(subcategory: subcategory)
        
    }
    
}
