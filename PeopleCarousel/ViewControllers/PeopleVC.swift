//
//  PeopleVC.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit
import Cartography
import RealmSwift

class PeopleVC: BaseVC {
    // MARK: - IBOutlet -
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Variable -
    /// interaction between view and model by listing view model
    private let peopleVM = PeopleVM()
    
    var swipeableView: ZLSwipeableView!
    
    var peopleData: Results<PeopleModel>?
    
    var peopleIndex = 0
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// for unit testing
        view.accessibilityIdentifier = RRViewController.Name.peopleVC
        
        /// reveived data update call back from view model class
        peopleVM.dataArray.distinctUntilChanged()
        .subscribe { [weak self] (result) in
            guard let self = self else { return }
            self.peopleData = result.element!
            self.setUpPeopleSwipeableView()
            self.peopleIndex = 0
            self.swipeableView.discardViews()
            self.swipeableView.loadViews()
        } => rxbag
        
        /// Get data from local DB or Server
        peopleVM.getDataFromLocalDBOrServer(true)
        
        /// set rx buttons action
        setupAllButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if swipeableView == nil {
            return
        }
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    // MARK: - Buttons Action -
    fileprivate func setupAllButton() {

        heartButton.rx.tap
        .debounce(.milliseconds(3), scheduler: RXScheduler.main)
        .bind{ [weak self] in
            guard let self = self else { return }
            if (self.peopleData?.count ?? 0) == 0 {
                return
            }
            self.setFavouriteData()
        } => rxbag
        
        resetButton.rx.tap
        .debounce(.milliseconds(3), scheduler: RXScheduler.main)
        .bind{ [weak self] in
            guard let self = self else { return }
            if (self.peopleData?.count ?? 0) == 0 {
                return
            }
            self.swipeableView.rewind()
            self.updatefavouriteButton()
        } => rxbag
    }
    
    // MARK: - Favourite Action -
    private func setFavouriteData() {
        let user: PeopleModel = peopleData![swipeableView.topView()?.tag ?? 0]
        peopleVM.updateFavouriteData(user)
        heartButton.isSelected.toggle()
    }
    
    private func updatefavouriteButton() {
        let user: PeopleModel = peopleData![swipeableView.topView()?.tag ?? 0]
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.heartButton.isSelected = user.isFavourite
        }
    }
}

// MARK: - People Swipeable View -
extension PeopleVC {
    
    private func setUpPeopleSwipeableView() {
        
        if swipeableView != nil {
            return
        }
        
        swipeableView = ZLSwipeableView()
        swipeableView.allowedDirection = [.None, .Left, .Right]
        view.addSubview(swipeableView)
        
        swipeableView.didSwipe = { [weak self] (view, direction, vector) in
            guard let self = self else { return }
            if direction == .Right {
                self.setFavouriteData()
                //self.swipeableView.rewind()
            }
            self.updatefavouriteButton()
        }

        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+50
            view1.right == view2.right-50
            view1.top == view2.top + 100
            view1.bottom == view2.bottom - 50
        }
    }
    
    private func nextCardView() -> UIView? {
        
        if peopleIndex >= peopleData!.count {
            peopleIndex = 0
        }

        let peopleView = PeopleView(frame: swipeableView.bounds)
        peopleView.backgroundColor = UIColor.white
        let user: PeopleModel = peopleData![peopleIndex]
        heartButton.isSelected = user.isFavourite
        peopleView.tag = peopleIndex
        
        peopleIndex += 1

        let contentView = Bundle.main.loadNibNamed("PeopleContentView", owner: self, options: nil)?.first! as! PeopleContentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = peopleView.backgroundColor
        contentView.user = user
        peopleView.addSubview(contentView)
       
        constrain(contentView, peopleView) { view1, view2 in
            view1.left == view2.left
            view1.top == view2.top
            view1.width == peopleView.bounds.width
            view1.height == peopleView.bounds.height
        }
        
        return peopleView
    }
}
