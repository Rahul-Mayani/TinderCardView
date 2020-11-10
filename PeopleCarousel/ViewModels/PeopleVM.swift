//
//  PeopleVM.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class PeopleVM {
    
    // MARK: - Variable -
    
    /// people data array observe by rxswift
    var dataArray: PublishSubject<Results<PeopleModel>> = PublishSubject()
    
    /// ARC managment by rxswift (deinit)
    private let disposeBag = DisposeBag()
    
    // MARK: - Init -
    init() {
    }
}

// MARK: - Get Data -
extension PeopleVM {
    
    func getDataFromLocalDBOrServer(_ isAPICall: Bool = false, isOffline: Bool = true) {
        var isLoding = true
        var data: Results<PeopleModel>?
        if isOffline {
            data = appDelegate.realm!.objects(PeopleModel.self).filter("isFavourite == true")
        } else {
            data = appDelegate.realm!.objects(PeopleModel.self)
        }
        if (data?.count ?? 0) > 0 {
            // refresh table view and bind data
            dataArray.onNext(data!)
            isLoding = false
        }
        // Get data from server
        if isAPICall {
            getDataFromServer(isLoding)
        }
    }
}

// MARK: - update favourite people -
extension PeopleVM {
    
    func updateFavouriteData(_ data: PeopleModel) {
        PeopleModel.updateFavourite(data)
    }
}

// MARK: - API -
private extension PeopleVM {
    // get data from server by rxswift with alamofire
    func getDataFromServer(_ isLoading: Bool = false) {
        
        RRAPIManager.shared.setURL(RRAPIEndPoint.Name.listOfPeople)
        .showIndicator(isLoading)
        .setDeferredAsObservable()
        .subscribeConcurrentBackgroundToMainThreads()
        .subscribe(onNext: { [weak self] (response) in
            print(response)
            guard let self = self else { return }
            guard let results = (response as? [String: Any])?["results"] as? [[String: Any]] else { return }
            do {
                _ = try PeopleModel.create(from: results)
                self.getDataFromLocalDBOrServer(isOffline: false)
            } catch {
                UIAlertController.showAlert(title: nil, message: error.localizedDescription)
            }
        }, onError: { (error) in
            UIAlertController.showAlert(title: nil, message: error.localizedDescription)
        }) => disposeBag
    }
}
