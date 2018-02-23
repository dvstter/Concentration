//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by 杨涵麟 on 23/02/2018.
//  Copyright © 2018 杨涵麟. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        
        return false
    }
    
    private let themes = ["Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸",
                  "Animals":"🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯",
                  "Faces":"😀😄😁😆😅😂🤣☺️😊😇"]

    @IBAction private func changeTheme(_ sender: Any) {
        if let cvc = splitViewConcentrationViewController {
            if let themeTitle = (sender as? UIButton)?.currentTitle, let theme = themes[themeTitle] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeTitle = (sender as? UIButton)?.currentTitle, let theme = themes[themeTitle] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewConcentrationViewController: ConcentrationViewController? {
        get {
            return splitViewController?.viewControllers.last as? ConcentrationViewController
        }
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeTitle = (sender as? UIButton)?.currentTitle, let theme = themes[themeTitle] {
                let cvc = (segue.destination as? ConcentrationViewController)!
                cvc.theme = theme
                lastSeguedToConcentrationViewController = cvc
            }
        }
    }
    
}
