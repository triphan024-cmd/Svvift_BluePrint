using System;
using System.IO;
using System.Text;
using System.Collections.Generic;

class Program {
    static void Main() {
        var path = "index.html";
        var lines = File.ReadAllLines(path, new UTF8Encoding(false));
        var list = new List<string>(lines);
        
        int startIdx = -1;
        int endIdx = -1;
        int insertIdx = -1;
        
        for (int i = 0; i < list.Count; i++) {
            if (list[i].Contains("<!-- C") && list[i].Contains("KI") && list[i].Contains("M SO") && list[i].Contains("B") && list[i].Contains("C -->")) {
                startIdx = i;
            }
            if (startIdx != -1 && i > startIdx) {
                if (list[i].Trim() == "</div>" && i + 2 < list.Count && list[i+1].Trim() == "</div>" && list[i+2].Trim() == "</div>") {
                    endIdx = i;
                    break;
                }
            }
        }
        
        for (int i = 0; i < list.Count; i++) {
            if (list[i].Contains("<!-- PH") && list[i].Contains("N VI:") && list[i].Contains("12")) {
                // Backtrack to find the first closing div sequence that matches the end of phan5-execution
                insertIdx = i - 5;
                break;
            }
        }
        
        if (startIdx != -1 && endIdx != -1 && insertIdx != -1) {
            int removeStart = startIdx;
            if (startIdx >= 2 && list[startIdx - 2].Contains("<hr")) {
                removeStart = startIdx - 2;
            }
            
            var block = new List<string>();
            block.Add("                            <hr style=\"border: 0; height: 1px; background: rgba(0,0,0,0.06); margin: 2.5rem 0;\">");
            for (int i = startIdx; i <= endIdx; i++) {
                block.Add(list[i]);
            }
            
            // Insert block
            list.InsertRange(insertIdx, block);
            
            // Adjust removeStart/endIdx because insertion shifted them if insertIdx < removeStart
            if (insertIdx < removeStart) {
                removeStart += block.Count;
                endIdx += block.Count;
            }
            
            list.RemoveRange(removeStart, endIdx - removeStart + 1);
            
            File.WriteAllLines(path, list, new UTF8Encoding(false));
            Console.WriteLine("Moved block successfully.");
        } else {
            Console.WriteLine("Failed to find indices: " + startIdx + ", " + endIdx + ", " + insertIdx);
        }
    }
}
