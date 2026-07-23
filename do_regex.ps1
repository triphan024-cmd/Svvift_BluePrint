$content = [System.IO.File]::ReadAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", [System.Text.Encoding]::UTF8)

# 1. Replace VAI TRÒ & TRÁCH NHIỆM block layout
$pattern1 = '<div style="display: flex; align-items: center; gap: 10px; margin-bottom: 1.25rem;">\s*<span[^>]*>VAI TRÒ & TRÁCH NHIỆM</span>\s*<h4[^>]*>"Điều Duy Nhất" \(The One Thing\)[^<]*</h4>\s*</div>'
$replacement1 = '<div style="display: flex; align-items: flex-start; justify-content: space-between; gap: 1rem; margin-bottom: 1.25rem; border-bottom: 2px solid rgba(124,58,237,0.1); padding-bottom: 1rem;">
                                      <div>
                                          <h4 style="font-size: 1.25rem; font-weight: 800; color: var(--text-primary); margin: 0 0 0.25rem 0;">"Điều Duy Nhất" (The One Thing)</h4>
                                          <p style="font-size: 0.875rem; color: var(--text-secondary); font-style: italic; margin: 0;">Đúng Người, Đúng Việc</p>
                                      </div>
                                      <span style="font-size: 0.75rem; font-weight: 800; color: #7C3AED; background: rgba(124,58,237,0.08); padding: 4px 12px; border-radius: 20px;">VAI TRÒ & TRÁCH NHIỆM</span>
                                  </div>'
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern1, $replacement1)

# 2. Replace QUẢN TRỊ TÀI SẢN background badge with plain text
$pattern2 = '<div style="margin-top: 0.4rem;"><span[^>]*>QUẢN TRỊ TÀI SẢN</span></div>'
$replacement2 = '<div style="margin-top: 0.4rem; font-size: 0.75rem; font-weight: 700; color: #DC2626; text-transform: uppercase;">QUẢN TRỊ TÀI SẢN</div>'
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern2, $replacement2)

# 3. Replace the corrupted "LỊCH HOẠT ĐỘNG ĐỊNH KỲ" header with "CƠ CHẾ KIỂM SOÁT BẮT BUỘC"
$pattern3 = '<!-- L.*?K.*?-->\s*<hr[^>]*>\s*<div>\s*<h4[^>]*>\s*<span[^>]*>.*?</span>.*?L.*?K.*?\s*</h4>'
$replacement3 = '<!-- CƠ CHẾ KIỂM SOÁT BẮT BUỘC -->
                              <hr style="border: 0; height: 1px; background: rgba(0,0,0,0.06); margin: 2.5rem 0;">
                              <div>
                                  <h4 style="font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin-bottom: 1.25rem; display: flex; align-items: center; gap: 8px;">
                                      <span>⚠️</span> CƠ CHẾ KIỂM SOÁT BẮT BUỘC
                                  </h4>'
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern3, $replacement3, [System.Text.RegularExpressions.RegexOptions]::Singleline)

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("c:\Users\PC Tri\Antigravity\Blue Print\index.html", $content, $utf8NoBom)
Write-Host "Regex replacements applied."
