//
//  DateTime.swift
//  RemindeMe Watch App
//
//  Created by MRM on 20/12/23.
//

import SwiftUI

struct DateTime: View {
    @ObservedObject var vm = DateTimeViewModel()
    var submitDateTime:(DateTimeModel)->Void
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment:.leading,spacing: 10){
                HStack {
                    Picker("DD", selection: $vm.dateTime.date){ForEach(1..<32){date in Text("\(date)").tag(date)}.listStyle(.plain)}
                    
                    Picker("mm", selection: $vm.dateTime.month){ForEach(1..<13){month  in Text("\(month)").tag(month) }}
                    Picker("YYYY", selection: $vm.dateTime.year){ForEach(2023..<3001){year in Text(formatNumber(year)).tag(year)}}.frame(minWidth:geometry.size.width*0.4)}
                
                
                HStack {
                    Picker("HH", selection: $vm.dateTime.hour){ForEach(1..<13){hour in Text("\(hour)").tag(hour) }}
      
                    Picker("MM", selection: $vm.dateTime.minute){ForEach(0..<60){minute in Text("\(minute)").tag(minute) }}
            
                    Picker("AM/PM", selection: $vm.dateTime.ampm){ForEach(["AM","PM"],id: \.self){ampm in Text(ampm).tag(ampm) }}
                    
                }.frame(height:geometry.size.height*0.5,alignment: .center)
            }.onDisappear {
                submitDateTime(vm.dateTime)
            }
        }
    }
    func formatNumber(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}

struct DateTime_Previews: PreviewProvider {
    static var previews: some View {
        DateTime(submitDateTime: {_ in })
    }
}
