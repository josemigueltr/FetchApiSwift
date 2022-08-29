//
//  FetchApiPresenter.swift
//  fectchApiExample
//
//  Created by miguel toledo on 28/08/22.
//

import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func presentUser(user:UserData)
    func enableGetUserButton(flag:Bool)
}

typealias PresenterDelegate = ViewDelegate & UIViewController

class ClientPresenter {
    
    weak var delegate: PresenterDelegate?
    
    
    public func getUser() {
        delegate?.enableGetUserButton(flag: false)
               guard let url = URL(string: "https://randomuser.me/api/") else { return }
               let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                   self?.delegate?.enableGetUserButton(flag: true)
                   if let error = error {
                       print("No se pudo realizar la peticion \(error.localizedDescription)")
                   } else {
                       guard let data = data else {
                           return
                       }
                       do {
                           let response = try JSONDecoder().decode(Response.self, from: data)
                           let users=response.results
                           let userData=self?.createUserData(user: users)
                           self?.delegate?.presentUser(user: userData!)
                       } catch {
                           print("Hubo un error en el decode \(error)")
                       }
                   }
               }
               task.resume()
     
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    private func createUserData(user: [User]) -> UserData{
        //Sug implementar patron builder
        let u=user[0]
        let userData=UserData(name: "\(u.name.first) \(u.name.last) ", gender: "\(u.gender)", age: "\(u.dob.age)", country:"\(u.location.country)" , email: "\(u.email)", phone: "\(u.phone)", uuid: "\(u.login.uuid)", username: "\(u.login.username)", password: "\(u.login.password)", image: "\(u.picture.medium)")
        return userData
        
    }
    
}
