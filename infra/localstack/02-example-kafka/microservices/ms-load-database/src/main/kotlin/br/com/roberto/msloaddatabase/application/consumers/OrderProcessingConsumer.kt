package br.com.roberto.msloaddatabase.application.consumers

import br.com.roberto.msloaddatabase.application.payloads.JsonReceiveMessage
import br.com.roberto.msloaddatabase.domain.services.OrderProcessingService
import br.com.roberto.msloaddatabase.infrastructure.utils.currentConsumeAttempt
import io.awspring.cloud.sqs.annotation.SqsListener
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.messaging.MessageHeaders
import org.springframework.messaging.handler.annotation.Headers
import org.springframework.stereotype.Component

@Component
class OrderProcessingConsumer(
    private val orderProcessingService: OrderProcessingService
) {

    private val logger = KotlinLogging.logger {}
    @SqsListener("\${application.sqs.queues.my-queue}")
    fun onMessage(message: JsonReceiveMessage, @Headers headers: MessageHeaders) {

        logger.info { "Message [${headers.id}] received to process order number [${message.records[0].s3.`object`.sequencer}]" }
        logger.debug { "Trying to consume message [${headers.id}] at [${headers.currentConsumeAttempt()}] attempt" }
        println(message)

       // val items = message.items.map { Item(it.description, it.quantity, it.value) }
        //val order = Order(message.number, message.requester, message.total, items)

        //orderProcessingService.process(order)
    }

}