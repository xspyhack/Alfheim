//
//  OverviewView.swift
//  Alfheim
//
//  Created by alex.huo on 2020/1/21.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
  @State private var showModel: Bool = false

  #if targetEnvironment(macCatalyst)
  var body: some View {
      SplitView()
  }
  #else
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 24) {
            ZStack(alignment: .center) {
              RoundedRectangle(cornerRadius: 20)
                .fill(Color.yellow)
                .shadow(radius: 8)

              ZStack {
                VStack {
                  HStack {
                    VStack(alignment: .leading, spacing: 6) {
                      Text("Expences").font(.system(size: 20, weight: .medium))
                      Text("weekly").font(.callout).foregroundColor(.gray)
                    }
                    Spacer()
                  }
                  Spacer()
                }
                .padding([.leading, .top])

                Text("$2333.33").font(.system(size: 36, weight: .semibold))
              }
            }
            .frame(width: nil, height: geometry.size.width*9/16, alignment: .center)
          }
          .padding(20)
        }
      }
      .navigationBarTitle("Journals")
      .navigationBarItems(trailing:
        Button(action: {
          self.showModel.toggle()
        }) {
          Text("New Transaction").bold()
        }.sheet(isPresented: $showModel) {
          EditorView()
        }
      )
    }
  }
  #endif
}

struct SplitView: View {
  var body: some View {
    Text("Hello split view")
  }
}

#if DEBUG
struct OverviewView_Previews: PreviewProvider {
  static var previews: some View {
    OverviewView().environment(\.colorScheme, .dark)
  }
}
#endif
