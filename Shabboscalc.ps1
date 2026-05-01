# Current time
$now = Get-Date

# Hebcal API for Teaneck (geonameid 5105262)
$url = "https://www.hebcal.com/shabbat?cfg=json&geonameid=5105262&m=50"

# Fetch Shabbos times
$result = Invoke-RestMethod -Uri $url

# Find candle-lighting event
$candleEvent = $result.items | Where-Object { $_.category -eq "candles" }

# Extract candle-lighting time
$candle = [DateTime]$candleEvent.date

# Time difference
$diff = $candle - $now

if ($diff.TotalMinutes -le 0) {
    Write-Host "Shabbos is now"
    return
}

# Convert to hours + minutes
$hours = [int]$diff.TotalHours
$minutes = $diff.Minutes

Write-Host "Shabbos in $hours hours and $minutes minutes"
