#!/usr/bin/python2

import pynotify
pynotify.init("test")
notice = pynotify.Notification("Hi", "man", None)
notice.show()
