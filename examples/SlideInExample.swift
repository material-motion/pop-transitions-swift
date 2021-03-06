/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit
import MaterialMotionTransitions
import MaterialMotionPopTransitions

public class SlideInViewController: UIViewController {
  init() {
    super.init(nibName: nil, bundle: nil)
    title = "Slide in transition"
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
  }

  func didTap() {
    if presentingViewController == nil {
      let viewController = SlideInViewController()
      viewController.mdm_transitionController.directorClass = SlideInTransitionDirector.self
      present(viewController, animated: true)
      viewController.view.backgroundColor = .blue
    } else {
      dismiss(animated: true)
    }
  }
}

private class SlideInTransitionDirector: NSObject, TransitionDirector {

  let transition: Transition
  required init(transition: Transition) {
    self.transition = transition
  }

  func setUp() {
    let midY = Double(transition.foreViewController.view.layer.position.y)
    let height = Double(transition.foreViewController.view.bounds.height)
    let slide = TransitionSpring("position.y",
                                 transition: transition,
                                 back: NSNumber(value: midY + height),
                                 fore: NSNumber(value: midY))
    transition.runtime.addPlan(slide, to: transition.foreViewController.view.layer)
  }
}
