//
//  ReviewReactor.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import Foundation

import ReactorKit

final class ReviewReactor: Reactor {
    enum Action {
        case inputUserName(String)
        case inputPassword(String)
        case inputContent(String)
    }
    
    enum Mutation {
        case setUserName(String)
        case setPassword(String)
        case setContent(String)
    }
    
    struct State {
        var userName: String = ""
        var userNameValid: Bool = false
        var password: String = ""
        var passwordValid: Bool = false
        var content: String = ""
        var contentValid: Bool = false
        
        var submitValid: Bool = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputUserName(let userName):
            return Observable.just(.setUserName(userName))
        case .inputPassword(let password):
            return Observable.just(.setPassword(password))
        case .inputContent(let content):
            return Observable.just(.setContent(content))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUserName(let userName):
            newState.userName = userName
            newState.userNameValid = userName.isEmpty ? false : true
        case .setPassword(let password):
            newState.password = password
            newState.passwordValid = self.isPasswordValidate(with: password)
        case .setContent(let content):
            newState.content = content
            newState.contentValid = content.isEmpty ? false : true
        }
        
        newState.submitValid = newState.userNameValid && newState.passwordValid && newState.contentValid
        
        return newState
    }
    
    private func isPasswordValidate(with password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$]).{6,20}$"
        return password.range(of: passwordRegex, options: .regularExpression) != nil
    }
}
