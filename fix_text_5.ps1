$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines("index.html", $utf8NoBom)
$result = New-Object System.Collections.Generic.List[string]

$coCheLines = New-Object System.Collections.Generic.List[string]
$inCoChe = $false

# Extract CƠ CHẾ KIỂM SOÁT BẮT BUỘC
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Contains("<!--") -and $lines[$i].Contains("KI") -and $lines[$i].Contains("M SO") -and $lines[$i].Contains("T B") -and $lines[$i].Contains("T BU")) {
        $inCoChe = $true
        $coCheLines.Add('                            <!-- CO CHE KIEM SOAT BAT BUOC (Moved) -->')
    }
    
    if ($inCoChe) {
        if (-not $lines[$i].Contains("<!--") -and -not $lines[$i].Contains("<hr")) {
            $coCheLines.Add($lines[$i])
        }
        
        # Stop at the end of the block (which is followed by 2 closing divs of the whole section, so when we see </div></div>)
        if ($lines[$i].Trim() -eq "</div>" -and ($i+1) -lt $lines.Length -and $lines[$i+1].Trim() -eq "</div>" -and ($i+2) -lt $lines.Length -and $lines[$i+2].Trim() -eq "</div>") {
            $inCoChe = $false
        }
    }
}

$skipCoChe = $false
for ($i = 0; $i -lt $lines.Length; $i++) {
    
    # Remove old Co che
    if ($lines[$i].Contains("<!--") -and $lines[$i].Contains("KI") -and $lines[$i].Contains("M SO") -and $lines[$i].Contains("T B") -and $lines[$i].Contains("T BU")) {
        $skipCoChe = $true
        # also remove the <hr> above it if we can, but let's just skip the hr if it's there
    }
    
    # We want to skip the <hr> that is right before Co che
    if ($lines[$i].Contains("<hr") -and $lines[$i+2].Contains("KI") -and $lines[$i+2].Contains("M SO")) {
        continue
    }

    if ($skipCoChe) {
        if ($lines[$i].Trim() -eq "</div>" -and ($i+1) -lt $lines.Length -and $lines[$i+1].Trim() -eq "</div>" -and ($i+2) -lt $lines.Length -and $lines[$i+2].Trim() -eq "</div>") {
            $skipCoChe = $false
            continue
        }
        continue
    }
    
    # Insert before the closing div of "Điều Duy Nhất"
    # We know the closing div is right before <!-- PHẦN VI...
    if ($lines[$i].Contains("<!--") -and $lines[$i].Contains("VI:") -and $lines[$i].Contains("12") -and $lines[$i].Contains("TR")) {
        # We need to backtrack and find the right place to insert.
        # Actually it's easier to find the end of the department cards:
        # Dept 6 ends with </div>, then grid ends with </div>
    }
    
    $result.Add($lines[$i])
}

# The problem with the above logic is it might be brittle.
# Let's use string manipulation on the entire text instead for moving the block!
