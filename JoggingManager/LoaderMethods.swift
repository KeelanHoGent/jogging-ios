//
//  HelperMethods.swift
//  JoggingManager
//
//  Created by Keelan Savat on 28/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LoaderMethods {
    static func getStandardLoader() -> NVActivityIndicatorView {
        let loader = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1), padding: 0)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        return loader
    }
    
    static func startLoading(_ view: UIView, loader: NVActivityIndicatorView) {
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 50),
            loader.heightAnchor.constraint(equalToConstant: 50),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loader.startAnimating()
    }
    
    static func stopLoading(_ loader: NVActivityIndicatorView) {
        loader.stopAnimating()
    }
}
