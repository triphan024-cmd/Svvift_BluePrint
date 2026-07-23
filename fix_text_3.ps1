$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines("index.html", $utf8NoBom)
$html = [System.IO.File]::ReadAllText("index.html", $utf8NoBom)

# 1. Nvidia lesson
$html = $html -replace '<li><strong>B&agrave;i h&#7885;c c&#7889;t l&#245;i:</strong> Speed of Light &amp; Stop Overthinking &mdash; B&#7855;t tay v&agrave;o l&agrave;m v&agrave; tinh ch&#7881;nh li&ecirc;n t&#7909;c!</li>', '<li><strong>B&agrave;i h&#7885;c c&#7889;t l&#245;i:</strong><br>- Speed of Light &amp; Stop Overthinking<br>- B&#7855;t tay v&agrave;o l&agrave;m v&agrave; tinh ch&#7881;nh li&ecirc;n t&#7909;c!</li>'
$html = $html -replace '<li><strong>Bài học cốt lõi:</strong> Speed of Light &amp; Stop Overthinking — Bắt tay vào làm và tinh chỉnh liên tục!</li>', '<li><strong>Bài học cốt lõi:</strong><br>- Speed of Light &amp; Stop Overthinking<br>- Bắt tay vào làm và tinh chỉnh liên tục!</li>'

# 2. Phase II title
$html = $html -replace 'PHẦN II: TẦM NHÌN, CẢM HỨNG &amp; TIÊU CHUẨN QUỐC TẾ', 'TẦM NHÌN, CẢM HỨNG &amp; TIÊU CHUẨN QUỐC TẾ'

# 3. Global Standard
$searchGlobal = '<span style="font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 1px;">Chuẩn mực Quản trị Toàn cầu</span>\s*<h4 style="font-size: 1.2rem; font-weight: 800; color: var(--text-primary); margin: 0;">Tiêu chuẩn của các "Ông Lớn" \(Big Corporates\)</h4>'
$replaceGlobal = '<h4 style="font-size: 1.2rem; font-weight: 800; color: var(--text-primary); margin: 0;">Tiêu Chuẩn Toàn cầu của các "Ông Lớn" (Big Corporates)</h4>'
$html = [regex]::Replace($html, $searchGlobal, $replaceGlobal)

# 4. Capitalize "Văn hóa Svvift"
$html = $html -replace 'V&#259;n h&#243;a Svvift', 'V&#194;N H&#211;A SVVIFT'
$html = $html -replace 'Văn hóa Svvift', 'VĂN HÓA SVVIFT'

# 5. Move VAI TRÒ & TRÁCH NHIỆM tag to right side
# Current HTML has:
# <span style="background: rgba(124,58,237,0.1); color: #7C3AED; padding: 4px 10px; border-radius: 6px; font-size: 0.8rem; font-weight: 800; text-transform: uppercase;">VAI TRÒ &amp; TRÁCH NHIỆM</span>
# <h4 style="font-size: 1.15rem; font-weight: 800; color: #7C3AED; margin: 0;">"Điều Duy Nhất" (The One Thing) — Đúng Người, Đúng Việc</h4>
$searchVaiTro = '<span style="background: rgba\(124,58,237,0\.1\); color: #7C3AED; padding: 4px 10px; border-radius: 6px; font-size: 0\.8rem; font-weight: 800; text-transform: uppercase;">VAI TRÒ &amp; TRÁCH NHIỆM</span>\s*<h4 style="font-size: 1\.15rem; font-weight: 800; color: #7C3AED; margin: 0;">"Điều Duy Nhất" \(The One Thing\) — Đúng Người, Đúng Việc</h4>'
$replaceVaiTro = '<span style="background: rgba(124,58,237,0.1); color: #7C3AED; padding: 4px 12px; border-radius: 6px; font-size: 0.75rem; font-weight: 800; letter-spacing: 0.5px; position: absolute; right: 2rem; top: 2rem; text-transform: uppercase;">VAI TRÒ &amp; TRÁCH NHIỆM</span>
                                    <h4 style="font-size: 1.15rem; font-weight: 800; color: #7C3AED; margin: 0;">"Điều Duy Nhất" (The One Thing) — Đúng Người, Đúng Việc</h4>'
$html = [regex]::Replace($html, $searchVaiTro, $replaceVaiTro)

# Need to make sure the parent div of "Điều Duy Nhất" is relative (it's the phase2-card div). It likely already has relative or we can inject it.
$searchPhaseCard = 'id="phan5-execution" class="phase2-card glass-card hover-lift" style="padding: 2.5rem; border-radius: 14px; background: white; border: 1px solid rgba\(0,0,0,0.06\); border-top: 4px solid #7C3AED; box-shadow: 0 10px 30px rgba\(0,0,0,0.04\);">'
$replacePhaseCard = 'id="phan5-execution" class="phase2-card glass-card hover-lift" style="padding: 2.5rem; border-radius: 14px; background: white; border: 1px solid rgba(0,0,0,0.06); border-top: 4px solid #7C3AED; box-shadow: 0 10px 30px rgba(0,0,0,0.04); position: relative;">'
$html = [regex]::Replace($html, $searchPhaseCard, $replacePhaseCard)

[System.IO.File]::WriteAllText("index.html", $html, $utf8NoBom)
Write-Output "Replacements done."
