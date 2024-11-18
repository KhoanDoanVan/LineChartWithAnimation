//
//  ContentView.swift
//  SwiftCharts
//
//  Created by Đoàn Văn Khoan on 18/11/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State var yaxis: [Double] = Array(repeating: 0.0, count: 30)
    @State private var isShowSheet: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Button {
                    isShowSheet.toggle()
                    yaxis = Array(repeating: 0.0, count: 30)
                } label: {
                    Text("Show Diagram")
                }
            }
            .sheet(isPresented: $isShowSheet) {
                diagram
            }
        }
    }
    
    /// Diagram
    var diagram: some View {
        Chart {
            ForEach(yaxis.indices, id: \.self) { index in
                LineMark(
                    x: .value("Day", data[index].date),
                    y: .value("TasksCompleted", yaxis[index])
                )
                .symbol {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8)
                }
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.green.opacity(0.6))
                .lineStyle(.init(lineWidth: 3))
            }
        }
        .chartYScale(domain: [-0.5, 4.5])
        .chartPlotStyle { plotArea in
            plotArea
                .background(.mint.opacity(0.03))
                .border(.mint)
        }
        .frame(width: .infinity, height: 300)
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 1).delay(0.25)) {
                yaxis = data.map {
                    Double($0.tasksCompleted)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
