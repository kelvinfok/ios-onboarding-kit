//
//  TitleView.swift
//  
//
//  Created by Kelvin Fok on 14/3/22.
//

import UIKit
import SnapKit

class TitleView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    layoutView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArialRoundedMTBold", size: 28)
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.numberOfLines = 2
    label.textAlignment = .center
    return label
  }()
  
  func setTitle(text: String?) {
    titleLabel.text = text
  }
  
  private func layoutView() {
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(24)
      make.leading.equalTo(snp.leading).offset(36)
      make.trailing.equalTo(snp.trailing).offset(-36)
      make.bottom.equalTo(snp.bottom).offset(-36)
    }
  }
}

