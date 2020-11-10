//
//  RRAPIManager.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

public class RRAPIManager: NSObject, ObservableType {
    
    /// `Singleton` variable of API class
    static var shared = RRAPIManager()
    
    // MARK: Types
    
    /// The response of data type.
    public typealias Element = Any
    
    // MARK: - Properties
    
    /// `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    private(set) var apiUrl: String?
    
    /// `HTTPMethod` for the `URLRequest`. `.get` by default..
    private(set) var httpMethod: HTTPMethod = .get
    
    /// `Param` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` by default..
    private(set) var param: [String: Any]?
    
    /// The custom loading indicator shows while getting the response from the server. `hide` by default..
    private(set) var showingIndicator: Bool = false
     
    // MARK: - Initializer
    
    /// Set url
    ///
    /// - Parameter apiUrl: URL to set for api request
    /// - Returns: Self
    public func setURL(_ url: String) -> Self {
        self.apiUrl = url
        return self
    }
    
    /// Set httpMethod
    ///
    /// - Parameter httpMethod: to change as get, post, put, delete etc..
    /// - Returns: Self
    public func setHttpMethod(_ httpMethod: HTTPMethod) -> Self {
        self.httpMethod = httpMethod
        return self
    }
    
    /// Set param
    ///
    /// - Parameter param: a dictionary of parameters to apply to a `URLRequest`.
    /// - Returns: Self
    public func setParameter(_ param: [String: Any]) -> Self {
        self.param = param
        return self
    }
    
    /// Set indicator
    ///
    /// - Parameter indicator: to show / hide.`show` by default..
    /// - Returns: Self
    public func showIndicator(_ isLoader: Bool = true) -> Self {
        self.showingIndicator = isLoader
        return self
    }
    
    /// Get observable
    /// The Defer operator waits until an observer subscribes to it, and then it generates an Observable,
    /// typically with an Observable factory function. It does this afresh for each subscriber, so although each subscriber may think it is subscribing to the same Observable,
    /// in fact each subscriber gets its own individual sequence.
    /// Default implementation of converting `ObservableType` to `Observable`.
    /*public func setDeferredAsObservable() -> Observable<Element> {
        return Observable.deferred {
            return self.asObservable()
        }
    }*/
    
    /// `Session` creates and manages Alamofire's `Request` types during their lifetimes. It also provides common
    /// functionality for all `Request`s, including queuing, interception, trust management, redirect handling, and response
    /// cache handling.
    private var manager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1200.0
        return Alamofire.Session(configuration: configuration)
    }()
    
    /// `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default..
    private func header(url: String = "") -> HTTPHeaders {
        var header = HTTPHeaders()
        header["Content-Type"] = "application/json"
        /*
        // API
        if let token = Preference.fetch(.accessToken) as? String{
            header["Authorization"] = "Bearer" + " " + token
        }*/
        return header
    }
    
    /// The parameter encoding. `URLEncoding.default` by default.
    private func encoding(_ httpMethod: HTTPMethod) -> ParameterEncoding {
        var encoding: ParameterEncoding = JSONEncoding.default
        if httpMethod == .get{
            encoding = URLEncoding.default
        }
        return encoding
    }
    
    /// Subscription for `observer` that can be used to cancel production of sequence elements and free resources.
    public func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer: ObserverType, Element == Observer.Element {
        
        if showingIndicator {
            RRLoader.startLoaderToAnimating()
        }
        
        let url = apiUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        /// Creates a `DataRequest` from a `URLRequest`.
        /// Responsible for creating and managing `Request` objects, as well as their underlying `NSURLSession`.
        let task = self.manager.request(url,
                                        method: httpMethod,
                                        parameters: param,
                                        encoding: self.encoding(httpMethod),
                                        headers: self.header(url: url))
            .responseJSON { (response) in
            
            if self.showingIndicator {
                RRLoader.stopLoaderToAnimating()
            }
                
            if response.response?.statusCode == RRHTTPStatusCode.unauthorized.rawValue {
                //RRLogout.logout()
                observer.onError(RRError.unauthorized)
                //observer.onCompleted()
                return
            }
                
            switch response.result {
            case .success :
                observer.onNext(response.value as Element)
                observer.onCompleted()
            case .failure(let error):
                if error.isSessionTaskError {
                    observer.onError(RRError.noInternetConnection)
                } else {
                    observer.onError(error)
                }
            }
        }
        
        task.resume()
        
        // cURL Request Output
        debugPrint(" cURL Request ")
        debugPrint(task)
        debugPrint("")
        
        return Disposables.create { task.cancel() }
    }
}
