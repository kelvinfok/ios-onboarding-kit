//
//  BottomView.swift
//  
//
//  Created by Kelvin Fok on 14/3/22.
//

import UIKit

class BottomView: UIView {
  
  var loginButtonDidTap: (() -> Void)?
  var imNewButtonDidTap: (() -> Void)?
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [loginButton, imNewButton])
    stackView.axis = .horizontal
    stackView.spacing = 24
    return stackView
  }()
  
  private lazy var loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Login", for: .normal)
    button.layer.borderColor = viewTintColor.cgColor
    button.layer.borderWidth = 2
    button.setTitleColor(viewTintColor, for: .normal)
    button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
    button.layer.cornerRadius = 12
    button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var imNewButton: UIButton = {
    let button = UIButton()
    button.setTitle("I'm new here", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
    button.backgroundColor = viewTintColor
    button.layer.cornerRadius = 12
    button.layer.shadowColor = viewTintColor.cgColor
    button.layer.shadowOpacity = 0.5
    button.layer.shadowOffset = .init(width: 4, height: 4)
    button.layer.shadowRadius = 8
    button.addTarget(self, action: #selector(imNewButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private let viewTintColor: UIColor
  
  init(tintColor: UIColor) {
    self.viewTintColor = tintColor
    super.init(frame: .zero)
    layoutView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutView() {
    addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
    }
    
    loginButton.snp.makeConstraints { make in
      make.width.equalTo(imNewButton.snp.width).multipliedBy(0.5)
    }
  }
  
  @objc private func loginButtonTapped() {
    loginButtonDidTap?()
  }
  
  @objc private func imNewButtonTapped() {
    imNewButtonDidTap?()
  }

}
