//
//  AppReducer+Catemoji.swift
//  Alfheim
//
//  Created by alex.huo on 2020/5/2.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension AppReducer {
  enum Catemoji {
    static func reduce(state: AppState, action: AppAction.Catemoji) -> (AppState, AppCommand?) {
      var appState = state
      var appCommand: AppCommand? = nil

      switch action {
      case .updated(let catemojis):
        appState.catemoji.catemojis = catemojis
        appState.editor.catemojis = catemojis.grouped(by: { $0.category })
      case .toggleAddCatemoji(let presenting):
        appState.catemoji.isAlertPresented = presenting
      case .added(let catemoji):
        appCommand = AppCommands.CreateCatemojiCommand(catemoji: catemoji)
      case .deleted(let catemoji):
        appCommand = AppCommands.DeleteCatemojiCommand(catemojis: [catemoji])
      }

      return (appState, appCommand)
    }
  }
}
