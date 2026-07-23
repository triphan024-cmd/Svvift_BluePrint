$content = [System.IO.File]::ReadAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", [System.Text.Encoding]::UTF8)

# 1. Replace BOD Section from <hr ...> down to before <!-- PHẦN VI -->
$bodSection = [System.IO.File]::ReadAllText("c:\Users\PC Tri\Antigravity\Blue Print\bod_section.txt", [System.Text.Encoding]::UTF8)

$bodPattern = '(?s)<hr style="border: 0; height: 1px; background: rgba\(0,0,0,0\.06\); margin: 2\.5rem 0;">\s*<div>\s*<h4[^>]*><span>⚠️</span> CƠ CHẾ KIỂM SOÁT BẮT BUỘC</h4>.*?</div>\s*</div>\s*(?=<!-- PHẦN VI)'

$content = [System.Text.RegularExpressions.Regex]::Replace($content, $bodPattern, "$bodSection`r`n                        ")

# 2. Remove outer <ul> wrapping "Bài học cốt lõi:" for Hyundai and Nvidia cards
$lessonPattern1 = '(?s)<ul style="margin: 0; padding-left: 1\.1rem; list-style-type: disc;">\s*<strong>Bài học cốt lõi:</strong>\s*<ul style="margin-top: 0\.25rem; margin-bottom: 0; padding-left: 1\.25rem; list-style-type: disc;">\s*<li>Sự táo bạo, tư duy không giới hạn</li>\s*<li>Khả năng thích ứng nhanh\. Không sợ hãi</li>\s*</ul>\s*</ul>'

$lessonReplacement1 = '<strong style="display: block; margin-bottom: 0.25rem;">Bài học cốt lõi:</strong>
                                        <ul style="margin: 0; padding-left: 1.25rem; list-style-type: disc;">
                                            <li>Sự táo bạo, tư duy không giới hạn</li>
                                            <li>Khả năng thích ứng nhanh. Không sợ hãi</li>
                                        </ul>'

$content = [System.Text.RegularExpressions.Regex]::Replace($content, $lessonPattern1, $lessonReplacement1)

$lessonPattern2 = '(?s)<ul style="margin: 0; padding-left: 1\.1rem; list-style-type: disc;">\s*<strong>Bài học cốt lõi:</strong>\s*<ul style="margin-top: 0\.25rem; margin-bottom: 0; padding-left: 1\.25rem; list-style-type: disc;">\s*<li>Speed of Light & Stop Overthinking</li>\s*<li>Bắt tay vào làm và tinh chỉnh liên tục!</li>\s*</ul>\s*</ul>'

$lessonReplacement2 = '<strong style="display: block; margin-bottom: 0.25rem;">Bài học cốt lõi:</strong>
                                        <ul style="margin: 0; padding-left: 1.25rem; list-style-type: disc;">
                                            <li>Speed of Light & Stop Overthinking</li>
                                            <li>Bắt tay vào làm và tinh chỉnh liên tục!</li>
                                        </ul>'

$content = [System.Text.RegularExpressions.Regex]::Replace($content, $lessonPattern2, $lessonReplacement2)

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", $content, $utf8NoBom)
Write-Host "Final fixes applied cleanly."
