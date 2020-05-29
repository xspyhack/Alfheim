//
//  ShareViewController.swift
//  Share
//
//  Created by bl4ckra1sond3tre on 2020/5/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

  @IBOutlet weak var alertView: UIView!
  @IBOutlet weak var backgroundView: UIView!

  private var fileHash: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    alertView.layer.cornerRadius = 10.0

    guard let item = self.extensionContext?.inputItems.first as? NSExtensionItem,
      let itemProvider = item.attachments?.first,
      itemProvider.hasItemConformingToTypeIdentifier(kUTTypeFileURL as String)
        else {
            return
    }
    itemProvider.loadItem(forTypeIdentifier: String(kUTTypeFileURL), options: nil) { item, error in
      guard let fileURL = item as? URL, fileURL.isFileURL else {
        return
      }

      guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.xspyhack.Alfheim") else {
        return
      }

      let directory = container.appendingPathComponent("shared", isDirectory: true)
      if !FileManager.default.fileExists(atPath: directory.path, isDirectory: nil) {
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
      }

      let hash = UUID().uuidString
      let destURL = directory.appendingPathComponent(hash, isDirectory: false)
      try? FileManager.default.moveItem(at: fileURL, to: destURL)
      self.fileHash = hash

      DispatchQueue.main.async {
        UIView.animate(withDuration: 0.5, animations: {
          self.backgroundView.alpha = 0.5
          self.alertView.alpha = 1.0
        }, completion: { _ in
          self.perform(#selector(self.finish), with: nil, afterDelay: 2.3)
        })
      }
    }
  }

  @objc
  private func finish() {
    extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
  }

  private func openIn() {
    guard let url = URL(string: "alfheim://share/\(self.fileHash ?? "")") else {
      return
    }

    extensionContext?.open(url) { [weak self] finished in
      self?.finish()
    }
  }
}
