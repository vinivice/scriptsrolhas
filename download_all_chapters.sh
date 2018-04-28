####################################################################
#            Used to download the whole series of a manga          #
#    Created to be used in specific sites. May not work on others  #
#      Use the scrip download_chapter.sh. Make sure you have it    #
#               Pass the url of manga as an argument               #
#   It doesn't check for wrong input, the download will only fail  #
# Only download integer chapter. Does not account for special ones #
####################################################################

CHAPTER=1
DONE=0

if [ "$#" -lt 1 ]; then
	echo Error: Must pass url of the manga as first argument
	echo Usage: ./$0 URL [FIRST_CHAPTER]
	exit 1
fi
URL=$1

if [ "$#" -eq 2 ]; then
	CHAPTER=$2
fi

echo Downloading manga
while [ "$DONE" == "0" ]; do
	echo Starting chapter $CHAPTER download
	./download_chapter.sh $URL/$CHAPTER
	if [ "$?" == "5" ]; then
		echo Chapter $CHAPTER not found.
		DONE=1
	else
		echo Chapter $CHAPTER downloaded successifully.
		CHAPTER=$((CHAPTER+1))
	fi
done

echo Manga download finished
exit 0
