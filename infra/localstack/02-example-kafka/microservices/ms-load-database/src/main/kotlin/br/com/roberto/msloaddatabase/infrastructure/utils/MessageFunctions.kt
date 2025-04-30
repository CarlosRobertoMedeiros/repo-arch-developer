package br.com.roberto.msloaddatabase.infrastructure.utils

import io.awspring.cloud.sqs.listener.SqsHeaders.MessageSystemAttributes.SQS_APPROXIMATE_RECEIVE_COUNT
import org.springframework.messaging.MessageHeaders

fun MessageHeaders.currentConsumeAttempt(): String {
    return this.getOrDefault(SQS_APPROXIMATE_RECEIVE_COUNT, "0").toString()
}

fun MessageHeaders.id(): String = this["id"].toString()