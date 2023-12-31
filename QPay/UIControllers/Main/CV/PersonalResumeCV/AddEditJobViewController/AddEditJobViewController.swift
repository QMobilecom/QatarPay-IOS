//
//  AddPositionViewController.swift
//  QPay
//
//  Created by Mohammed Hamad on 11/05/2023.
//  Copyright © 2023 Dev. Mohmd. All rights reserved.
//

import UIKit

protocol AddEditJobViewControllerDelegate: AnyObject {
    func didTap(_ controller: AddEditJobViewController, on action: AddEditJobViewController.ActionType)
}

class AddEditJobViewController: ViewController {
    
    @IBOutlet weak var companyNameTextField : UITextField!
    
    @IBOutlet weak var jobTitleTextField    : UITextField!
    
    @IBOutlet weak var startDateTextField   : UITextField!
    
    @IBOutlet weak var startDateLabel       : UILabel!
    
    @IBOutlet weak var endDateTextField     : UITextField!
    
    @IBOutlet weak var endDateLabel         : UILabel!

    @IBOutlet weak var countryTextField     : UITextField!
    
    @IBOutlet weak var cityTextField        : UITextField!
    
    @IBOutlet weak var deleteButton         : UIButton!
    
    var currentJob       : CurrentJob?
    var previousJob      : PreviousJob?
    weak var delegate    : AddEditJobViewControllerDelegate?
    var jobType: JobType = .currentJob
    
    private let startDatePicker    = UIDatePicker()
    private let endDatePicker      = UIDatePicker()
    private let dateFormat         = ServerDateFormat.Server2
    private var dateType: DateType = .startDate
    
    enum ActionType {
        case deleteCurrentJob
        case deletePreviousJob
        case editCurrentJob(CurrentJob)
        case editPreviousJob(PreviousJob)
        case addCurrentJob(CurrentJob)
        case addPreviousJob(PreviousJob)
    }
    
    enum DateType : CaseIterable {
        case startDate
        case endDate
    }
    
    enum JobType : CaseIterable {
        case currentJob
        case previousJob
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension AddEditJobViewController {
    func setupView() {
        self.requestProxy.requestService()?.delegate = self
        
        switch jobType {
        case .currentJob:
            self.endDateTextField.isHidden  = true
            break
            
        case .previousJob:
            self.endDateTextField.isHidden  = false
            break
        }
        
//        self.deleteButton.isHidden = self.currentJob == nil || self.previousJob == nil
        
        self.startDateTextField.delegate = self
        self.endDateTextField.delegate   = self
    }
    
    func localized() {
    }
    
    func setupData() {
        
        switch jobType {
        case .currentJob:
            if let job = self.currentJob {
                self.companyNameTextField.text  = job._companyNamee
                self.jobTitleTextField.text     = job._jobTitle
                self.countryTextField.text      = job._country
                self.cityTextField.text         = job._city
                
                if  let date = job._jobStartDate.server2StringToDate(){
                    self.startDateLabel.text = "\(date.formatDate("MMMM yyyy"))"
                    self.startDateTextField.text = date.formatDate(self.dateFormat.rawValue)
                    self.startDateTextField.placeholder  = ""

                }
            }
            break
            
        case .previousJob:
            if let job = self.previousJob {
                self.companyNameTextField.text  = job._companyNamee
                self.jobTitleTextField.text     = job._jobtitle
                self.countryTextField.text      = job._country
                self.cityTextField.text         = job._city
                
                if let jobStartDate = job._jobStartdate.server2StringToDate(),
                   let jobEndDate   = job._previousEnddate.server2StringToDate() {
                    self.startDateLabel.text = "\(jobStartDate.formatDate("MMMM yyyy"))"
                    self.endDateLabel.text   = "\(jobEndDate.formatDate("MMMM yyyy"))"
                    
                    self.startDateTextField.text = jobStartDate.formatDate(self.dateFormat.rawValue)
                    self.endDateTextField.text   = jobEndDate.formatDate(self.dateFormat.rawValue)
                    
                    self.startDateTextField.placeholder  = ""
                    self.endDateTextField.placeholder    = ""
                }
            }
            break
        }
    }
    
    func fetchData() {
    }
}

// MARK: - Action

extension AddEditJobViewController {
    
    @IBAction func backAction(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func doneAction(_ sender : UIButton){
        
        guard let companyName = self.companyNameTextField.text, companyName.isNotEmpty,
              let jobTitle = self.jobTitleTextField.text, jobTitle.isNotEmpty,
              let startDate = self.startDateTextField.text,
              let country = self.countryTextField.text, country.isNotEmpty,
              let city = self.cityTextField.text, city.isNotEmpty else {
            self.showSnackMessage("Enter All Data")
            return
        }
        
        switch jobType {
        case .currentJob :
            if var myJob = currentJob {
                myJob.companyName = companyName
                myJob.jobTitle = jobTitle
                myJob.jobStartDate = startDate
                myJob.country = country
                myJob.city = city
                guard let index = self.userProfile.cv?._currentJobList.firstIndex(where: { $0._id == myJob.id }) else {
                    self.showSnackMessage("Not found current job id")
                    return
                }
                
                self.userProfile.cv?.currentJobList?[index] = myJob
                guard let cv = self.userProfile.cv else { return }
                
                self.requestProxy.requestService()?.addUpdateCV(cv: cv, { response in
                    guard let resp = response else {
                        self.showSnackMessage("Something went wrong")
                        return
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + loadingViewDismissDelay) {
                        self.showSuccessMessage(resp._message)
                        self.delegate?.didTap(self, on: .editCurrentJob(myJob))
                    }
                })
                
            } else {
                guard  startDate.isNotEmpty else {
                    self.showSnackMessage("Enter All Data")
                    return
                }
                var newJob = CurrentJob()
                newJob.companyName  = companyName
                newJob.jobTitle     = jobTitle
                newJob.jobStartDate = startDate
                newJob.country      = country
                newJob.city         = city
                newJob.experience   = ""
                
                self.userProfile.cv?.currentJobList?.append(newJob)
                guard let cv = self.userProfile.cv else { return }
                
                self.requestProxy.requestService()?.addUpdateCV(cv: cv, { baseResponse in
                    guard let resp = baseResponse else {
                        self.showSnackMessage("Something went wrong, please try again later")
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + loadingViewDismissDelay) {
                        self.showSuccessMessage(resp._message)
                        self.delegate?.didTap(self, on: .addCurrentJob(newJob))
                    }
                })
            }
            break
            
        case .previousJob:
            guard let endDate = self.endDateTextField.text else {
                 return
            }
            
            if var myJob = previousJob {
                myJob.companyName = companyName
                myJob.jobtitle = jobTitle
                myJob.jobStartdate    = startDate
                myJob.previousEnddate = endDate
                myJob.country = country
                myJob.city = city
                
                guard let index = self.userProfile.cv?._previousJobList.firstIndex(where: { $0._id == myJob.id }) else {
                    self.showSnackMessage("Not found previous job id")
                    return
                }
                
                self.userProfile.cv?.previousJobList?[index] = myJob
                guard let cv = self.userProfile.cv else {
                    self.showSnackMessage("Something went wrong")
                    return
                }
                
                self.requestProxy.requestService()?.addUpdateCV(cv: cv, { response in
                    guard let resp = response else {
                        self.showSnackMessage("Something went wrong")
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + loadingViewDismissDelay) {
                        self.showSuccessMessage(resp._message)
                        self.delegate?.didTap(self, on: .editPreviousJob(myJob))
                    }
                })
                
            } else {
                guard  startDate.isNotEmpty , endDate.isNotEmpty else {
                    self.showSnackMessage("Enter All Data")
                    return
                }
                
                var newJob = PreviousJob()
                newJob.companyName     = companyName
                newJob.jobtitle        = jobTitle
                newJob.jobStartdate    = startDate
                newJob.previousEnddate = endDate
                newJob.country         = country
                newJob.city            = city
                newJob.experience      = ""
                
                self.userProfile.cv?.previousJobList?.append(newJob)
                guard let cv = self.userProfile.cv else {
                    self.showSnackMessage("Something went wrong, please try again later")
                    return
                }
                
                self.requestProxy.requestService()?.addUpdateCV(cv: cv, { baseResponse in
                    guard let resp = baseResponse else {
                        self.showSnackMessage("Something went wrong, please try again later")
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + loadingViewDismissDelay) {
                        self.showSuccessMessage(resp._message)
                        self.delegate?.didTap(self, on: .addPreviousJob(newJob))
                    }
                })
            }
            break
        }
    }
    
    @IBAction func deleteAction(_ sender : UIButton){
        
        var id: Int = 0
        
        if let jobId = self.currentJob?._id {
            id = jobId
            
        } else if let jobId = self.previousJob?._id {
            id = jobId
        }
        
        guard id > 0 else {
            return
        }
        
        self.requestProxy.requestService()?.deleteCVJob(id: id, { (respons) in
            guard let resp = respons else { return
                self.showSnackMessage("ERROR" , messageStatus: .Error)
            }
            self.showSnackMessage(resp._message, messageStatus: .Success)
            
            switch self.jobType {
            case .currentJob:
                self.userProfile.cv?.currentJobList?.removeAll(where: { $0._id == id })
                self.delegate?.didTap(self, on: .deleteCurrentJob)
                break
                
            case .previousJob:
                self.userProfile.cv?.previousJobList?.removeAll(where: { $0._id == id })
                self.delegate?.didTap(self, on: .deletePreviousJob)
                break
            }
            
            self.navigationController?.popViewController(animated: true)
        })
    }
}

// MARK: - FUNC CREATE DATE PICKER

extension AddEditJobViewController {
    
    func createDatePicker(textField: UITextField)  {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dateDoneOnClick))
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dateCancelOnClick))
        
        toolbar.setItems([cancelBtn,doneBtn], animated: true)
        
        self.startDatePicker.datePickerMode = .date
        self.endDatePicker.datePickerMode   = .date
        
        textField.inputAccessoryView = toolbar
        
        if textField == self.startDateTextField {
            textField.inputView = self.startDatePicker
            self.dateType = .startDate
            
        } else if textField == self.endDateTextField {
            textField.inputView = self.endDatePicker
            self.dateType = .endDate
        }
    }
    
    @objc private func dateDoneOnClick() {
        
        switch self.dateType {
        case .startDate:
            let formattedDate = self.startDatePicker.date.formatDate(self.dateFormat.rawValue)
            self.startDateTextField.text = formattedDate
            self.startDateLabel.text     = "\(self.startDatePicker.date.formatDate("MMMM yyyy"))"
            break
            
        case .endDate:
            let formattedDate = self.endDatePicker.date.formatDate(self.dateFormat.rawValue)
            self.endDateTextField.text = formattedDate
            self.endDateLabel.text     = "\(self.endDatePicker.date.formatDate("MMMM yyyy"))"
            break
        }
    }
    
    @objc private func dateCancelOnClick() {
        self.view.endEditing(true)
    }
}

// MARK: - Requests Delegate
extension AddEditJobViewController: RequestsDelegate {
    
    func requestStarted(request: RequestType) {
        if request == .deleteJob ||
            request == .addUpdateCV {
            showLoadingView(self)
        }
    }
    
    func requestFinished(request: RequestType, result: ResponseResult) {
        self.hideLoadingView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + loadingViewDismissDelay) {
            
            switch result {
            case .Success(_):
                break
            case .Failure(let errorType):
                
                switch errorType {
                case .Exception(let exc):
                    if showUserExceptions {
                        self.showErrorMessage(exc)
                    }
                    break
                case .AlamofireError(let err):
                    if showAlamofireErrors {
                        self.showSnackMessage(err.localizedDescription)
                    }
                    break
                case .Runtime(_):
                    break
                }
                
            }
        }
    }
}

// MARK: - TEXT FIELD DELEGATE

extension AddEditJobViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.createDatePicker(textField: textField)
    }
}
