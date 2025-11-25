import subprocess
import time

import uiautomator2 as u2
from robot.api.deco import keyword
from robot.model import Keyword


class Android2:
    def __init__(self):
        pass

    @keyword('Is Text Existed')
    def IsTextExist(self, serial_number, text_to_find):
        try:
            device = u2.connect(serial_number)
        except Exception as e:
            print(e)
        timeout = 1
        start_time = time.time()
        while time.time() - start_time < timeout:
            if device(text=text_to_find).exists:
                return True
            time.sleep(1)

        print("Object not found within the timeout period")
        return False

    # ý tưởng: Reuse function IsTextExist to find out the expected text. This Function is to scroll until find the text on screen
    @keyword('Scrolling')
    def Scrolling(self, serial_number, command):
        try:
            command_parts = command.split()
            full_command = ["adb", "-s", serial_number, "shell"] + command_parts
            results = subprocess.run(
                full_command,
                capture_output=True,
                text=True,
                check=False
            )

            if results.returncode == 0:
                print(f'Command executed successfully', results.stdout)

            else:
                print(f"Error executing command", results.stderr)
        except Exception as e:
            print(f"An error occurred:", e)

    @keyword('Get Dynamic Text By ID')
    def get_dynamic_text_by_id(self, device_serial, resource_id):
        """
        Lấy văn bản hiện tại (dynamic text) từ một thành phần UI cố định.

        Tham số:
        - device_serial: Serial thiết bị.
        - resource_id: Resource ID cố định của TextView (ví dụ: com.android.settings:id/battery_info_summary).

        Trả về: Chuỗi văn bản hiện tại (ví dụ: "1 ngày và 6 giờ còn lại").
        """
        try:
            device = u2.connect(device_serial)
        except Exception as e:
            raise Exception(f"Lỗi kết nối uiautomator2: {e}")

        # Tìm kiếm bằng Resource ID (thuộc tính cố định)
        element = device(resourceId=resource_id)

        if element.exists:
            # Lấy giá trị của thuộc tính 'text' từ element
            dynamic_text = element.info['text']
            print(f"Đã lấy được văn bản: {dynamic_text}")
            return dynamic_text
        else:
            raise AssertionError(f"Không tìm thấy element có ID '{resource_id}' trên màn hình.")
if __name__ == '__main__':
    android = Android2()
