#! /bin/bash

IMG="themarquee/graphviz" 

if [ ! "$(docker images | grep $IMG)" ]
    then
        echo "Image $IMG has not been pulled. Start pulling $IMG ..."
	docker pull $IMG
fi

WORKING="/backup"
rm -f patterns.png
docker run --rm -w $WORKING -v $(pwd):$WORKING $IMG dot $@
