//
//  APIManager.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 25/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

final class APIManager {
    
    private init() {}
    
    static let shared = APIManager()
    
    private func serverSideErrors(response: HTTPURLResponse, data: Data) -> String? {
        if response.statusCode == 200 {
            return nil
        } else {
            return API_ERROR
        }
    }
    
    private func addHeaders(to request: URLRequest) -> URLRequest {
        var requestWithHeaders = request
        requestWithHeaders.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestWithHeaders.setValue("application/json", forHTTPHeaderField: "Accept")
        return requestWithHeaders
    }
    
    private func fetchResponse<Decode: Decodable>(from request: URLRequest, viewController: UIViewController, showLoader: Bool, responseType: Decode.Type, session: URLSession, success: @escaping (Decode) -> Void, failure: @escaping (String) -> Void) {
        
        if Utility.shared.isInternetAvailable() {
            
            if showLoader {
                Utility.shared.showHUDLoader()
            }
            
            session.dataTask(with: request) { (data, response, error) in
                
                Utility.shared.hideHUDLoader()
                
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    failure(SERVER_ERROR_MESSAGE)
                    return
                }
                
                do {
                    
                    if let errorMessage = self.serverSideErrors(response: response, data: data) {
                        failure(errorMessage)
                        return
                    }
                    
                    let decodedJson = try JSONDecoder().decode(responseType.self, from: data)
                    success(decodedJson)
                    
                } catch let error {
                    print(error)
                    failure(API_ERROR)
                }
                
                }.resume()
        } else {
            failure(NO_INTERNET_AVAILABLE)
        }
    }
    
    final func getRequest<Decode: Decodable>(url: String, viewController: UIViewController, showLoader: Bool, for responseType: Decode.Type, success: @escaping (Decode) -> Void, failure: @escaping (String) -> Void) {
        
        guard let url = URL(string: BASE_URL + url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request = addHeaders(to: request)
       
        fetchResponse(from: request, viewController: viewController, showLoader: showLoader, responseType: responseType, session: URLSession(configuration: URLSessionConfiguration.default), success: { (response) in
            success(response)
        }) { (errorMsg) in
            failure(errorMsg)
        }
        
    }
    
}

