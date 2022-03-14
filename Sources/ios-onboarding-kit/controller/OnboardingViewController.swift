//
//  OnboardingViewController.swift
//  
//
//  Created by Kelvin Fok on 14/3/22.
//

import UIKit

class OnboardingViewController: UIViewController {
  
  var loginButtonDidTap: (() -> Void)?
  var imNewButtonDidTap: (() -> Void)?
  
  private lazy var transitionView: TransitionView = {
    let view = TransitionView(
      slides: slides,
      barColor: tintColor)
    return view
  }()
  
  private lazy var bottomView: BottomView = {
    let view = BottomView(tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
    view.loginButtonDidTap = loginButtonDidTap
    view.imNewButtonDidTap = imNewButtonDidTap
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [
      transitionView, bottomView])
    view.axis = .vertical
    return view
  }()
  
  private let slides: [Slide]
  private let tintColor: UIColor
  
  init(slides: [Slide], tintColor: UIColor) {
    self.slides = slides
    self.tintColor = tintColor
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupGesture()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    transitionView.start()
  }
  
  private func setupView() {
    view.backgroundColor = .white
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }
    
    bottomView.snp.makeConstraints { make in
      make.height.equalTo(120)
    }
  }
  
  private func setupGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
    transitionView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func viewDidTap(_ tap: UITapGestureRecognizer) {
    let point = tap.location(in: view)
    let midPoint = view.frame.size.width / 2
    if point.x > midPoint {
      transitionView.handleTap(direction: .right)
    } else {
      transitionView.handleTap(direction: .left)
    }
  }
}

