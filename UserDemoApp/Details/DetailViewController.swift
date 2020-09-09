//
//  DetailViewController.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 09/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var user:User? = nil
    
    let detailsLabel:UILabel = {
        let lable = UILabel()
        lable.text = "Details"
        lable.font = UIFont.boldSystemFont(ofSize: 26)
        lable.textColor = .black
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let userId:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16.0)
        lable.textColor = .gray
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let userDataType:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16.0)
        lable.textColor = .gray
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let date:UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.font = UIFont.systemFont(ofSize: 16.0)
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let userDataTxtView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16.0)
        textView.textColor = .darkGray
        textView.isSelectable = true
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let thumbnailImageView:UIImageView = {
        let iV = UIImageView()
        iV.layer.cornerRadius = 10
        iV.backgroundColor = .red
        iV.contentMode = .scaleToFill
        iV.clipsToBounds = true
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        configureView()
        
    }
    
    // MARK: - View setup
    
    func setUpViews(){
        guard let user = user else{return}

        
        if user.type == "image" {
            
            view.addSubview(detailsLabel)
            view.addSubview(thumbnailImageView)
            view.addSubview(userId)
            view.addSubview(userDataType)
            view.addSubview(date)
            
            let heightImg = view.bounds.height * 0.3
            NSLayoutConstraint.activate([
                
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            detailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            detailsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            thumbnailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thumbnailImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: heightImg),
            thumbnailImageView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 16),
            userId.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
            userId.leftAnchor.constraint(equalTo: thumbnailImageView.leftAnchor, constant: 0),
            userId.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0),
            userDataType.topAnchor.constraint(equalTo: userId.bottomAnchor, constant: 16),
            userDataType.leftAnchor.constraint(equalTo: userId.leftAnchor, constant: 0),
            userDataType.rightAnchor.constraint(equalTo: userId.rightAnchor, constant: 0),
            date.topAnchor.constraint(equalTo: userDataType.bottomAnchor, constant: 16),
            date.leftAnchor.constraint(equalTo: userId.leftAnchor, constant: 0),
            date.rightAnchor.constraint(equalTo: userId.rightAnchor, constant: 0),
                
            ])
            
        }else{
            
            view.addSubview(detailsLabel)
            view.addSubview(userDataTxtView)
            view.addSubview(userId)
            view.addSubview(userDataType)
            view.addSubview(date)
            
            NSLayoutConstraint.activate([
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            detailsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userId.leftAnchor.constraint(equalTo: detailsLabel.leftAnchor),
            userId.rightAnchor.constraint(equalTo: detailsLabel.rightAnchor),
            userId.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 25),
            userDataType.topAnchor.constraint(equalTo: userId.bottomAnchor, constant: 16),
            userDataType.leftAnchor.constraint(equalTo: userId.leftAnchor, constant: 0),
            userDataType.rightAnchor.constraint(equalTo: userId.rightAnchor, constant: 0),
            date.topAnchor.constraint(equalTo: userDataType.bottomAnchor, constant: 16),
            date.leftAnchor.constraint(equalTo: userId.leftAnchor, constant: 0),
            date.rightAnchor.constraint(equalTo: userId.rightAnchor, constant: 0),
            userDataTxtView.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 16),
            userDataTxtView.leftAnchor.constraint(equalTo: userId.leftAnchor, constant: 0),
            userDataTxtView.rightAnchor.constraint(equalTo: userId.rightAnchor, constant: 0),
            userDataTxtView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 16)
                
            ])
        }

    }
    
    // MARK: - Configure view with data 
    
    func configureView(){
        if let id = user?.id{
           userId.text = "Id : \(id)"
        }
        if let type = user?.type{
           userDataType.text = "Type : \(type)"
        }
        if let dateTxt = user?.date{
           date.text = "Date : \(dateTxt)"
        }
    
        if user?.type == "image"{
            if let imgUrl = user?.data{
               thumbnailImageView.sd_setImage(with: URL(string: imgUrl), completed: nil)
               thumbnailImageView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "default.png"))

            }
        }else{
            if let dataTxt = user?.data{
                userDataTxtView.text = dataTxt.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                   
        }
        

    }
}
