#!/bin/bash
configFile='../config/config.json'
url0=`cat ${configFile} | python3 -c "import sys, json; print(json.load(sys.stdin)['urls'][0])"`
cookies=`cat ${configFile} | python3 -c "import sys, json; print(json.load(sys.stdin)['cookies'])"`
sourceName=`cat ${configFile} | python3 -c "import sys, json; print(json.load(sys.stdin)['sourceName'])"`
storage=`cat ${configFile} | python3 -c "import sys, json; print(json.load(sys.stdin)['storage'])"`
folderStorage=${storage}${sourceName}
mkdir -p ${folderStorage}
pushd ${folderStorage}
dateNow=`date +%Y%m%d`
seqNo=0
MAX_SEQ=100000
headers='\-d --header="User-Agent: Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11"'

while [ ${seqNo} -le $MAX_SEQ ]; do
	echo "Downloading ${seqNo}"
	downloadLink=${url0}${seqNo}${cookies}
	echo "["${downloadLink}"]"
	someheader="-d --header='User-Agent: Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'"
	# wget "$someheader"
	# wget "$someheader" -O ${seqNo}.ts ${downloadLink}
	/mnt/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe ${downloadLink}
	ps aux | grep firefox
	kill '/mnt/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe'
	# find . -size  0 -print0 | xargs -0 rm
	# vlc --one-instance --playlist-enqueue ${seqNo}.ts & 
	# /mnt/c/Program\ Files\ \(x86\)/VideoLAN/VLC/vlc.exe --one-instance --playlist-enqueue ${seqNo}.ts & 
	let seqNo=seqNo+1
done
echo "Deleting irrelevent files.."
find *.ts -size  0 -print0 | xargs -0 rm
cat *.ts > all_ts
ffmpeg -i all_ts -acodec copy -vcodec copy ${sourceName}"_"${dateNow}.mp4
# ffmpeg -f concat -i <(for f in *.ts; do echo "file '$f'"; done) -c copy Full.ts
echo "Done!"
popd
exit 0