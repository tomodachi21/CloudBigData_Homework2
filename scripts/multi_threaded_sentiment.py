# Tweet Stream Filtering 
import json
import re
import ssl
import ast
from multiprocessing import Process
from elasticsearch import Elasticsearch
from datetime import datetime
from alchemyapi import AlchemyAPI
alchemyapi = AlchemyAPI()

import boto3
import time

sqs = boto3.resource('sqs')
words = ['apple', 'google', 'happy', 'sad', 'good', 'bad', 'iphone', 'camera', 'music', 'coffee']

# Statement of work for current worker thread - get message, request sentiment, save resposne
def sentiment():
	queue = sqs.get_queue_by_name(QueueName='homework2_tweets')
    	for message in queue.receive_messages(MessageAttributeNames=['Author']):
    		author_text = ''
    		es = Elasticsearch()
    		if message.message_attributes is not None:
    			author_name = message.message_attributes.get('Author').get('StringValue')
    		print "==========="
    		tweet = '{0}!{1}'.format(message.body, author_text)
    		tweet = tweet[:-1]
    		print tweet
    		print "===="
    		tweet = ast.literal_eval(tweet)
    		print type(tweet)
    		tweet_bod = tweet['text']
    		print tweet_bod
    		response = alchemyapi.sentiment("text", tweet_bod)
    		senti = str(response['docSentiment']['type'])
    		print senti
    		if senti == 'positive':
    			for word in words:
    				if re.search(word, tweet_bod.lower()) is None:
    					x = 1
    				else:
    					es_index = word + '_pos'
    		elif senti == 'negative':
    			for word in words:
    				if re.search(word, tweet_bod.lower()) is None:
    					x = 1
    				else:
    					es_index = word + '_neg'
    		else:
    			for word in words:
    				if re.search(word, tweet_bod.lower()) is None:
    					x = 1
    				else:
    					es_index = word
    		print es_index
    		es.create(index=es_index,
                      doc_type="twitter_twp",
                      body=tweet
                     )
    		message.delete()
    		
run_it = 1
while (run_it):
	# For loop to create separate threads for each item in current queue
	print "Current queue is: " + str(int(sqs.get_queue_by_name(QueueName='homework2_tweets').attributes['ApproximateNumberOfMessages']))
	for x in range(1,int(sqs.get_queue_by_name(QueueName='homework2_tweets').attributes['ApproximateNumberOfMessages'])+1):
		if __name__ == '__main__':
    			p = Process(target=sentiment, args=())
    			p.start()
    			p.join()
    			print p
	time.sleep(5)
