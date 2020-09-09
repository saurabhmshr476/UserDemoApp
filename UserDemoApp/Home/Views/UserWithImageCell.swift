//
//  UserWithImageCell.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 08/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - TableView Custom Cell

class UserWithImageCell: UITableViewCell {
    
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
    
    let thumbnailImageView:UIImageView = {
        let iV = UIImageView()
        iV.layer.cornerRadius = 10
        iV.contentMode = .scaleToFill
        iV.clipsToBounds = true
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
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
        addSubview(thumbnailImageView)
        
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))

        let viewsDictionary = [ "v0": thumbnailImageView,"v1": userId, "v2": userDataType, "v3": date]
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
        if let imgUrl = user.data{
           thumbnailImageView.sd_setImage(with: URL(string: imgUrl), completed: nil)
           thumbnailImageView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "default.png"))

        }
        
        
        
    }
}
