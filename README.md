# IFMDebugTool

[![Version](http://img.shields.io/cocoapods/v/IFMDebugTool.svg?style=flat)](http://cocoapods.org/?q=IFMDebugTool)
 [![Platform](http://img.shields.io/cocoapods/p/IFMDebugTool.svg?style=flat)]()
 [![License](http://img.shields.io/cocoapods/l/IFMDebugTool.svg?style=flat)](https://github.com/JohnWong/iOS-file-manager/blob/master/LICENSE)

Manage your app's file system in browser.

## Screenshot

![Screenshot](https://raw.githubusercontent.com/JohnWong/iOS-file-manager/master/Docs/screenshot.png)

You can click to expand folder or open/download file. Right click to open or delete.

## Installation

Install via Cocoapods:
```
pod 'IFMDebugTool,:configurations => ['Debug']
```

## Access URL

Three ways to get access URL.

### Printed to console after app is started

### Shown after hake your device

![Screenshot](https://raw.githubusercontent.com/JohnWong/iOS-file-manager/master/Docs/device-screenshot.png)

### Find by Bonjour Service

```
dns-sd -B _ifm._tcp local
```

![Screenshot](https://raw.githubusercontent.com/JohnWong/iOS-file-manager/master/Docs/terminal.png)
