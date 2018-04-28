PAGE=1
DONE=0

while [ "$DONE" == "0" ]; do
	wget -x -H -r -l 1 -A jpg,jpeg -P target https://www.mangapanda.com/one-piece/900/$PAGE
	#wget -x -H -r -l 1 -A jpg,jpeg -P target https://www.mangapanda.com/nanatsu-no-taizai/264

	if [ -d "target" ]; then
		rm -r target/www*
		rm -r target/*.net

		cd target/*/*/*
		pwd
		mv * $PAGE.jpg
		cd -
		rsync -r target/*/* mangas
		rm -r target
		PAGE=$((PAGE+1))
	else
		DONE=1
	fi

	#echo $PAGE
	#echo $DONE
	#sleep 10
done
