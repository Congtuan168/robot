from robot.api.deco import keyword
import re
import os
import pygetwindow as gw
import pyautogui
import os, time, sys
import uiautomator2 as u2


class Helper:
    def __init__(self):
        pass

    @keyword('Get Text')
    def findText(sefl, text):
        pattern = r"thế sao = (.+)"
        match = re.search(pattern, text)

        # Lưu kết quả vào biến
        result = match.group(1) if match else None
        return result

    @keyword('ScreenShot')
    def get_window(self, window_name, save_path):
        target_window = gw.getWindowsWithTitle(window_name)

        # Check if the file exists and delete it
        if os.path.exists(save_path):
            os.remove(save_path)
            print(f"Old screenshot deleted: {save_path}")

        if target_window:
            # Get the first window matching the name
            window = target_window[0]

            # Get the bounding box of the window
            left, top, right, bottom = (
                window.left,
                window.top,
                window.right,
                window.bottom,
            )

            # Capture the screenshot of the specified window
            screenshot = pyautogui.screenshot(region=(left, top, right - left, bottom - top))

            # Save the new screenshot
            screenshot.save(save_path)
            print(f"New screenshot saved at: {save_path}")
        else:
            print(f"No window found with the name: {window_name}")

    @keyword('Click by text')
    def clickByText(sefl, device_serial, textObject):
        try:
            device = u2.connect(device_serial)
        except Exception as e:
            print(e)
        timeout = 10
        start_time = time.time()
        while time.time() - start_time < timeout:
            if device(text=textObject).exists:
                device(text=textObject).click()
                break
            else:
                time.sleep(1)
        if not device(text=textObject).exists:
            print("Object not found within the timeout period")

    @keyword('Scroll into view')
    def scrollIntoView(sefl, device_serial, textObject):
        try:
            device = u2.connect(device_serial)
        except Exception as e:
            print(e)
        device(scrollable=True).scroll.to(text=textObject)

    @keyword('Find text on screen')
    def findTextOnScreen(self, device_serial, textObject):
        try:
            device = u2.connect(device_serial)
        except Exception as e:
            print(e)
        timeout = 3
        start_time = time.time()
        while time.time() - start_time < timeout:
            if device(text=textObject).exists:
                return True
            time.sleep(1)

        print("Object not found within the timeout period")
        return False

if __name__ == '__main__':
    find = Helper()
