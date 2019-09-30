//
//  ScrollView.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/27/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class ScrollView: UIViewController {
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = UIColor.red
        return scroll
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.widthAnchor.constraint(equalTo: view.widthAnchor),
            scroll.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }
}
