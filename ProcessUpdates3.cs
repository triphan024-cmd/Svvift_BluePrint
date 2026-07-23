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

            // Task 7: Replace Phase I title format
            int phan1Idx = -1;
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("id=\"phan1-truth\"")) {
                    phan1Idx = i;
                    break;
                }
            }
            if (phan1Idx != -1) {
                var newHeader = new List<string>() {
                    "                        <div class=\"section-header observe\" style=\"text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;\">",
                    "                            <div style=\"display: inline-flex; align-items: center; gap: 8px; background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;\">",
                    "                                <span style=\"font-size: 0.75rem; font-weight: 800; color: #DC2626; text-transform: uppercase; letter-spacing: 2px;\">⚠️ PHẦN I — TRUTH AUDIT</span>",
                    "                            </div>",
                    "                            <h2 class=\"section-title\" style=\"margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;\">",
                    "                                <span style=\"background: linear-gradient(135deg, #DC2626 0%, #B91C1C 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;\">I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA</span>",
                    "                            </h2>",
                    "                            <div style=\"width: 60px; height: 4px; background: linear-gradient(90deg, #DC2626, #991B1B); margin: 0.75rem auto 0; border-radius: 4px;\"></div>",
                    "                        </div>"
                };
                lines.InsertRange(phan1Idx, newHeader);
                
                // Now remove the inner header inside phan1-truth
                // It's a div with flex, border-bottom right after phan1-truth
                int phan1ContentIdx = phan1Idx + newHeader.Count;
                if (lines[phan1ContentIdx + 1].Contains("border-bottom: 2px solid rgba(220,38,38,0.1)")) {
                    lines.RemoveRange(phan1ContentIdx + 1, 6);
                }
            }

            // Task 8: Replace Phase II title format
            int phan2Idx = -1;
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("id=\"phan2-vision\"")) {
                    phan2Idx = i;
                    break;
                }
            }
            if (phan2Idx != -1) {
                var newHeader = new List<string>() {
                    "                        <div class=\"section-header observe\" style=\"text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;\">",
                    "                            <div style=\"display: inline-flex; align-items: center; gap: 8px; background: rgba(30,58,138,0.06); border: 1px solid rgba(30,58,138,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;\">",
                    "                                <span style=\"font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 2px;\">🌍 PHẦN II — GLOBAL STANDARDS</span>",
                    "                            </div>",
                    "                            <h2 class=\"section-title\" style=\"margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;\">",
                    "                                <span style=\"background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 50%, #10B981 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;\">TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ</span>",
                    "                            </h2>",
                    "                            <div style=\"width: 60px; height: 4px; background: linear-gradient(90deg, #1E3A8A, #10B981); margin: 0.75rem auto 0; border-radius: 4px;\"></div>",
                    "                        </div>"
                };
                lines.InsertRange(phan2Idx, newHeader);
                
                // Now remove the inner header inside phan2-vision
                int phan2ContentIdx = phan2Idx + newHeader.Count;
                if (lines[phan2ContentIdx + 1].Contains("border-bottom: 2px solid rgba(30,58,138,0.1)")) {
                    lines.RemoveRange(phan2ContentIdx + 1, 6);
                }
            }
            
            // Task 9: Phase III ỨNG DỤNG THỰC TẾ -> GIÁ TRỊ CỐT LÕI
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("PHẦN III — PRACTICAL EXECUTION")) {
                    lines[i] = lines[i].Replace("PHẦN III — PRACTICAL EXECUTION", "PHẦN III — CORE VALUES");
                }
                if (lines[i].Contains("ỨNG DỤNG THỰC TẾ")) {
                    lines[i] = lines[i].Replace("ỨNG DỤNG THỰC TẾ", "GIÁ TRỊ CỐT LÕI");
                }
            }

            // Task 10: SOP text in Phase 3
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<li>Chính sách chuẩn hóa toàn diện.</li>")) {
                    lines[i] = "                                                    <li>Thiết lập mới Sơ đồ Tổ chức</li>";
                }
                if (lines[i].Contains("<li>Minh bạch <strong>Vai trò & Trách nhiệm (R&R)</strong>.</li>")) {
                    lines[i] = "                                                    <li>Vai trò & Trách nhiệm (R&R) rõ ràng</li>";
                }
                if (lines[i].Contains("<li>Mục tiêu <strong>SMART</strong> loại bỏ phỏng đoán.</li>")) {
                    lines[i] = ""; // Removed
                }
            }

            // Task 11: App text in Phase 3
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<h5 style=\"font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;\">Công Cụ Số Hóa</h5>")) {
                    lines[i] = lines[i].Replace("Công Cụ Số Hóa", "Công Cụ Hiện Đại");
                }
                if (lines[i].Contains("<li><strong>1 App tập trung duy nhất</strong> cho toàn công ty.</li>")) {
                    lines[i] = "                                                    <li>1 App tập trung duy nhất</li>";
                }
                if (lines[i].Contains("<li>Số hóa đo lường 100% hoạt động.</li>")) {
                    lines[i] = ""; // Removed
                }
            }

            // Task 12: Special Forces text in Phase 3
            for(int i = 0; i < lines.Count; i++) {
                if (lines[i].Contains("<li><strong>Đội đặc nhiệm (Special Forces)</strong> tinh nhuệ.</li>")) {
                    lines[i] = "                                                    <li>Đội đặc nhiệm (Special Forces) tinh nhuệ.</li>";
                }
                if (lines[i].Contains("<li>Tuân thủ SOP tuyệt đối không ngoại lệ.</li>")) {
                    lines[i] = ""; // Removed
                }
            }
            
            // Remove empty lines artifact
            lines.RemoveAll(x => x == "");
            
            File.WriteAllLines("index.html", lines.ToArray(), utf8NoBom);
            Console.WriteLine("All tasks completed.");
            
        } catch (Exception ex) {
            Console.WriteLine("Error: " + ex.Message);
            Console.WriteLine(ex.StackTrace);
        }
    }
}
