//
//  HomeView.swift
//  Learning App Template
//
//  Created by Gordon Ng on 2022-06-29.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack (spacing: 20) {
                                
                                
                                NavigationLink(tag: module.id, selection: $model.currentContentSelected) {
                                    ContentView()
                                    .onAppear(perform: {
                                        model.beginModule(module.id)
                                    })
                                } label: {
                                    // Learning Card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }

                                // Test Card
                                NavigationLink(tag: module.id, selection: $model.currentTestSelected) {
                                    TestView()
                                        .onAppear {
                                            model.beginTest(module.id)
                                        }
                                } label: {
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                }

                                
                            }
                            .padding(.bottom,10)
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { newValue in
                if newValue == nil{
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { newValue in
                if newValue == nil{
                    model.currentModule = nil
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
