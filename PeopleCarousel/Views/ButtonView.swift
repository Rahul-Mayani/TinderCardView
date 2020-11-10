//
//  ButtonView.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 16/10/20.
//

import UIKit

enum ButtonEnum: Int {
    case user = 1, phone, calendar, security, location
}

public class ButtonView: UIView {

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var actionButton: UIButton!
    
    func setSelectedView(_ isSelected: Bool = false) {
        
        actionButton.isSelected = isSelected
        
        if isSelected {
            selectedView.backgroundColor = UIColor.systemBlue
        } else {
            selectedView.backgroundColor = UIColor.clear
        }
    }
    
    class func getLoadButtonFromNib() -> ButtonView {
        let button = Bundle.main.loadNibNamed("ButtonView", owner: self, options: nil)?.first! as! ButtonView
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setUserButton() {
        actionButton.setImage(UIImage(systemName: "person"), for: .normal)
        actionButton.setImage(UIImage(systemName: "person.fill"), for: .selected)
        actionButton.tag = ButtonEnum.user.rawValue
    }
    
    func setPhoneButton() {
        actionButton.setImage(UIImage(systemName: "phone"), for: .normal)
        actionButton.setImage(UIImage(systemName: "phone.fill"), for: .selected)
        actionButton.tag = ButtonEnum.phone.rawValue
    }
    
    func setCalendarButton() {
        actionButton.setImage(UIImage(systemName: "scalemass"), for: .normal)
        actionButton.setImage(UIImage(systemName: "scalemass.fill"), for: .selected)
        actionButton.tag = ButtonEnum.calendar.rawValue
    }
    
    func setSecurityButton() {
        actionButton.setImage(UIImage(systemName: "lock"), for: .normal)
        actionButton.setImage(UIImage(systemName: "lock.fill"), for: .selected)
        actionButton.tag = ButtonEnum.security.rawValue
    }
    
    func setLocationButton() {
        actionButton.setImage(UIImage(systemName: "pin"), for: .normal)
        actionButton.setImage(UIImage(systemName: "pin.fill"), for: .selected)
        actionButton.tag = ButtonEnum.location.rawValue
    }
}
