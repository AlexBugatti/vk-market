//
//  ProfileController.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileController: UIViewController {

    private var products: [Product] = [] {
        didSet {
            self.tableView?.reloadData()
            self.descriptionLabel.text = "\(self.products.count) товара в избранном"
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = self.logoView.frame.height / 2
            self.logoView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadFavorites()
        loadUser()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.showSeparateView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProductTableCell.self)
        self.tableView.showSeparate()
    }
    
    private func loadUser() {
        VKManager.shared.getUserInfo { (user, errorString) in
            if let user = user {
                self.setupUI(user)
            }
        }
    }
    
    private func loadFavorites() {
        VKManager.shared.getFavoriteProducts { (products, errorString) in
            self.products = products
        }
    }
    
    private func setupUI(_ user: User) {
        self.navigationItem.title = "id\(user.id)"
        self.titleLabel.text = "\(user.firstName) \(user.lastName)"
        self.logoView.sd_setImage(with: URL(string: user.photo200), completed: nil)
    }
    
    private func showProduct(product: Product) {
        let vc = DetailProductController(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func logout() {
        let alert = UIAlertController.init(title: nil, message: "Вы действительно хотите выйти?", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            VKManager.shared.logout()
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        }
        let cancel = UIAlertAction.init(title: "Отмена", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARL: - Actions
    
    @IBAction func onDidLogoutTapped(_ sender: Any) {
        logout()
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

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ProductTableCell
        cell.setupUI(item: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = self.products[indexPath.row]
        self.showProduct(product: product)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}

