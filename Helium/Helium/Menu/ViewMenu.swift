//
//  ViewMenu.swift
//  Helium
//
//  Created by Jaden Geller on 5/14/20.
//  Copyright © 2020 Jaden Geller. All rights reserved.
//

import WebKit

struct ViewMenu: Menu {
    let isToolbarVisible = Binding(get: { UserSetting.toolbarVisibility == .visible }, set: { UserSetting.toolbarVisibility = $0 ? .visible : .hidden })
    let isTranslucencyEnabled = Binding(get: { UserSetting.translucencyEnabled }, set: { UserSetting.translucencyEnabled = $0 })
    let translucencyMode = Binding(get: { UserSetting.translucencyMode }, set: { UserSetting.translucencyMode = $0 })
    let opacityPercentage = Binding(get: { UserSetting.opacityPercentage }, set: { UserSetting.opacityPercentage = $0 })
    
    var body: Menu {
        List {
            Section {
                // FIXME: Switch is cleaner?
                Toggle("Toolbar", isOn: isToolbarVisible)
                    .toggleStyle(TitleToggleStyle.showHide)
                    // FIXME: This keyboard shortcut is ignored!
                    .keyboardShortcut(.command, "b")
                MenuButton("Translucency") {
                    Toggle("Enabled", isOn: isTranslucencyEnabled)
                        .keyboardShortcut(.command, "t")
                    MenuButton("Opacity") {
                        Picker(selection: opacityPercentage, stride(from: 0, to: 100, by: 10).map({ percentage in
                            (percentage, "\(percentage)%")
                        }))
                        // FIXME: Support keyboardShortcut for Picker
                        // .keyEquivalent(String(digit == 10 ? 0 : digit), with: .command)
                    }
                    Picker(selection: translucencyMode, [
                        .always: "Always",
                        .mouseOver: "Mouse Over",
                        .mouseOutside: "Mouse Outside"
                    ])
                }
            }
            Section {
                Button("Stop", action: #selector(WKWebView.stopLoading(_:)))
                    .keyboardShortcut(.command, ".")
                Button("Reload Page", action: #selector(WKWebView.reload(_:)))
                    .keyboardShortcut(.command, "r")
            }
            Section {
                Button("Actual Size", action: #selector(WebViewController.resetZoomLevel(_:)))
                    .keyboardShortcut(.command, "0")
                Button("Zoom In", action: #selector(WebViewController.zoomIn(_:)))
                    .keyboardShortcut(.command, "+")
                Button("Zoom Out", action: #selector(WebViewController.zoomOut(_:)))
                    .keyboardShortcut(.command, "-")
            }
        }
    }
}
