//
//  ActivityView.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/5/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

  let activityItems: [Any]
  let applicationActivities: [UIActivity]?

  init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
    self.activityItems = activityItems
    self.applicationActivities = applicationActivities
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
    UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
  }
}
