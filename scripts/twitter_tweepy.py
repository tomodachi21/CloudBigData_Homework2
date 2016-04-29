import tweepy
import sys
import json
import ssl
import boto3
from textwrap import TextWrapper
from datetime import datetime
from elasticsearch import Elasticsearch
import re

consumer_key="TOBhE7vFqK8URMaA8wytWKjOh"
consumer_secret="060z6vR1CZinrPO920UmwYWpiJUwyOp2A5PYLHndKUHdbbCZry"

access_token="7921752-CdxUKyD3H6sU9FURaO0GO2n2KwcBxN97LOlqYwNd4X"
access_token_secret="xn7GnRgDKLGhdcp5rGKRgAACsB0FpY5ere7nRRBhSww2B"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

# Adding a AWS SQS Connection
sqs = boto3.resource('sqs')
q = sqs.get_queue_by_name(QueueName = 'homework2_tweets')

es = Elasticsearch()

#print 'Number of arguments:', len(sys.argv), 'arguments.'
#print 'Argument List:', str(sys.argv)

wordLed=len(sys.argv)
params=[]
indexID=''
indexID=sys.argv[1]
indexID=indexID.encode('utf-8')
for x in range(2,wordLed):
        params.append(sys.argv[x])
#print 'Index named: ', indexID
#print 'Query strings: ', params

class StreamListener(tweepy.StreamListener):
    status_wrapper = TextWrapper(width=60, initial_indent='    ', subsequent_indent='    ')

    def on_status(self, status):
        try:
            #print 'n%s %s' % (status.author.screen_name, status.created_at)
            words = ['apple', 'google', 'happy', 'sad', 'good', 'bad', 'iphone', 'camera', 'music', 'coffee']

            json_data = status._json
            if str(json_data['coordinates']) != 'None':
                                noth = 1
                        else:
                                response = q.send_message(MessageBody=str(json_data))
                                #print "Inserted"

            #es.create(index=indexID,
            #          doc_type="twitter_twp",
            #          body=json_data
            #         )

        except Exception, e:
            #print e
            pass

streamer = tweepy.Stream(auth=auth, listener=StreamListener(), timeout=3000000000 )

#Fill with your own Keywords bellow
terms = params

#  streamer.filter(None,terms)

streamer.filter(locations=[-125.0011, 24.9493, -66.9326, 49.5904])