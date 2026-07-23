$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$html = [System.IO.File]::ReadAllText("index.html", $utf8NoBom)

# 1. Nvidia title
# "Tốc độ Nvidia — Vươn lên 3.000 Tỷ USD trong 19 tháng"
$html = $html.Replace('T&#7889;c &#273;&#7897; Nvidia &#8212; V&#432;&#417;n l&#234;n 3.000 T&#7927; USD trong 19 th&#225;ng', 'T&#7889;c &#273;&#7897; Nvidia<br>&#272;&#7841;t 3.000 T&#7927; USD trong 19 th&#225;ng')
# Fallback if it's stored in raw Vietnamese text
$html = $html.Replace('Tốc độ Nvidia — Vươn lên 3.000 Tỷ USD trong 19 tháng', 'Tốc độ Nvidia<br>Đạt 3.000 Tỷ USD trong 19 tháng')
$html = $html.Replace('Tốc độ Nvidia - Vươn lên 3.000 Tỷ USD trong 19 tháng', 'Tốc độ Nvidia<br>Đạt 3.000 Tỷ USD trong 19 tháng')

# 2. Hyundai title
# "Tinh thần Hyundai — Đóng tàu khi chưa có xưởng"
$html = $html.Replace('Tinh th&#7847;n Hyundai &#8212; &#272;&#243;ng t&#224;u khi ch&#432;a c&#243; x&#432;&#7903;ng', 'Tinh th&#7847;n Hyundai<br>&#272;&#243;ng t&#224;u khi ch&#432;a c&#243; x&#432;&#7903;ng')
# Fallback
$html = $html.Replace('Tinh thần Hyundai — Đóng tàu khi chưa có xưởng', 'Tinh thần Hyundai<br>Đóng tàu khi chưa có xưởng')
$html = $html.Replace('Tinh thần Hyundai - Đóng tàu khi chưa có xưởng', 'Tinh thần Hyundai<br>Đóng tàu khi chưa có xưởng')

# 3. Hyundai Lesson
# "Bài học cốt lõi: Sự táo bạo, tư duy không giới hạn và khả năng thích ứng cực nhanh (Quick Adapt). Không sợ hãi!"
# Note: It's wrapped in a <ul><li> in the original code. Let's replace the whole li content.
$oldLesson = '<li><strong>Bài học cốt lõi:</strong> Sự táo bạo, tư duy không giới hạn và khả năng thích ứng cực nhanh (Quick Adapt). Không sợ hãi!</li>'
$newLesson = '<li><strong>Bài học cốt lõi:</strong><br>- Sự táo bạo, tự không giới hạn<br>- Khả năng thích ứng nhanh. Không sợ hãi</li>'
$html = $html.Replace($oldLesson, $newLesson)

# Fallback in case of HTML entities or weird characters
$html = [regex]::Replace($html, '<li><strong>B.i h.c c.t l.i:</strong> S. t.o b.o, t. duy kh.ng gi.i h.n v. kh. n.ng th.ch .ng c.c nhanh \(Quick Adapt\)\. Kh.ng s. h.i!</li>', $newLesson)

# 4. Chuyên nghiệp bài bản
$html = $html.Replace('Chuyên nghiệp tuyệt đối', 'Chuyên nghiệp bài bản')

# 5. MÔ HÌNH VẬN HÀNH MỚI
$html = $html.Replace('MÔ HÌNH VẬN HÀNH "CON THUYỀN MỚI"', 'MÔ HÌNH VẬN HÀNH MỚI')
$html = $html.Replace('MÔ HÌNH VẬN HÀNH &quot;CON THUYỀN MỚI&quot;', 'MÔ HÌNH VẬN HÀNH MỚI')

# 6. Đội Ngũ Tinh Nhuệ
$html = $html.Replace('Con Người Tinh Nhuệ', 'Đội Ngũ Tinh Nhuệ')

# 7. NHÂN SỰ (HR - GA)
$html = $html.Replace('NHÂN SỰ &amp; HÀNH CHÍNH (HR - GA)', 'NHÂN SỰ (HR - GA)')
$html = $html.Replace('NHÂN SỰ & HÀNH CHÍNH (HR - GA)', 'NHÂN SỰ (HR - GA)')

# 8. NHÂN TÀI & KỶ LUẬT
$html = $html.Replace('NHÂN TÀI &amp; TUÂN THỦ', 'NHÂN TÀI & KỶ LUẬT')
$html = $html.Replace('NHÂN TÀI & TUÂN THỦ', 'NHÂN TÀI & KỶ LUẬT')

[System.IO.File]::WriteAllText("index.html", $html, $utf8NoBom)
Write-Output "Replacements done."
