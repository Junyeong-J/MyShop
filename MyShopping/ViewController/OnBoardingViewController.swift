//
//  OnBoardingViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    
    let deviceWidth = UIScreen.main.bounds.size.width
    
    let startButton = PointButton(title: "시작하기")
    let mainPosterImageView = MainPosterImageView()
    let appTitleLabel = AppTitleLabel(title: "MeaningOut")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureUI()
        
        addTargets()
    }
    
   
}

extension OnBoardingViewController {
    
    func configureHierarchy() {
        view.addSubview(startButton)
        view.addSubview(mainPosterImageView)
        view.addSubview(appTitleLabel)
    }
    
    func configureLayout() {
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        mainPosterImageView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(deviceWidth - 80)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainPosterImageView.snp.top).offset(-20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    func configureUI() {
        view.backgroundColor = Color.white
    }
    
    func addTargets() {
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = NicknameViewController()
        vc.viewtype = .new
        navigationController?.pushViewController(vc, animated: true)
    }
}
