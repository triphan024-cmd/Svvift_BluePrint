$content = [System.IO.File]::ReadAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", [System.Text.Encoding]::UTF8)

# 1. Bullet points cho Hyundai và Nvidia
$content = $content.Replace(
    '<li><strong>Bài học cốt lõi:</strong> Sự táo bạo, tư duy không giới hạn. Khả năng thích ứng nhanh. Không sợ hãi</li>',
    '<strong>Bài học cốt lõi:</strong><ul style="margin-top: 0.25rem; margin-bottom: 0; padding-left: 1.25rem; list-style-type: disc;"><li>Sự táo bạo, tư duy không giới hạn</li><li>Khả năng thích ứng nhanh. Không sợ hãi</li></ul>'
)

$content = $content.Replace(
    '<li><strong>Bài học cốt lõi:</strong> Speed of Light & Stop Overthinking — Bắt tay vào làm và tinh chỉnh liên tục!</li>',
    '<strong>Bài học cốt lõi:</strong><ul style="margin-top: 0.25rem; margin-bottom: 0; padding-left: 1.25rem; list-style-type: disc;"><li>Speed of Light & Stop Overthinking</li><li>Bắt tay vào làm và tinh chỉnh liên tục!</li></ul>'
)

# 2. Xuống dòng CHIẾN LƯỢC 12 TUẦN NÂNG CẤP TOÀN DIỆN
$content = $content.Replace(
    '>CHIẾN LƯỢC 12 TUẦN NÂNG CẤP TOÀN DIỆN<',
    '>CHIẾN LƯỢC 12 TUẦN NÂNG CẤP<br>TOÀN DIỆN<'
)

# 3. Text replacements
$content = $content.Replace(
    'Tất cả mọi người đều muốn tăng lương, nhưng lại không chịu làm những việc khác đi để xứng đáng với điều đó.',
    'Tất cả mọi người đều muốn tăng lương, nhưng lại chưa hành động cụ thể nào để thực hiện việc này.'
)

$content = $content.Replace(
    'Duy trì tư duy xưởng lắp ráp sẽ làm công ty không thể bứt phá và thu nhập mãi <strong>dậm chân tại chỗ</strong>.',
    'Duy trì vận hành như hiện tại thì thu nhập mãi dậm chân tại chỗ.'
)

$content = $content.Replace(
    'Nâng cấp nhà máy thành một <strong>trung tâm sản xuất có tư duy, có hệ thống và tạo giá trị cao</strong>.',
    'Nâng cấp thành một nhà máy sản xuất hiện đại thông minh có tư duy, có hệ thống và tạo ra giá trị cao.'
)

# 4. Phase III Title and Card Contents
$content = $content.Replace('⚡ PHẦN III — PRACTICAL EXECUTION', '⚡ PHẦN III — CORE VALUES')
$content = $content.Replace('ỨNG DỤNG THỰC TẾ', 'GIÁ TRỊ CỐT LÕI')

$content = $content.Replace(
    '<li>Chính sách chuẩn hóa toàn diện.</li>
                                                    <li>Minh bạch <strong>Vai trò & Trách nhiệm (R&R)</strong>.</li>
                                                    <li>Mục tiêu <strong>SMART</strong> loại bỏ phỏng đoán.</li>',
    '<li>Thiết lập mới Sơ đồ Tổ chức</li>
                                                    <li>Vai trò & Trách nhiệm (R&R) rõ ràng</li>'
)

$content = $content.Replace('Công Cụ Số Hóa', 'Công Cụ Hiện Đại')

$content = $content.Replace(
    '<li><strong>1 App tập trung duy nhất</strong> cho toàn công ty.</li>
                                                    <li>Đúng công cụ cho đúng việc theo phân hệ.</li>
                                                    <li>Số hóa đo lường 100% hoạt động.</li>',
    '<li>1 App tập trung duy nhất</li>
                                                    <li>Đúng công cụ cho đúng việc theo phân hệ.</li>'
)

$content = $content.Replace(
    '<li><strong>Đội đặc nhiệm (Special Forces)</strong> tinh nhuệ.</li>
                                                    <li>Trang bị kỹ năng & kỷ luật thép.</li>
                                                    <li>Tuân thủ SOP tuyệt đối không ngoại lệ.</li>',
    '<li>Đội đặc nhiệm (Special Forces) tinh nhuệ.</li>
                                                    <li>Trang bị kỹ năng & kỷ luật thép.</li>'
)

# 5. Move "Có tổ chức" tags
# First remove it from old place
$oldTags = '                                    <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                                        <span style="background: rgba(30,58,138,0.08); color: var(--accent-primary); font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Có tổ chức (Organized)</span>
                                        <span style="background: rgba(180,83,9,0.08); color: #B45309; font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Có hệ thống (Systematic)</span>
                                        <span style="background: rgba(16,185,129,0.08); color: #059669; font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Chuyên nghiệp bài bản</span>
                                    </div>'

$content = $content.Replace($oldTags, '')

# Now insert it below the bullet list
$targetList = '<li>Học tập kinh nghiệm vận hành thực chiến từ các tập đoàn đa quốc gia hàng đầu:</li>
                                </ul>'

$newTags = '<li>Học tập kinh nghiệm vận hành thực chiến từ các tập đoàn đa quốc gia hàng đầu:</li>
                                </ul>
                                <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 1.5rem; padding-left: 1.2rem;">
                                    <span style="background: rgba(30,58,138,0.08); color: var(--accent-primary); font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Có tổ chức (Organized)</span>
                                    <span style="background: rgba(180,83,9,0.08); color: #B45309; font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Có hệ thống (Systematic)</span>
                                    <span style="background: rgba(16,185,129,0.08); color: #059669; font-weight: 800; font-size: 0.8rem; padding: 4px 10px; border-radius: 6px;">● Chuyên nghiệp bài bản</span>
                                </div>'
$content = $content.Replace($targetList, $newTags)

# 6. Phase I and Phase II Title format updates
# Remove old Phase I inner header
$oldPhase1Inner = '<div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1.5rem; border-bottom: 2px solid rgba(220,38,38,0.1); padding-bottom: 0.75rem;">
                                <h3 style="font-size: 1.25rem; font-weight: 800; color: #DC2626; text-transform: uppercase; letter-spacing: 0.5px; margin: 0; display: flex; align-items: center; gap: 10px;">
                                    <span>🔍</span> I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA
                                </h3>
                                <span style="font-size: 0.75rem; font-weight: 800; color: #DC2626; background: rgba(220,38,38,0.08); padding: 4px 12px; border-radius: 20px;">TRUTH AUDIT</span>
                            </div>'
$content = $content.Replace($oldPhase1Inner, '')

# Inject new Phase I big header BEFORE `<div id="phan1-truth"`
$newPhase1Header = '<div class="section-header observe" style="text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;">
                            <div style="display: inline-flex; align-items: center; gap: 8px; background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;">
                                <span style="font-size: 0.75rem; font-weight: 800; color: #DC2626; text-transform: uppercase; letter-spacing: 2px;">⚠️ PHẦN I — TRUTH AUDIT</span>
                            </div>
                            <h2 class="section-title" style="margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;">
                                <span style="background: linear-gradient(135deg, #DC2626 0%, #B91C1C 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;">I. VỊ THẾ HIỆN TẠI CỦA CHÚNG TA</span>
                            </h2>
                            <div style="width: 60px; height: 4px; background: linear-gradient(90deg, #DC2626, #991B1B); margin: 0.75rem auto 0; border-radius: 4px;"></div>
                        </div>'
$content = $content.Replace('<div id="phan1-truth"', "$newPhase1Header`n                        <div id=""phan1-truth""")

# Remove old Phase II inner header
$oldPhase2Inner = '<div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1.5rem; border-bottom: 2px solid rgba(30,58,138,0.1); padding-bottom: 0.75rem;">
                                <h3 style="font-size: 1.25rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 0.5px; margin: 0; display: flex; align-items: center; gap: 10px;">
                                    <span>🌍</span> TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ
                                </h3>
                                <span style="font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); background: rgba(30,58,138,0.08); padding: 4px 12px; border-radius: 20px;">GLOBAL STANDARDS</span>
                            </div>'
$content = $content.Replace($oldPhase2Inner, '')

# Inject new Phase II big header BEFORE `<div id="phan2-vision"`
$newPhase2Header = '<div class="section-header observe" style="text-align: center; margin-top: 1rem; margin-bottom: 2rem; position: relative;">
                            <div style="display: inline-flex; align-items: center; gap: 8px; background: rgba(30,58,138,0.06); border: 1px solid rgba(30,58,138,0.15); padding: 5px 16px; border-radius: 20px; margin-bottom: 0.5rem;">
                                <span style="font-size: 0.75rem; font-weight: 800; color: var(--accent-primary); text-transform: uppercase; letter-spacing: 2px;">🌍 PHẦN II — GLOBAL STANDARDS</span>
                            </div>
                            <h2 class="section-title" style="margin: 0; font-size: clamp(1.8rem, 3.2vw, 2.6rem); line-height: 1.25; text-transform: uppercase;">
                                <span style="background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 50%, #10B981 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 900;">TẦM NHÌN, CẢM HỨNG & TIÊU CHUẨN QUỐC TẾ</span>
                            </h2>
                            <div style="width: 60px; height: 4px; background: linear-gradient(90deg, #1E3A8A, #10B981); margin: 0.75rem auto 0; border-radius: 4px;"></div>
                        </div>'
$content = $content.Replace('<div id="phan2-vision"', "$newPhase2Header`n                        <div id=""phan2-vision""")

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", $content, $utf8NoBom)
Write-Host "Done!"
