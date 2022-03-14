//
//  File.swift
//  
//
//  Created by Kelvin Fok on 14/3/22.
//

import UIKit
import Combine

class AnimatedBarView: UIView {
  
  enum State {
    case clear
    case animating
    case filled
  }
  
  @Published private var state: State = .clear
  
  private var subscribers = Set<AnyCancellable>()
  
  private lazy var backgroundBarView: UIView = {
    let view = UIView()
    view.backgroundColor = barColor.withAlphaComponent(0.2)
    view.clipsToBounds = true
    return view
  }()
  
  private lazy var foregroundBarView: UIView = {
    let view = UIView()
    view.backgroundColor = barColor
    view.alpha = 0.0
    return view
  }()
  
  private let barColor: UIColor
  private var animator: UIViewPropertyAnimator!
  
  init(barColor: UIColor) {
    self.barColor = barColor
    super.init(frame: .zero)
    layoutView()
    setupAnimation()
    observe()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutView() {
    addSubview(backgroundBarView)
    backgroundBarView.addSubview(foregroundBarView)
    
    backgroundBarView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }
    
    foregroundBarView.snp.makeConstraints { make in
      make.edges.equalTo(backgroundBarView)
    }
  }
  
  private func setupAnimation() {
    animator = UIViewPropertyAnimator(
      duration: 3.0,
      curve: .easeInOut,
      animations: { [unowned self] in
        self.foregroundBarView.transform = .identity
    })
  }
  
  private func observe() {
    $state.sink { [unowned self] state in
      switch state {
      case .clear:
        setupAnimation()
        self.foregroundBarView.alpha = 0.0
        self.animator.stopAnimation(false)
      case .animating:
        self.foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
        self.foregroundBarView.transform = .init(translationX: -frame.size.width, y: 0)
        self.foregroundBarView.alpha = 1.0
        self.animator.startAnimation()
      case .filled:
        self.animator.stopAnimation(true)
        self.foregroundBarView.transform = .identity
      }
    }.store(in: &subscribers)
  }
  
  func startAnimating() {
    state = .animating
  }
  
  func reset() {
    state = .clear
  }
  
  func complete() {
    state = .filled
  }
  
}

