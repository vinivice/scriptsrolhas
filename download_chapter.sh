PAGE=1
DONE=0

if [ "$#" -ne 1 ]; then
	echo Error: Must pass the url of the first page as argument
	exit 1
fi

#echo 0
#exit 0
echo Starting download
while [ "$DONE" == "0" ]; do
	wget -q -x -H -r -l 1 -A jpg,jpeg -P target $1/$PAGE

	if [ -d "target" ]; then
		rm -r target/www*
		rm -r target/*.net

		cd target/*/*/*
		mv * $PAGE.jpg
		cd - > /dev/null
		rsync -r target/*/* mangas
		rm -r target
		echo Page $PAGE downloaded
		PAGE=$((PAGE+1))
	else
		DONE=1
	fi

	#echo $PAGE
	#echo $DONE
	#sleep 10
done

echo Download finished
