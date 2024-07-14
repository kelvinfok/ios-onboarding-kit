//
//  TransitionView.swift
//  
//
//  Created by Kelvin Fok on 14/3/22.
//

import UIKit

class TransitionView: UIView {
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.image = slides.first?.image
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private var timer: DispatchSourceTimer?
  
  private lazy var barViews: [AnimatedBarView] = {
    var views: [AnimatedBarView] = []
    slides.forEach { _ in
      views.append(AnimatedBarView(barColor: barColor))
    }
    return views
  }()
  
  private lazy var barStackView: UIStackView = {
    let view = UIStackView()
    barViews.forEach { barView in
      view.addArrangedSubview(barView)
    }
    view.axis = .horizontal
    view.spacing = 8
    view.distribution = .fillEqually
    return view
  }()
  
  private lazy var titleView: TitleView = {
    let view = TitleView()
    view.setTitle(text: slides.first?.title)
    return view
  }()
  
  private lazy var containerStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [imageView, titleView])
    stackView.distribution = .fill
    stackView.axis = .vertical
    return stackView
  }()
  
  private let slides: [Slide]
  private let barColor: UIColor
  private let slideDurationInSeconds: Int
  private var index: Int = -1
  
  init(
    slides: [Slide],
    barColor: UIColor,
    slideDurationInSeconds: Int
  ) {
    self.slides = slides
    self.barColor = barColor
    self.slideDurationInSeconds = slideDurationInSeconds
    super.init(frame: .zero)
    layoutView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutView() {
    addSubview(containerStackView)
    addSubview(barStackView)
    
    containerStackView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }
    
    imageView.snp.makeConstraints { make in
      make.height.equalTo(containerStackView.snp.height).multipliedBy(0.8)
    }
    
    barStackView.snp.makeConstraints { make in
      make.leading.equalTo(snp.leading).offset(24)
      make.trailing.equalTo(snp.trailing).offset(-24)
      make.top.equalTo(snp.topMargin)
      make.height.equalTo(4)
    }
  }
  
  func start() {
    buildTimerIfNeeded()
    timer?.resume()
  }
  
  func stop() {
    timer?.cancel()
  }
  
  private func buildTimerIfNeeded() {
    guard timer == nil else { return }
    timer = DispatchSource.makeTimerSource()
    timer?.schedule(deadline: .now(), repeating: .seconds(slideDurationInSeconds), leeway: .seconds(1))
    timer?.setEventHandler {
      DispatchQueue.main.async { [unowned self] in
        self.transit()
      }
    }
  }
  
  private func transit() {
    let nextImage: UIImage
    let nextBarView: AnimatedBarView
    let title: String
    
    if slides.indices.contains(index + 1) {
      nextImage = slides[index + 1].image
      nextBarView = barViews[index + 1]
      title = slides[index + 1].title
      index += 1
    } else {
      barViews.forEach({ $0.reset() })
      nextImage = slides[0].image
      title = slides[0].title
      nextBarView = barViews[0]
      index = 0
    }
    
    UIView.transition(
      with: imageView,
      duration: 0.5,
      options: .transitionCrossDissolve,
      animations: { [unowned self] in
        self.imageView.image = nextImage
      },
      completion: nil)
    
    nextBarView.startAnimating()
    titleView.setTitle(text: title)
  }
  
  func handleTap(direction: Direction) {
    switch direction {
    case .left:
      barViews[index].reset()
      if barViews.indices.contains(index - 1) {
        barViews[index - 1].reset()
      }
      index -= 2
      timer?.cancel()
      timer = nil
      start()
    case .right:
      barViews[index].complete()
      timer?.cancel()
      timer = nil
      start()
    }
  }

}

