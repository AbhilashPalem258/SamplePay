//
//  EnterUserDetailsTVC.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

//MARK:- EnterUserDetailsTVC
class EnterUserDetailsTVC: UITableViewController {
    //MARK: Member Declarations
    fileprivate lazy var doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(handleDoneTap))
    fileprivate lazy var cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTap))
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewTapped)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleDoneTap() {
        let user = User.init()
        user.firstName = tableListArr[0]["value"]
        user.lastName = tableListArr[1]["value"]
        user.mobile = tableListArr[2]["value"]
        user.email = tableListArr[3]["value"]
        
        if let delegate = delegate {
            delegate.didFinishedWithEnteringUserDetails(user: user)
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
        tableView.backgroundColor = UIColor.WhiteBGColor
        tableView.rowHeight = EnterUserDetailsTVCConstants.dimension.rowHeight
        tableView.separatorColor = UIColor.lineSeparatorColor
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func setTableListDetail(paramsHash: inout [String: String], element: [String: String], index: Int) {
        if let value = self.tableListArr?[index]["value"] {
            paramsHash[element["jsonKey"]!] = value
        }
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
                "key": "mobile",
                "value": ""
            ],
            [
                "key": "email",
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tableView.scrollToRow(at: IndexPath.init(row: textField.tag, section: 0), at: .middle, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableListArr?[textField.tag]["value"] = textField.text
    }
}
//MARK: EnterUserDetailsTVC - KeyboardEventHandling Method Implementation
extension EnterUserDetailsTVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
