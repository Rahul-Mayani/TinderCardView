//
//  PeopleContentView.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 16/10/20.
//

import UIKit

class PeopleContentView: UIView {

    // MARK: - IBOutlet -
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var buttonsStackView: UIStackView!
        
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Variable -
    var user: PeopleModel? = nil {
        didSet {
            userImageView.setKingfisherImageView(image: user?.picture.medium ?? "", placeholder: "")
            
            nameLabel.text = user?.name.fullName ?? ""
            
            setButtonsView()
        }
    }
    
    // MARK: - Others -
    private func setButtonsView() {
        
        /// user info button
        let user = ButtonView.getLoadButtonFromNib()
        user.setUserButton()
        user.setSelectedView(true)
        user.actionButton.addTarget(self, action: #selector(tapAllButtons), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(user)
        
        /// calendar info button
        let calendar = ButtonView.getLoadButtonFromNib()
        calendar.setCalendarButton()
        calendar.setSelectedView()
        calendar.actionButton.addTarget(self, action: #selector(tapAllButtons), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(calendar)
        
        /// location info button
        let location = ButtonView.getLoadButtonFromNib()
        location.setLocationButton()
        location.setSelectedView()
        location.actionButton.addTarget(self, action: #selector(tapAllButtons), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(location)
        
        /// phone info button
        let phone = ButtonView.getLoadButtonFromNib()
        phone.setPhoneButton()
        phone.setSelectedView()
        phone.actionButton.addTarget(self, action: #selector(tapAllButtons), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(phone)
        
        /// security info button
        let security = ButtonView.getLoadButtonFromNib()
        security.setSecurityButton()
        security.setSelectedView()
        security.actionButton.addTarget(self, action: #selector(tapAllButtons), for: .touchUpInside)
        buttonsStackView.addArrangedSubview(security)
        
        /// default selection
        tapAllButtons(user.actionButton)
    }
    
    @objc
    func tapAllButtons(_ sender: UIButton) {
        
        for view in buttonsStackView.subviews {
            if let bView = view as? ButtonView {
                bView.setSelectedView()
            }
        }
        
        let bView = buttonsStackView.viewWithTag(sender.tag)?.superview as? ButtonView
        bView?.setSelectedView(true)
        
        let tag = ButtonEnum(rawValue: sender.tag)
        switch tag {
        case .user:
            infoLabel.text = user?.userBasicInfo ?? ""
        case .location:
            infoLabel.text = user?.location.address ?? ""
        case .phone:
            infoLabel.text = user?.userPhoneInfo ?? ""
        case .security:
            infoLabel.text = user?.login.security ?? ""
        case .calendar:
            infoLabel.text = user?.dob.dateAge ?? ""
        case .none:
            infoLabel.text = ""
        }
    }
}
