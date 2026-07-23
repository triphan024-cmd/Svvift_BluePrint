$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines("index.html", $utf8NoBom)
$list = New-Object System.Collections.Generic.List[string]
$list.AddRange($lines)

$startIdx = -1
$endIdx = -1
$insertIdx = -1

for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i].Contains("<!-- C") -and $list[$i].Contains("KI") -and $list[$i].Contains("M SO") -and $list[$i].Contains("B") -and $list[$i].Contains("C -->")) {
        $startIdx = $i
    }
}

# The block ends exactly when we see three </div> (ignoring empty lines) or before </section>
# Let's just find the exact line numbers from the previous output: start=1454
# Let's verify line 1489 is </div>
$endIdx = 1489
if ($list[$endIdx].Trim() -ne "</div>") {
    # search around
    for ($j = 1480; $j -lt 1500; $j++) {
        if ($list[$j].Contains("</div>") -and $list[$j+2].Contains("</div>") -and $list[$j+4].Contains("</div>") -and $list[$j+5].Contains("</div>")) {
            $endIdx = $j + 2
            break
        }
    }
}

for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i].Contains("<!-- PH") -and $list[$i].Contains("N VI:") -and $list[$i].Contains("12")) {
        $insertIdx = $i - 5
        break
    }
}

Write-Output "startIdx=$startIdx, endIdx=$endIdx, insertIdx=$insertIdx"

if ($startIdx -ne -1 -and $endIdx -ne -1 -and $insertIdx -ne -1) {
    $removeStart = $startIdx
    if ($startIdx -ge 2 -and $list[$startIdx - 2].Contains("<hr")) {
        $removeStart = $startIdx - 2
    }
    
    $block = New-Object System.Collections.Generic.List[string]
    $block.Add('                            <hr style="border: 0; height: 1px; background: rgba(0,0,0,0.06); margin: 2.5rem 0;">')
    for ($i = $startIdx; $i -le $endIdx; $i++) {
        $block.Add($list[$i])
    }
    
    $list.InsertRange($insertIdx, $block)
    
    if ($insertIdx -lt $removeStart) {
        $removeStart += $block.Count
        $endIdx += $block.Count
    }
    
    $list.RemoveRange($removeStart, $endIdx - $removeStart + 1)
    
    [System.IO.File]::WriteAllLines("index.html", $list.ToArray(), $utf8NoBom)
    Write-Output "Move successful."
} else {
    Write-Output "Move failed due to missing index."
}
