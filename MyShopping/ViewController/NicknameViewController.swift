//
//  NicknameViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit
import SnapKit

class NicknameViewController: UIViewController {
    
    var randomImageName = ""
    var viewtype: ViewType = .new
    
    let cameraButton = CameraImage()
    lazy var profileImageView = ProfileImage(profile: randomImageName, corner: 50)
    let textField = NicknameTextField(style: .nickname)
    let lineView = UIView()
    let stateLabel = UILabel()
    let successButton = PointButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        randomImage()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        tapGesture()
        addTargets()
        
        textField.delegate = self
        
        setView()
    }
    
    
    
}

extension NicknameViewController {
    
    func makeNavigationUI() {
        navigationController?.isNavigationBarHidden = false
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = "PROFILE SETTING"
    }
    
    func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(textField)
        view.addSubview(lineView)
        view.addSubview(stateLabel)
        view.addSubview(successButton)
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.size.equalTo(30)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(lineView)
            make.top.equalTo(lineView.snp.bottom).offset(5)
        }
        
        successButton.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    func configureUI() {
        view.backgroundColor = Color.white
        
        lineView.backgroundColor = Color.lightGray
        
        stateLabel.setUILabel("", textAlignment: .left, color: Color.myShopMainColor, backgroundColor: .clear, font: Font.regular13, cornerRadius: 0, numberLine: 1)
    }
    
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewClicked))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func randomImage() {
        randomImageName = "profile_\(Int.random(in: 0...11))"
        print("\(randomImageName)")
    }
    
    func addTargets() {
        successButton.addTarget(self, action: #selector(successButtonClicked), for: .touchUpInside)
    }
    
    func setView() {
        if viewtype == .new {
            successButton.isHidden = false
            successButton.isEnabled = false
            successButton.backgroundColor = Color.lightGray
        } else {
            let storeButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(storeButtonClicked))
            navigationItem.rightBarButtonItem = storeButton
            successButton.isHidden = true
        }
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileImageViewClicked() {
        let nv = ProfileViewController()
        nv.imageName = randomImageName
        navigationController?.pushViewController(nv, animated: true)
    }
    
    @objc func successButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let rootViewController = TabBarController()
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc func storeButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension NicknameViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count >= 2 && textField.text!.count < 10 {
            if textField.text!.range(of: "\\d", options: .regularExpression) != nil {
                stateLabel.text = Requirement.number.rawValue
                successButton.isEnabled = false
                successButton.backgroundColor = Color.lightGray
            } else if textField.text!.range(of:"@") != nil {
                stateLabel.text = Requirement.at.rawValue
                successButton.isEnabled = false
                successButton.backgroundColor = Color.lightGray
            } else if textField.text!.range(of:"#") != nil {
                stateLabel.text = Requirement.hash.rawValue
                successButton.isEnabled = false
                successButton.backgroundColor = Color.lightGray
            } else if textField.text!.range(of:"$") != nil {
                stateLabel.text = Requirement.dollar.rawValue
                successButton.isEnabled = false
                successButton.backgroundColor = Color.lightGray
            } else if textField.text!.range(of:"%") != nil {
                stateLabel.text = Requirement.percent.rawValue
                successButton.isEnabled = false
                successButton.backgroundColor = Color.lightGray
            } else {
                stateLabel.text = Requirement.correct.rawValue
                successButton.isEnabled = true
                successButton.backgroundColor = Color.myShopMainColor
            }
        } else {
            stateLabel.text = Requirement.count.rawValue
            successButton.isEnabled = false
            successButton.backgroundColor = Color.lightGray
        }
    }
    
    
}
