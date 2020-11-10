//
//  BaseVC.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseVC: UIViewController {
    
    // MARK: - Variable -
    // ARC managment by rxswift (deinit)
    let rxbag = DisposeBag()
    
    // MARK: - View Life Cycle -
    override open func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.white
                
        setNeedsStatusBarAppearanceUpdate()
        
        modalPresentationStyle = .fullScreen
        
        view.tintAdjustmentMode = .normal

        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Memory Release -
    deinit {
        print("Memory Release : \(String(describing: self))\n" )
    }
}
