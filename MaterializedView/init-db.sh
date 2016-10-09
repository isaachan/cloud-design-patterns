#! /bin/bash

IMG=mysql
DB=customer
PASSWORD=1234abcd

if [ ! "$(docker images | grep $IMG)" ]
    then
        echo "Image $IMG has not been pulled. Start pulling $IMG ..."
	docker pull $IMG
fi

docker rm -f $DB > /dev/null

docker run \
       --name $DB \
       -p 3306:3306 \
       -e MYSQL_ROOT_PASSWORD=$PASSWORD \
       -e MYSQL_DATABASE=$DB \
       -d \
       mysql > /dev/null
 
until docker exec -it $DB mysql -u root -p${PASSWORD} -e ';' > /dev/null; do
  echo "Waiting for mysqld starting..."
  sleep 2
done
