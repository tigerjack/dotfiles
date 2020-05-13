#!/usr/bin/env python3
import requests
from sys import argv

def main():
    try:
        res = requests.get(f"http://wttr.in/{argv[1]}?format=+%m+%w🌀")
        if res.status_code == 200:
            if len(res.text) > 20:
                print("Woah!")
            else:
                print(res.text, end="")
        else:
            print(res.status_code, end="")
    except Exception:
        print("!!", end="")

if __name__ == '__main__':
    main()
