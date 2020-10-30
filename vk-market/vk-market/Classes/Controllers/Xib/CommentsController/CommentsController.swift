//
//  CommentsController.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import MBProgressHUD

class CommentsController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var ownerId: Int
    private var itemId: Int
    
    var comments: [Comment] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    init(ownerId: Int, itemId: Int) {
        self.ownerId = ownerId
        self.itemId = itemId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        navigationItem.title = "Комментарии"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCommentCell.self)
        
        loadComments()
    }
    
    private func loadComments() {
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        VKManager.shared.getComments(ownerId: self.ownerId, itemId: self.itemId, offset: 0) { (comments, errorString) in
//            hud.hide(animated: true)
            self.comments = comments ?? []
        }
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

extension CommentsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserCommentCell
        cell.setupUI(comment: comment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
