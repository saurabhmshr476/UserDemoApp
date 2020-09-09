//
//  UserCell.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 08/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import UIKit

//MARK: - TableView Custom Cell

class UserCell: UITableViewCell {

     //MARK: - Properties
    
     let userId:UILabel = {
           let lable = UILabel()
           lable.font = UIFont.systemFont(ofSize: 14.0)
           lable.textColor = .gray
           lable.numberOfLines = 0
           lable.translatesAutoresizingMaskIntoConstraints = false
           return lable
       }()
       
       let userDataType:UILabel = {
           let lable = UILabel()
           lable.font = UIFont.systemFont(ofSize: 14.0)
           lable.textColor = .gray
           lable.numberOfLines = 0
           lable.translatesAutoresizingMaskIntoConstraints = false
           return lable
       }()
       
       let date:UILabel = {
           let lable = UILabel()
           lable.numberOfLines = 0
           lable.font = UIFont.systemFont(ofSize: 12.0)
           lable.textColor = .gray
           lable.translatesAutoresizingMaskIntoConstraints = false
           return lable
       }()
       
       let userData:UILabel = {
           let lable = UILabel()
           lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = .darkGray
           lable.numberOfLines = 4
           lable.translatesAutoresizingMaskIntoConstraints = false
           return lable
       }()
       
       
    //MARK: - initializer
    
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setUpViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    //MARK: - View Setup
    
       func setUpViews(){
           addSubview(userId)
           addSubview(userDataType)
           addSubview(date)
           addSubview(userData)


           let viewsDictionary = [ "v0": userData,"v1": userId, "v2": userDataType, "v3": date]
           for view in viewsDictionary.keys {
               addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[\(view)]-16-|", options: [], metrics: nil, views: viewsDictionary))
           }
           addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-8-[v1]-8-[v2]-8-[v3]-10-|", options: [], metrics: nil, views: viewsDictionary))

       }
    
    //MARK: - Bind data on cell
    
    func configure(user:User){
        
        if let id = user.id{
           userId.text = "Id : \(id)"
        }
        if let type = user.type{
           userDataType.text = "Type : \(type)"
        }
        if let dateTxt = user.date{
           date.text = "Date : \(dateTxt)"
        }
        if let dataTxt = user.data{
           userData.text = dataTxt.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        
        
        
    }
}
