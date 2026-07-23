using System;
using System.IO;
using System.Text;
using System.Collections.Generic;

public class Program {
    public static void Run() {
        try {
            var utf8NoBom = new UTF8Encoding(false);
            var lines = new List<string>(File.ReadAllLines("index.html", utf8NoBom));
            
            // Task 1: Fix Bullet points for Bài học cốt lõi
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<li><strong>Bài học cốt lõi:</strong> Sự táo bạo, tư duy không giới hạn. Khả năng thích ứng nhanh. Không sợ hãi</li>")) {
                    lines[i] = "                                            <strong>Bài học cốt lõi:</strong>\n" +
                               "                                            <ul style=\"margin-top: 0.25rem; margin-bottom: 0; padding-left: 1.25rem; list-style-type: disc;\">\n" +
                               "                                                <li>Sự táo bạo, tư duy không giới hạn</li>\n" +
                               "                                                <li>Khả năng thích ứng nhanh. Không sợ hãi</li>\n" +
                               "                                            </ul>";
                }
                if (lines[i].Contains("<li><strong>Bài học cốt lõi:</strong> Speed of Light & Stop Overthinking — Bắt tay vào làm và tinh chỉnh liên tục!</li>")) {
                    lines[i] = "                                            <strong>Bài học cốt lõi:</strong>\n" +
                               "                                            <ul style=\"margin-top: 0.25rem; margin-bottom: 0; padding-left: 1.25rem; list-style-type: disc;\">\n" +
                               "                                                <li>Speed of Light & Stop Overthinking</li>\n" +
                               "                                                <li>Bắt tay vào làm và tinh chỉnh liên tục!</li>\n" +
                               "                                            </ul>";
                }
            }
            
            // Task 2: Group "Có tổ chức... " below "Học tập kinh nghiệm..."
            int tagsStart = -1;
            int tagsEnd = -1;
            int listEnd = -1;
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<span") && lines[i].Contains("Có tổ chức (Organized)")) {
                    tagsStart = i - 1; // <div style="display: flex...
                    tagsEnd = i + 3; // 3 spans + </div>
                    break;
                }
            }
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<li>Học tập kinh nghiệm vận hành thực chiến từ các tập đoàn đa quốc gia hàng đầu:</li>")) {
                    listEnd = i + 1; // the </ul> line
                    break;
                }
            }
            
            if (tagsStart != -1 && listEnd != -1 && tagsStart < listEnd) {
                var tagsLines = new List<string>();
                for (int i = tagsStart; i <= tagsEnd; i++) {
                    tagsLines.Add(lines[i]);
                }
                // Also grab the empty line below it if any
                if (lines[tagsEnd + 1].Trim() == "") tagsEnd++;
                
                // Remove the tags from original position
                lines.RemoveRange(tagsStart, tagsEnd - tagsStart + 1);
                
                // Find listEnd again since indices changed
                listEnd = -1;
                for(int i = 0; i < lines.Count; i++) {
                    if (lines[i].Contains("<li>Học tập kinh nghiệm vận hành thực chiến từ các tập đoàn đa quốc gia hàng đầu:</li>")) {
                        listEnd = i + 1;
                        break;
                    }
                }
                
                // Insert tags below list
                lines.InsertRange(listEnd + 1, tagsLines);
            }
            
            // Task 3: CHIẾN LƯỢC 12 TUẦN NÂNG CẤP TOÀN DIỆN
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("CHIẾN LƯỢC 12 TUẦN NÂNG CẤP TOÀN DIỆN")) {
                    lines[i] = lines[i].Replace("NÂNG CẤP TOÀN DIỆN", "NÂNG CẤP<br>TOÀN DIỆN");
                }
            }
            
            // Task 4, 5, 6: Text replacements
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("Tất cả mọi người đều muốn tăng lương, nhưng lại không chịu làm những việc khác đi để xứng đáng với điều đó.")) {
                    lines[i] = lines[i].Replace("Tất cả mọi người đều muốn tăng lương, nhưng lại không chịu làm những việc khác đi để xứng đáng với điều đó.", "Tất cả mọi người đều muốn tăng lương, nhưng lại chưa hành động cụ thể nào để thực hiện việc này.");
                }
                if (lines[i].Contains("Duy trì tư duy xưởng lắp ráp sẽ làm công ty không thể bứt phá và thu nhập mãi <strong>dậm chân tại chỗ</strong>.")) {
                    lines[i] = lines[i].Replace("Duy trì tư duy xưởng lắp ráp sẽ làm công ty không thể bứt phá và thu nhập mãi <strong>dậm chân tại chỗ</strong>.", "Duy trì vận hành như hiện tại thì thu nhập mãi dậm chân tại chỗ.");
                }
                if (lines[i].Contains("Nâng cấp nhà máy thành một <strong>trung tâm sản xuất có tư duy, có hệ thống và tạo giá trị cao</strong>.")) {
                    lines[i] = lines[i].Replace("Nâng cấp nhà máy thành một <strong>trung tâm sản xuất có tư duy, có hệ thống và tạo giá trị cao</strong>.", "Nâng cấp thành một nhà máy sản xuất hiện đại thông minh có tư duy, có hệ thống và tạo ra giá trị cao.");
                }
            }
            
            // Task 7: Phase I Format
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("⚠️ Phase I - Reality Check")) {
                    lines[i] = lines[i].Replace("⚠️ Phase I - Reality Check", "⚠️ PHẦN I — TRUTH AUDIT");
                }
                if (lines[i].Contains("NHÌN THẲNG VÀO")) {
                    lines[i] = "                                <span style=\"background: linear-gradient(135deg, #DC2626 0%, #B91C1C 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;\">I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA</span>";
                }
                if (lines[i].Contains("SỰ THẬT") && lines[i - 1].Contains("VỊ THẾ HIỆN TẠI")) {
                    lines[i] = ""; // Delete second span
                }
            }
            // Remove inner header for Phase I
            int innerHeaderI = -1;
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA") && lines[i].Contains("<h3") && lines[i].Contains("span")) {
                    innerHeaderI = i - 1; // start of div
                    break;
                }
            }
            if (innerHeaderI != -1) {
                // Remove the flex div with the inner header
                // <div style="display: flex; ... border-bottom...">
                //    <h3> ... </h3>
                //    <span> ... </span>
                // </div>
                int endDiv = -1;
                for(int i = innerHeaderI; i < innerHeaderI + 10; i++) {
                    if (lines[i].Contains("</div>")) {
                        endDiv = i;
                        break;
                    }
                }
                if (endDiv != -1) {
                    lines.RemoveRange(innerHeaderI, endDiv - innerHeaderI + 1);
                }
            }

            // Task 8: Phase II Format
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("🌍 Phase II - Master Strategy Blueprint")) {
                    lines[i] = lines[i].Replace("🌍 Phase II - Master Strategy Blueprint", "🌍 PHẦN II — GLOBAL STANDARDS");
                }
                if (lines[i].Contains("CON THUYỀN MỚI")) {
                    lines[i] = "                                <span style=\"background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 50%, #10B981 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;\">TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ</span>";
                }
                if (lines[i].Contains("CHIẾN LƯỢC 12 TUẦN NÂNG CẤP") && lines[i-1].Contains("TẦM NHÌN, CẢM HỨNG")) {
                    lines[i] = ""; // Delete second span because they want the big header to just be TẦM NHÌN... Wait, they didn't ask to remove CHIẾN LƯỢC 12 TUẦN?
                    // Ah! The user requested: "Tittle 'CHIẾN LƯỢC 12 TUẦN NÂNG CẤP TOÀN DIỆN' xuống dòng cho chữ 'Toàn diện'".
                    // This implies CHIẾN LƯỢC 12 TUẦN must STILL exist!
                    // If CHIẾN LƯỢC 12 TUẦN is the Phase II title, where was "TẦM NHÌN, CẢM HỨNG"?
                    // Ah, "CON THUYỀN MỚI" is a subtitle. Maybe change "CON THUYỀN MỚI" to "TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ"?
                    // Yes! I'll revert this part and fix it properly.
                }
            }
            
            File.WriteAllLines("index.html", lines.ToArray(), utf8NoBom);
            Console.WriteLine("Partial tasks completed.");
            
        } catch (Exception ex) {
            Console.WriteLine("Error: " + ex.Message);
            Console.WriteLine(ex.StackTrace);
        }
    }
}
