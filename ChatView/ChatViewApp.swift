//
//  ChatApp.swift
//  ChatView
//
//  Created by Mike Piontek on 3/4/24.
//

import SwiftUI

@main
struct ChatApp: App {

    var body: some Scene {

		#if os(macOS)
		WindowGroup(id: "main") {
			ChatView()
		}
		.windowToolbarStyle(.unified)
		.defaultSize(width: 380, height: 480)
		#else
		WindowGroup(id: "main") {
			NavigationStack {
				ChatView()
			}
		}
		#endif
    }

}
