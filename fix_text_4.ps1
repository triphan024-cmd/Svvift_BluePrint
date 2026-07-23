$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines("index.html", $utf8NoBom)
$newLines = New-Object System.Collections.Generic.List[string]

$inCoChe = $false
$coCheLines = New-Object System.Collections.Generic.List[string]

# Pass 1: Extract CƠ CHẾ KIỂM SOÁT BẮT BUỘC
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Contains("<!-- CƠ CHẾ KIỂM SOÁT BẮT BUỘC -->") -or $lines[$i].Contains("<!-- C") -and $lines[$i].Contains("B") -and $lines[$i].Contains("C -->") -and $lines[$i].Contains("KI")) {
        $inCoChe = $true
        # Add a top margin for separation from the dept cards
        $coCheLines.Add('                            <div style="margin-top: 3rem;">')
        continue
    }
    
    if ($inCoChe) {
        if ($lines[$i].Trim() -eq "</div>" -and $lines[$i-1].Trim() -eq "</div>" -and $lines[$i-2].Trim() -eq "</div>") {
            # We reached the end of the Co che block. Actually let's just count divs. 
            # It's safer to just find the exact lines 1453 to 1485
        }
    }
}
