$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$html = [System.IO.File]::ReadAllText("index.html", $utf8NoBom)

# Block 1: Move "CƠ CHẾ KIỂM SOÁT BẮT BUỘC"
# Find the block starting with <hr... up to the end of the Co Che div.
# We know it's located right after the closing of "MÔ HÌNH VẬN HÀNH MỚI" section and before the footer.
$startPattern = '<hr style="border: 0; height: 1px; background: rgba\(0,0,0,0\.06\); margin: 2\.5rem 0;">\s*<!--.*?KIỂM SOÁT BẮT BUỘC.*?-->\s*<div>\s*<h4.*?>\s*<span>.*?</span>.*?KIỂM SOÁT BẮT BUỘC\s*</h4>\s*<div style="display: grid.*?</div>\s*</div>'
# Since regex might be tricky with Vietnamese, let's use IndexOf.
$coCheKeyword = "<!-- C" + [char]0x01A0 + " CH" + [char]0x1EBE + " KI" + [char]0x1EC2 + "M SO" + [char]0x00C1 + "T B" + [char]0x1EAE + "T BU" + [char]0x1ED8 + "C -->"

# Let's search by something simpler in ASCII:
$startMarker = '<!-- C'
$htmlLines = $html -split "`n"
$startIndex = -1
$endIndex = -1
$insertIndex = -1

for ($i = 0; $i -lt $htmlLines.Length; $i++) {
    if ($htmlLines[$i].Contains("<!-- C") -and $htmlLines[$i].Contains("KI") -and $htmlLines[$i].Contains("M SO") -and $htmlLines[$i].Contains("T B") -and $htmlLines[$i].Contains("T BU")) {
        $startIndex = $i
    }
    if ($startIndex -ne -1 -and $i -gt $startIndex) {
        if ($htmlLines[$i].Trim() -eq "</div>" -and ($i+1) -lt $htmlLines.Length -and $htmlLines[$i+1].Trim() -eq "</div>" -and ($i+2) -lt $htmlLines.Length -and $htmlLines[$i+2].Trim() -eq "</div>") {
            $endIndex = $i
            break
        }
    }
}

for ($i = 0; $i -lt $htmlLines.Length; $i++) {
    if ($htmlLines[$i].Contains("<!-- PH") -and $htmlLines[$i].Contains("N VI:") -and $htmlLines[$i].Contains("12")) {
        $insertIndex = $i - 5 # Backtrack 5 lines to get inside the "Điều Duy Nhất" div
        break
    }
}

if ($startIndex -ne -1 -and $endIndex -ne -1 -and $insertIndex -ne -1) {
    $coCheBlock = $htmlLines[$startIndex..$endIndex]
    
    # Check if there is an <hr> right above it, remove it too
    $removeStart = $startIndex
    if ($htmlLines[$startIndex - 2].Contains("<hr")) {
        $removeStart = $startIndex - 2
    }
    
    # We will build a new list
    $newLines = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt $htmlLines.Length; $i++) {
        if ($i -eq $insertIndex) {
            $newLines.Add('                            <hr style="border: 0; height: 1px; background: rgba(0,0,0,0.06); margin: 2.5rem 0;">')
            foreach ($line in $coCheBlock) {
                $newLines.Add($line)
            }
        }
        
        if ($i -ge $removeStart -and $i -le $endIndex) {
            continue # skip the old block
        }
        
        $newLines.Add($htmlLines[$i])
    }
    
    $html = $newLines -join "`n"
}

[System.IO.File]::WriteAllText("index.html", $html, $utf8NoBom)
Write-Output "Done moving block."
