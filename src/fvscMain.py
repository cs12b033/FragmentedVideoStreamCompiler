import os, sys, subprocess, json
from time import sleep
import requests as req

def vRequestLib():
	for seqNo in range(1, 100000):
		downloadUrl = config["urls"][0] + str(seqNo) + config["urls"][1]
		cookies = config["cookies"]
		print("url:{" + downloadUrl + "}, cookies:{", cookies, "}")
		resp = req.get(
		    downloadUrl,
		    headers={"User-Agent": "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11"},
		    cookies=cookies,
		)
		print(resp.json())
		print(resp.status_code)
		print(resp.content)
		sleep(10)
		
	print("All files downloaded")
	return

def vFirefox():
	for seqNo in range(1, 100000):
		downloadUrl=config["urls"][0] + str(seqNo) + config["cookies"]
		print("[" + downloadUrl + "]")
		downloadViaFirefoxCMD=["C:/Program Files (x86)/Mozilla Firefox/firefox.exe", downloadUrl]
		p = subprocess.Popen(downloadViaFirefoxCMD, shell = True, stdout=subprocess.PIPE)
		sleep(10)
		killFirefoxCMD=["taskkill", "-f", "-im", "firefox.exe"]
		p = subprocess.Popen(killFirefoxCMD, shell = True, stdout=subprocess.PIPE)
		sleep(1)
	print("All files downloaded")

	# print("Shutting down...")
	# shutdownCMD=["shutdown", "-s", "-t", "60"]
	# p = subprocess.Popen(killFirefoxCMD, shell = True, stdout=subprocess.PIPE)
	return

def vCurlUnixLib():

	return


if __name__ == '__main__':
	configFilePath="../config/config.json"
	with open(configFilePath) as cf:
		config = json.load(cf)
	methods = {
		0: vRequestLib,
		1: vFirefox,
		2: vCurlUnixLib,
	}
	method = 0
	resp = methods.get(method, exit)()
	print(resp, " >> Done!")