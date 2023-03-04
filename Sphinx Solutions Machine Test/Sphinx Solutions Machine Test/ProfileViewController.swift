//
//  ProfileViewController.swift
//  Sphinx Solutions Machine Test
//
//  Created by Admin on 04/03/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setLabel()
        
    }
    private func setImage(){
        imageBackgroundView.layer.cornerRadius = 25
        personImageView.layer.cornerRadius = 100
        personImageView.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 1, alpha: 1)
        personImageView.layer.borderWidth = 2
    }
   
    private func setLabel(){
        labelBackgroundView.layer.cornerRadius = 25
        nameLabel.text = "Lokhande Vivek Bhalchandra"
        numberLabel.text = "8421304231"
    }

}
