//
//  SearchResultsView.swift
//  SearchApp
//
//  Created by Fawad on 17/02/22.
//

import SwiftUI
import Combine

struct SearchResultsView: View {
    
    // Mark - ViewModel Observer Object
    @ObservedObject var viewModel = SearchResultsViewModel()

    let spacing: CGFloat = 8
    
    var body: some View {
        NavigationView{
            List(self.viewModel.schoolList, id: \.operatingSchoolNumber) { article in
                NavigationLink(destination: SchoolDetailView(schoolModel: article), label: {
                    VStack(alignment: .leading, spacing: 5)
                    {
                        Text(verbatim: article.schoolName)
                            .font(.headline)
                            .padding(.top, 5)

                    }
                })
                
                
            }
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        self.viewModel.getSchoolsData()
    }
}



