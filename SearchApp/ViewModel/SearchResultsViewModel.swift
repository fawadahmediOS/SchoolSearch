//
//  SearchResultsViewModel.swift
//  SearchApp
//
//  Created by Fawad on 17/02/22.
//

import Foundation
import Combine
import SwiftUI

final class SearchResultsViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var schoolList = [SchoolResultObjectModel]() {
        didSet { didChange.send() }
    }
    
    @Published var schoolDetails = SchoolDetailsResultsObjectModel(schoolName: "", dbn: "", readingScore: "", mathsScore: "", writingScore: "") {
        didSet { didChange.send() }
    }
    
    init(){
    }
    
    public func getSchoolsData() {
        Webservice().getSchoolData(){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    var schoolData = [SchoolResultObjectModel]()
                    for school in response!{
                        schoolData.append(SchoolResultObjectModel.init(schoolName: school["school_name"]!, dbn: school["dbn"]!))
                    }
                    self.schoolList = schoolData
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    public func getSchoolsDetailsData(schoolName: String) {
        Webservice().getSchoolsDetailsData(){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    var foundSchool : Bool = false
                    let notFoundText = "Not Found In Records"

                    for schoolDetail in response!{
                        let schoolDetails = SchoolDetailsResultsObjectModel.init(schoolName: schoolDetail["school_name"]!,
                                                                                 dbn: schoolDetail["dbn"]!,
                                                                                 readingScore: schoolDetail["sat_critical_reading_avg_score"]!,
                                                                                 mathsScore: schoolDetail["sat_math_avg_score"]!,
                                                                                 writingScore: schoolDetail["sat_writing_avg_score"]!
                        )
                        if (schoolName.lowercased() == schoolDetails.schoolName.lowercased()){
                            self.schoolDetails = schoolDetails
                            foundSchool = true
                            break
                        }
                    }
                    if (foundSchool == false){
                        let schoolDetails = SchoolDetailsResultsObjectModel.init(schoolName: notFoundText,
                                                                                 dbn: notFoundText,
                                                                                 readingScore: notFoundText,
                                                                                 mathsScore: notFoundText,
                                                                                 writingScore: notFoundText
                        )
                        self.schoolDetails = schoolDetails
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}

// Mark - SchoolResultObjectModel data parsing
struct SchoolResultObjectModel {
    var schoolName: String
    var dbn : String
    init(schoolName: String, dbn : String)
    {
        self.schoolName = schoolName
        self.dbn = dbn
    }
    var operatingSchoolNumber: String {
        
        return self.dbn
    }
}

// Mark - SchoolDetailsResultsObjectModel data parsing
struct SchoolDetailsResultsObjectModel {
    var schoolName: String
    var dbn : String
    var readingScore : String
    var mathsScore : String
    var writingScore : String

    init(schoolName: String, dbn : String, readingScore: String, mathsScore: String, writingScore: String)
    {
        self.schoolName = schoolName
        self.dbn = dbn
        self.readingScore = readingScore
        self.mathsScore = mathsScore
        self.writingScore = writingScore
    }
    var operatingSchoolNumber: String {
        return self.dbn
    }
}
