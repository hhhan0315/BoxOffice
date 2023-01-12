//
//  ReviewViewController.swift
//  BoxOffice
//
//  Created by rae on 2023/01/10.
//

import UIKit

import ReactorKit

final class ReviewViewController: UIViewController, View {
    
    // MARK: - View Define
        
    private let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "별점"
        return label
    }()
        
    private let userNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        return label
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력해주세요."
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var userNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTitleLabel, userNameTextField])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요."
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTitleLabel, passwordTextField])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let textViewPlaceHolder = "내용을 입력해주세요."
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16.0)
        textView.text = textViewPlaceHolder
        textView.textColor = .lightGray
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        return textView
    }()
    
    // MARK: - Bind
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: ReviewReactor) {
        // Action
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe { _ in
                print("확인")
                // MovieCode를 가지고 리뷰 목록 저장 후 dismiss
            }
            .disposed(by: disposeBag)
        
        // State
        
        // View
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupViews()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        contentTextView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "리뷰 작성"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupUserNameStackView()
        setupPasswordStackView()
        setupContentTextView()
    }
    
    private func setupUserNameStackView() {
        userNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTitleLabel.widthAnchor.constraint(equalToConstant: 100.0),
        ])
        
        view.addSubview(userNameStackView)
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            userNameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            userNameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0)
        ])
    }
    
    private func setupPasswordStackView() {
        passwordTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTitleLabel.widthAnchor.constraint(equalToConstant: 100.0),
        ])
        
        view.addSubview(passwordStackView)
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 20.0),
            passwordStackView.leadingAnchor.constraint(equalTo: userNameStackView.leadingAnchor),
            passwordStackView.trailingAnchor.constraint(equalTo: userNameStackView.trailingAnchor)
        ])
    }
    
    private func setupContentTextView() {
        view.addSubview(contentTextView)
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 10.0),
            contentTextView.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: passwordStackView.trailingAnchor),
            contentTextView.heightAnchor.constraint(equalToConstant: 200.0)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension ReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            contentTextView.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

// MARK: - UITextViewDelegate

extension ReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = self.textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
}
