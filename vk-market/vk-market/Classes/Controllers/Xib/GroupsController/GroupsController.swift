//
//  GroupsController.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class GroupsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var subcategory: Subcategory
    private var groups: [Group] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    init(subcategory: Subcategory) {
        self.subcategory = subcategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadGroups()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationItem.title = self.subcategory.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(GroupCell.self)
    }
    
    func loadGroups() {
        VKManager.shared.getGroups(categoryId: 11, subcategoryId: subcategory.id) { (groups, errorString) in
            self.groups = groups ?? []
        }
    }

    func showProducts(group: Group) {
        let vc = ProductsController(requestParameters: group)
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

extension GroupsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = self.groups[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GroupCell
        cell.setupUI(group)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let group = self.groups[indexPath.row]
        self.showProducts(group: group)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
