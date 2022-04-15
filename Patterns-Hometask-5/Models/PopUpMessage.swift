//
//  PopUpMessage.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 12.04.2022.
// Line added for pull request

import UIKit

class PopUpMessage {
    
    func popUpMessage(_ handler: @escaping (String) -> Void) {
        let popUp = UIAlertController(title: "Add new task", message: "Input title for a new task. So far only one task is hardcoded!", preferredStyle: .alert)
        popUp.addTextField() { textField in
            textField.placeholder = "Input title for a new task"
        }
        popUp.addAction(UIAlertAction(title: "Add", style: .default) { [unowned popUp] _ in handler(popUp.textFields![0].text ?? "") })
        popUp.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        showPopUp(popUp: popUp)
    }
    
    func showPopUp(popUp: UIAlertController) {
        if let controller = firstLevelViewController() {
            controller.present(popUp, animated: true)
        }
    }
    
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }
    
    private func firstLevelViewController() -> UIViewController? {
        guard let baseController = keyWindow()?.rootViewController else {
            return nil
        }
        return firstLevelViewController(for: baseController)
    }
    
    private func firstLevelViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return firstLevelViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return firstLevelViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return firstLevelViewController(for: topController)
        }
        return controller
    }
}
