################################################################
#               Used to download manga chapters                #
#   Created to use in specific sites. May not work on others   #
# Use the url of the first page as the parameter to the script #
#  It does not treat wrong inputs, the download will only fail #
################################################################
PAGE=1
DONE=0
LOCAL_PATH=$(pwd)

if [ "$#" -ne 1 ]; then
	echo Error: Must pass the url of the first page as argument
	echo USage: ./$0 URL
	exit 1
fi

cd /tmp
rm -rf target
#echo 0
#exit 0
echo Starting download
while [ "$DONE" == "0" ]; do
	wget -q -x -H -r -l 1 -A jpg,jpeg -P target $1/$PAGE

	if [ -d "target" ]; then
		rm -rf target/www*
		rm -rf target/*.net

		cd target/*/*/* 2> /dev/null
		if [ "$?" == "0" ]; then
			mv * $PAGE.jpg
			cd - > /dev/null
			rsync -r target/*/* $LOCAL_PATH/mangas
			rm -rf target
			echo Page $PAGE downloaded
			PAGE=$((PAGE+1))
		else
			echo Error: Probably inexistent chapter.
			rm -rf target
			exit 5
		fi
	else
		DONE=1
	fi

	#echo $PAGE
	#echo $DONE
	#sleep 10
done

rm -rf target
echo Download finished
exit 0
