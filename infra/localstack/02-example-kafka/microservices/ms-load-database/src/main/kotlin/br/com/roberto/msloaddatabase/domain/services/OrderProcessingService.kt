package br.com.roberto.msloaddatabase.domain.services

import br.com.roberto.msloaddatabase.domain.model.Order
import io.github.oshai.kotlinlogging.KotlinLogging
import org.springframework.stereotype.Service

@Service
class OrderProcessingService {

    private val logger = KotlinLogging.logger {}
    fun process(order: Order) {
        logger.info { "Processing order [${order.number}]" }
    }
}