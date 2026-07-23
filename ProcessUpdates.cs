using System;
using System.IO;
using System.Net;
using System.Text;

public class Program {
    public static void Run() {
        try {
            var utf8NoBom = new UTF8Encoding(false);
            
            // Download potato html
            string potatoHtml;
            using (var client = new WebClient()) {
                client.Encoding = Encoding.UTF8;
                potatoHtml = client.DownloadString("https://raw.githubusercontent.com/triphan024-cmd/Potato-kickoff/main/index.html");
            }
            var potatoLines = potatoHtml.Split(new[] { "\r\n", "\r", "\n" }, StringSplitOptions.None);
            
            // Extract the section
            int startIdx = -1;
            int endIdx = -1;
            for(int i = 0; i < potatoLines.Length; i++) {
                if(potatoLines[i].Contains("far fa-calendar-alt")) {
                    startIdx = i - 1; // Back to the h4
                }
            }
            if (startIdx != -1) {
                // Find the div holding the cards
                for(int i = startIdx; i < potatoLines.Length; i++) {
                    if(potatoLines[i].Contains("<div class=\"grid grid-cols-1 md:grid-cols-3 gap-6 pt-6\">")) {
                        startIdx = i; // This is the grid div
                        break;
                    }
                }
                // End is exactly when the 3 cards end
                for(int i = startIdx; i < potatoLines.Length; i++) {
                    if(potatoLines[i].Contains("<!-- Monthly Meeting -->")) {
                        // next </div></div></div>
                        for(int j = i; j < potatoLines.Length; j++) {
                            if(potatoLines[j].Trim() == "</div>" && j + 1 < potatoLines.Length && potatoLines[j+1].Trim() == "</div>" && j + 2 < potatoLines.Length && potatoLines[j+2].Trim() == "</div>") {
                                endIdx = j + 1; // j closes Monthly Meeting, j+1 closes the grid
                                break;
                            }
                        }
                        break;
                    }
                }
            }
            
            Console.WriteLine("Extracted potato lines " + startIdx + " to " + endIdx);
            if (startIdx == -1 || endIdx == -1) return;
            
            var extractedSection = new System.Collections.Generic.List<string>();
            extractedSection.Add("                            <!-- LỊCH HOẠT ĐỘNG ĐỊNH KỲ -->");
            extractedSection.Add("                            <hr style=\"border: 0; height: 1px; background: rgba(0,0,0,0.06); margin: 2.5rem 0;\">");
            extractedSection.Add("                            <div>");
            extractedSection.Add("                                <h4 style=\"font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin-bottom: 1.25rem; display: flex; align-items: center; gap: 8px;\">");
            extractedSection.Add("                                    <span>📅</span> LỊCH HOẠT ĐỘNG ĐỊNH KỲ");
            extractedSection.Add("                                </h4>");
            for(int i = startIdx; i <= endIdx; i++) {
                extractedSection.Add(potatoLines[i]);
            }
            extractedSection.Add("                            </div>");
            
            // Now process index.html
            var lines = new System.Collections.Generic.List<string>(File.ReadAllLines("index.html", utf8NoBom));
            
            // Task 1: Fix bullets
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("Bài học cốt lõi:") && lines[i].Contains("Sự táo bạo, tư duy không giới hạn")) {
                    lines[i] = "                                            <li><strong>Bài học cốt lõi:</strong> Sự táo bạo, tư duy không giới hạn. Khả năng thích ứng nhanh. Không sợ hãi</li>";
                }
                if(lines[i].Contains("Bài học cốt lõi:") && lines[i].Contains("Speed of Light & Stop Overthinking")) {
                    lines[i] = "                                            <li><strong>Bài học cốt lõi:</strong> Speed of Light & Stop Overthinking — Bắt tay vào làm và tinh chỉnh liên tục!</li>";
                }
            }
            
            // Task 2: Layout VAI TRÒ & TRÁCH NHIỆM
            // 1. Remove the span from the inner div
            string badgeLine = "";
            int badgeIdx = -1;
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("VAI TRÒ & TRÁCH NHIỆM") && lines[i].Contains("<span")) {
                    badgeLine = lines[i];
                    badgeIdx = i;
                    break;
                }
            }
            if (badgeIdx != -1) {
                lines.RemoveAt(badgeIdx);
            }

            // 2. Add position:relative to phan5-execution and insert badge
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("id=\"phan5-execution\"")) {
                    if(!lines[i].Contains("position: relative;")) {
                        lines[i] = lines[i].Replace("box-shadow: 0 10px 30px rgba(0,0,0,0.04);\">", "box-shadow: 0 10px 30px rgba(0,0,0,0.04); position: relative;\">");
                    }
                    if(!string.IsNullOrEmpty(badgeLine)) {
                        string newBadgeLine = badgeLine.Replace("right: 0; top: 0;", "right: 2rem; top: 2rem;").Replace("right: 0px; top: 0px;", "right: 2rem; top: 2rem;");
                        lines.Insert(i + 1, newBadgeLine);
                    }
                    break;
                }
            }
            
            // Task 3: Viết hoa Văn hóa Svvift
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("Văn hóa Svvift")) {
                    lines[i] = lines[i].Replace("Văn hóa Svvift", "VĂN HÓA SVVIFT");
                }
            }
            
            // Task 4: Replace CƠ CHẾ KIỂM SOÁT BẮT BUỘC with extracted section
            int coCheStart = -1;
            int coCheEnd = -1;
            for(int i = 0; i < lines.Count; i++) {
                if(lines[i].Contains("<!-- C") && lines[i].Contains("KI") && lines[i].Contains("M SO") && lines[i].Contains("C -->")) {
                    coCheStart = i;
                    if (coCheStart >= 1 && lines[coCheStart - 1].Contains("<hr")) coCheStart -= 1;
                    break;
                }
            }
            
            Console.WriteLine("Found CO CHE at " + coCheStart);
            if (coCheStart != -1) {
                int divsToClose = 2; // We need to remove the wrapper div and the grid div
                coCheEnd = -1;
                for(int i = coCheStart; i < lines.Count; i++) {
                    if(lines[i].Contains("<!-- PH")) {
                        // Search backwards for the two closing divs of CƠ CHẾ
                        for (int j = i - 1; j > coCheStart; j--) {
                            if (lines[j].Trim() == "</div>") {
                                divsToClose--;
                                if (divsToClose == 0) {
                                    coCheEnd = j;
                                    break;
                                }
                            }
                        }
                        break;
                    }
                }
                Console.WriteLine("Adjusted CO CHE end: " + coCheEnd);
                
                if (coCheEnd != -1) {
                    lines.RemoveRange(coCheStart, coCheEnd - coCheStart + 1);
                    lines.InsertRange(coCheStart, extractedSection);
                }
            }
            
            File.WriteAllLines("index.html", lines.ToArray(), utf8NoBom);
            Console.WriteLine("All tasks completed successfully.");
            
        } catch (Exception ex) {
            Console.WriteLine("Error: " + ex.Message);
            Console.WriteLine(ex.StackTrace);
        }
    }
}
