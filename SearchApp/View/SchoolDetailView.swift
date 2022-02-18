//
//  SchoolDetailView.swift
//  SearchApp
//
//  Created by Fawad on 17/02/22.
//

import Foundation
import SwiftUI

struct SchoolDetailView: View{
    var schoolModel: SchoolResultObjectModel
    @ObservedObject var viewModel = SearchResultsViewModel()

    
    var body: some View{
        VStack(alignment: .leading, spacing: 5) {
            Text("School Name: \(self.viewModel.schoolDetails.schoolName)")
                .font(.headline)
                .padding(.top, 5)
            Text("Writing Score: \(self.viewModel.schoolDetails.writingScore)")
                .font(.headline)
                .padding(.top, 5)
            Text("Reading Score: \(self.viewModel.schoolDetails.readingScore)")
                .font(.headline)
                .padding(.top, 5)
            Text("Math Score: \(self.viewModel.schoolDetails.mathsScore)")
                .font(.headline)
                .padding(.top, 5)
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        self.viewModel.getSchoolsDetailsData(schoolName: schoolModel.schoolName)
    }
}
