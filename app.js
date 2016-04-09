var logger = require('./logger')
var amqp = require('amqplib/callback_api');
var email   = require("emailjs/email");

var getEnv = function(envName){
	var envVar = process.env[envName];
	if(!envVar || envVar == ""){
		console.log("Please set " + envName + " environment variable.")
		process.exit(-1)
	}
	return envVar;
}

var config = {
	amqpUri : getEnv("AMQP_URI"),
	smtpHost : getEnv("SMTP_HOST"),
	smtpPort : getEnv("SMTP_PORT"),
	smtpUsername : getEnv("SMTP_USERNAME"),
	smtpPassword : getEnv("SMTP_PASSWORD"),
	smtpSsl : getEnv("SMTP_SSL"),
	senderEmail : getEnv("SENDER_EMAIL")
}

var server  = email.server.connect({
   user:     config.smtpUsername,
   password: config.smtpPassword,
   host:     config.smtpHost,
   ssl:      config.smtpSsl,
   port : 	 config.smtpPort,
});


amqp.connect(config.amqpUri, function(err, conn) {
	if(err){
		logger.error(err)
		if(conn) conn.close();
		return;
	}

	logger.info("Connected to amqp broker: %s", config.amqpUri)

	// send notification to document service
  	conn.createChannel(function(err, ch) {
		var queueName = 'document-service';

		ch.assertQueue(queueName, {durable: true});
		logger.info("Waiting for messages in %s. To exit press CTRL+C", queueName);
		
		ch.consume(queueName, function(msg) {
			logger.info("Received %s", msg.content)
			var payload = JSON.parse(msg.content)
			var toEmail = payload.email;
			var recommendation = payload.recommendation;

			var emailText = "Hi!\nThanks a lot for completing the survey. According to our calculations, you are able to withstand a further " + recommendation.score + " tantrums.\n" + recommendation.message

			server.send({
			   text:    emailText, 
			   from:    config.senderEmail, 
			   to:      toEmail,
			   subject: "How many toddler tantrums can you cope with before you commit a crime?"
			}, function(err, message) { 
				if(err){
					logger.error("An error %s when sending an email to %s", err, toEmail)
					return;
				}

				logger.info("Successfully notified user %s", toEmail)
			});

			// ack that message was processed
			ch.ack(msg);
		}, {noAck: false});

	});
});
