//
//  HomeViewController.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 08/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

class HomeViewController: UITableViewController {
    // MARK: - Properties
    
    var isSortedPressed = false
    let realm = RealmManager()
    var users = [User]()
    let cellId = "cellId"
    let cellId2 = "cellId2"

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getLocaldata()
        syncUserData()
    }
    
     // MARK: - Setup View
    
    func setUpView(){
        title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sort))
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UserWithImageCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId2)
        tableView.backgroundColor = .white

    }
    
    // MARK: - Sort Data
    @objc func sort(sender: UIBarButtonItem){
        if isSortedPressed{
            users = users.sorted(by: { ($0.type!) < ($1.type!) })
        }else{
            users = users.sorted(by: { ($0.type!) > ($1.type!) })
        }
        isSortedPressed = !isSortedPressed
        tableView.reloadData()

    }
    
    // MARK: - Get local data
    
    func getLocaldata(){
        if let usersData = realm.getObjects(type: User.self) {
            users = []
            for userData in usersData{
                if let user = userData as? User {
                    users.append(user)
                }
            }
            
            tableView.reloadData()
        }
    }
    // MARK: - Sync remote Data with local
    
    func syncUserData(){
        
        if users.count == 0{
            ProgressHUD.show("Loading")
        }
        
        tableView.separatorColor = UIColor.clear
        NetworkService.shared.getUsers {[weak self] (users, err) in
            
            if self?.users.count == 0{
                ProgressHUD.dismiss()
            }
            
            if let err = err {
                print("Failed to fetch courses:", err)

                return
            }
            self?.tableView.separatorColor = UIColor.gray
            self?.realm.saveObjects(objs: users ?? [])
            self?.users = users ?? []
            self?.getLocaldata()

        }
    }
   
}

// MARK: - TableView View DataSource

extension HomeViewController{
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
       }
    
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let user = users[indexPath.row]
        switch user.type {
        case "image":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserWithImageCell
            cell.configure(user: user)
            cell.selectionStyle = .none
            return cell
        case "text":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as! UserCell
            cell.configure(user: user)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
            
        }
       
           
       }
}

// MARK: - TableView View Delegate

extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.user = users[indexPath.row]
        showDetailViewController(detailVC, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let user = users[indexPath.row]
           switch user.type {
                case "image","text":
                    return UITableView.automaticDimension
                default:
                     return .leastNonzeroMagnitude // Handling unknown cases silently
           }
        
     
    }
}


