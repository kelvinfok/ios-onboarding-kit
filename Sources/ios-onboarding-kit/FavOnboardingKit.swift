
public protocol FavOnboardingKitDelegate: AnyObject {
  func loginButtonDidTap()
  func imNewButtonDidTap()
}

import UIKit

public class FavOnboardingKit {
  
  weak var delegate: FavOnboardingKitDelegate?
    
  private let slides: [Slide]
  private let tintColor: UIColor
        
  private lazy var viewController: OnboardingViewController = {
    let viewController = OnboardingViewController(slides: slides, tintColor: tintColor)
    viewController.modalTransitionStyle = .crossDissolve
    viewController.modalPresentationStyle = .fullScreen
    return viewController
  }()
  
  private lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.modalTransitionStyle = .crossDissolve
    navigationController.modalPresentationStyle = .fullScreen
    return navigationController
  }()
  
  private var parentVC: UIViewController?
  
  public init(slides: [Slide], tintColor: UIColor) {
    self.slides = slides
    self.tintColor = tintColor
  }
  
  public func launchOnboarding(parentVC: UIViewController, delegate: FavOnboardingKitDelegate) {
    self.delegate = delegate
    self.parentVC = parentVC
    viewController.imNewButtonDidTap = { [weak self] in
      self?.delegate?.imNewButtonDidTap()
    }
    viewController.loginButtonDidTap = { [weak self] in
      self?.delegate?.loginButtonDidTap()
    }
    parentVC.present(viewController, animated: true, completion: nil)
  }
  
  public func dismissOnboarding() {
    parentVC?.dismiss(animated: true, completion: nil)
  }
  
  public func presentViewController(viewController: UIViewController) {
    self.viewController.present(viewController, animated: true)
  }
  
}

public struct Slide {
  public let image: UIImage
  public let title: String
  
  public init(image: UIImage, title: String) {
    self.image = image
    self.title = title
  }
}
