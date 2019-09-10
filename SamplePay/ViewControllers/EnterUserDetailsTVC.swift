//
//  EnterUserDetailsTVC.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

//MARK:- EnterUserDetailsTVC
final class EnterUserDetailsTVC: UITableViewController {
    //MARK: Member Declarations
    fileprivate lazy var doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(handleDoneTap))
    fileprivate lazy var cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTap))
    fileprivate var chosenImage: UIImage?
    fileprivate var editedIndexPath: IndexPath?
    
    var delegate: SamplePayDelegate?
    
    //MARK: Member Declarations
    var tableListArr: [[String: String]]!
    
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
        convertModelIntoJson()
        configureTableView()
        setAccessibilityLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewTapped)))
    }
}

//MARK:- EnterUserDetailsTVC: Event Methods Implementation
extension EnterUserDetailsTVC {
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    func cameraButtonClicked() {
        ImagePickerManager.shared.presentCameraImagePickerInViewController(vc: self)
        ImagePickerManager.shared.onImagePickerDismissCallBack = {[unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        ImagePickerManager.shared.onImageChosenCallBack = {[unowned self] image in
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UserPicEditTableViewCell
            cell.profileImgView.image = image
            cell.profileImgView.layer.cornerRadius = cell.profileImgView.frame.size.width/2
            cell.profileImgView.layer.borderWidth = 3.0
            cell.profileImgView.layer.borderColor = UIColor.white.cgColor
            cell.profileImgView.layer.masksToBounds = true
            
            self.chosenImage = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleDoneTap() {
        let user = User.init()
        do {
            user.firstName = try FirstNameValidator().validated(tableListArr[0]["value"] ?? "")
            user.lastName = try LastNameValidator().validated(tableListArr[1]["value"] ?? "")
            user.mobile = try MobileValidator().validated(tableListArr[2]["value"] ?? "")
            user.email = try EmailValidator().validated(tableListArr[3]["value"] ?? "")
            user.profilePic = chosenImage
            if let delegate = delegate {
                delegate.didFinishedWithEnteringUserDetails(user: user)
                self.dismiss(animated: true, completion: nil)
            }
            
        } catch(let error) {
            UIAlertController.displayAlert(message: (error as! ValidationError).message, title: "Error", inViewController: self)
        }
    }
    
    @objc func handleCancelTap() {
        if let delegate = delegate {
            delegate.didClickedOnCancel()
        }
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setAccessibilityLabels() {
        doneButton.accessibilityLabel = "ALDoneBarButtonItem"
        cancelButton.accessibilityLabel = "ALCancelBarButtonItem"
        tableView.accessibilityLabel = "ALEditContactTableView"
    }
}

//MARK:- EnterUserDetailsTVC: Private Methods Implementation
extension EnterUserDetailsTVC {
    fileprivate func configureTableView() {
        let bundle = Bundle(for: type(of: self))
        
        self.tableView.register(UINib.init(nibName: String(describing: UserDetailTableViewCell.self), bundle: bundle), forCellReuseIdentifier: String(describing: UserDetailTableViewCell.self))
        self.tableView.register(UINib.init(nibName: String(describing: UserPicEditTableViewCell.self), bundle: bundle), forCellReuseIdentifier: String(describing: UserPicEditTableViewCell.self))
        
        tableView.tableFooterView = UIView.init()
        self.tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.WhiteBGColor
        tableView.rowHeight = EnterUserDetailsTVCConstants.dimension.rowHeight
        tableView.separatorColor = UIColor.lineSeparatorColor
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func convertModelIntoJson() {
        tableListArr = [
            [
                "key": "First Name",
                "value": ""
            ],
            [
                "key": "Last Name",
                "value": ""
            ],
            [
                "key": "Mobile",
                "value": ""
            ],
            [
                "key": "Email",
                "value": ""
            ]
        ]
    }
}

//MARK:- EnterUserDetailsTVC: UITableview DataSource Method Implementation
extension EnterUserDetailsTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableListArr?.count ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserPicEditTableViewCell.self)) as! UserPicEditTableViewCell
            cell.cameraActionCallBack = {[unowned self] in
                self.cameraButtonClicked()
            }
            return cell
        }
        
        let row = indexPath.row - 1
        let details = tableListArr?[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserDetailTableViewCell.self)) as! UserDetailTableViewCell
        cell.valueTF.tag = row
        cell.valueTF.delegate = self
        cell.titleLable.text = details?["key"]
        cell.valueTF.text = details?["value"]
        return cell
    }
}

//MARK:- EnterUserDetailsTVC: UITableview Delegate Method Implementation
extension EnterUserDetailsTVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? EnterUserDetailsTVCConstants.dimension.headerHeight : EnterUserDetailsTVCConstants.dimension.rowHeight
    }
}

//MARK: EnterUserDetailsTVC - UITextFieldDelegate Methods Implementation
extension EnterUserDetailsTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let nextRowIndex = textField.tag + 2
        if nextRowIndex < 5, let cell = self.tableView.cellForRow(at: IndexPath.init(row: nextRowIndex, section: 0)) as? UserDetailTableViewCell{
            cell.valueTF.becomeFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tableListArr?[textField.tag]["value"] = textField.text
    }
}
