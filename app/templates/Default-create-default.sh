!#/bin/bash

for FILE in `ls *`
do
    cp -vf $FILE "Default-"$FILE
done
