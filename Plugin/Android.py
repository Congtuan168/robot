# from symtable import Symbol
from robot.api.deco import keyword
from ppadb.client import Client as AdbClient
import subprocess


class Android:
    @keyword('Shell')
    def send_adb_command(self, device_id, command):
        try:
            result = subprocess.run(
                ["adb", "-s", device_id, "shell", command],
                capture_output=True,
                text=True
            )
            if result.returncode == 0:
                print(f"Command executed successfully:\n{result.stdout}")
            else:
                print(f"Error executing command:\n{result.stderr}")
        except Exception as e:
            print(f"An error occurred: {e}")

    @keyword('Connect Adb server')
    def connect_to_device(self, device_id):
        client = AdbClient(host="127.0.0.1", port=5037)
        device = client.device(device_id)
        if device is None:
            print("Unable to connect to the device.")
            return None
        print("Device connected successfully.")
        return device

    @keyword('Disconnect Adb server')
    def send_adb_server_command(self, device, command):
        try:
            result = device.shell(command)
            print(result)
        except Exception as e:
            print(f"An error occurred while sending the command: {e}")


if __name__ == "__main__":
    device_id = "emulator-5554"
    android = Android()
    device = android.connect_to_device(device_id)
