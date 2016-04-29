#!/bin/bash

curl -XGET "http://localhost:9200/apple/_search?q=text:apple&size=10000&pretty=true" > apple.txt
curl -XGET "http://localhost:9200/apple_pos/_search?q=text:apple&size=10000&pretty=true" > apple_pos.txt
curl -XGET "http://localhost:9200/apple_neg/_search?q=text:apple&size=10000&pretty=true" > apple_neg.txt

curl -XGET "http://localhost:9200/google/_search?q=text:google&size=10000&pretty=true" > google.txt
curl -XGET "http://localhost:9200/google_pos/_search?q=text:google&size=10000&pretty=true" > google_pos.txt
curl -XGET "http://localhost:9200/google_neg/_search?q=text:google&size=10000&pretty=true" > google_neg.txt

curl -XGET "http://localhost:9200/happy/_search?q=text:happy&size=10000&pretty=true" > happy.txt
curl -XGET "http://localhost:9200/happy_pos/_search?q=text:happy&size=10000&pretty=true" > happy_pos.txt
curl -XGET "http://localhost:9200/happy_neg/_search?q=text:happy&size=10000&pretty=true" > happy_neg.txt

curl -XGET "http://localhost:9200/sad/_search?q=text:sad&size=10000&pretty=true" > sad.txt
curl -XGET "http://localhost:9200/sad_pos/_search?q=text:sad&size=10000&pretty=true" > sad_pos.txt
curl -XGET "http://localhost:9200/sad_neg/_search?q=text:sad&size=10000&pretty=true" > sad_neg.txt

curl -XGET "http://localhost:9200/good/_search?q=text:good&size=10000&pretty=true" > good.txt
curl -XGET "http://localhost:9200/good_pos/_search?q=text:good&size=10000&pretty=true" > good_pos.txt
curl -XGET "http://localhost:9200/good_neg/_search?q=text:good&size=10000&pretty=true" > good_neg.txt

curl -XGET "http://localhost:9200/bad/_search?q=text:bad&size=10000&pretty=true" > bad.txt
curl -XGET "http://localhost:9200/bad_pos/_search?q=text:bad&size=10000&pretty=true" > bad_pos.txt
curl -XGET "http://localhost:9200/bad_neg/_search?q=text:bad&size=10000&pretty=true" > bad_neg.txt

curl -XGET "http://localhost:9200/iphone/_search?q=text:iphone&size=10000&pretty=true" > iphone.txt
curl -XGET "http://localhost:9200/iphone_pos/_search?q=text:iphone&size=10000&pretty=true" > iphone_pos.txt
curl -XGET "http://localhost:9200/iphone_neg/_search?q=text:iphone&size=10000&pretty=true" > iphone_neg.txt

curl -XGET "http://localhost:9200/camera/_search?q=text:camera&size=10000&pretty=true" > camera.txt
curl -XGET "http://localhost:9200/camera_pos/_search?q=text:camera&size=10000&pretty=true" > camera_pos.txt
curl -XGET "http://localhost:9200/camera_neg/_search?q=text:camera&size=10000&pretty=true" > camera_neg.txt

curl -XGET "http://localhost:9200/music/_search?q=text:music&size=10000&pretty=true" > music.txt
curl -XGET "http://localhost:9200/music_pos/_search?q=text:music&size=10000&pretty=true" > music_pos.txt
curl -XGET "http://localhost:9200/music_neg/_search?q=text:music&size=10000&pretty=true" > music_neg.txt

curl -XGET "http://localhost:9200/coffee/_search?q=text:coffee&size=10000&pretty=true" > coffee.txt
curl -XGET "http://localhost:9200/coffee_pos/_search?q=text:coffee&size=10000&pretty=true" > coffee_pos.txt
curl -XGET "http://localhost:9200/coffee_neg/_search?q=text:coffee&size=10000&pretty=true" > coffee_neg.txt

find . -name "*.txt" -size -5k -delete

Rscript --vanilla /home/ubuntu/JSON_Files/createGeoJSON.R apple google happy sad good bad iphone camera music coffee

aws s3 cp output s3://homework1-json/ --recursive