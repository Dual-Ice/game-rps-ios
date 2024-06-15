//
//  UIViewController+Preview.swift
//  rps-game-ios
//
//  Created by Дмитрий Лубов on 11.06.2024.
//

#if DEBUG
import SwiftUI

extension UIViewController {
	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController
		
		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}
		
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}
	
	func preview() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}
#endif
