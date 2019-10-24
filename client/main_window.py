import sys
from PySide2.QtWidgets import QApplication, QMainWindow, QLabel, QWidget, QHBoxLayout, QPushButton
from usb_interface import USBInterface


class MainWindow(QMainWindow):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle('AGC Monitor')

        self._usbif = USBInterface()
        self._usbif.connected.connect(self.connected)

        self.setup_ui()

    def setup_ui(self):
        status_bar = self.statusBar()
        self._status = QLabel('Test')
        status_bar.addWidget(self._status)

        # Create a central widget, give it a layout, and set it up
        central = QWidget(self)
        self.setCentralWidget(central)
        layout = QHBoxLayout(central)
        central.setLayout(layout)
        layout.setSpacing(0)
        layout.setMargin(0)

        b = QPushButton(central, text="Push")
        b.clicked.connect(self.test)
        layout.addWidget(b)

    def connected(self, connected):
        if connected:
            message = 'Connected!'
        else:
            message = 'Device not found.'

        self._status.setText(message)

    def test(self):
        print("Clicked!")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow(None)
    window.show()
    app.exec_()
