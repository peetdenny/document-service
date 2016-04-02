var logger = require('./logger')
var amqp = require('amqplib/callback_api');

var args = process.argv.slice(2);

if(!args || args.length != 1){
	console.log("Please provide amqp uri in form amqp://user:password@host:port as input argument")
	process.exit(-1)
}

var amqpUri = args[0]

amqp.connect(amqpUri, function(err, conn) {
	if(err){
		logger.error(err)
		if(conn) conn.close();
		return;
	}

	// send notification to document service
  	conn.createChannel(function(err, ch) {
		var queueName = 'document-service';

		ch.assertQueue(queueName, {durable: true});
		logger.info("Waiting for messages in %s. To exit press CTRL+C", queueName);
		
		ch.consume(queueName, function(msg) {
			logger.info("Received %s", msg.content)

			// TODO send email notification

			// ack that message was processed
			ch.ack(msg);
		}, {noAck: false});

	});
});