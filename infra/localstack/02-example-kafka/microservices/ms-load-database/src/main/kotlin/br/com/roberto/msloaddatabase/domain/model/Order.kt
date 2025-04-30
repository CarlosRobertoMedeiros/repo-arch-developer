package br.com.roberto.msloaddatabase.domain.model

import java.math.BigDecimal
import java.util.*

data class Order (
    val number: UUID,
    val requester: String,
    val total: BigDecimal,
    val items: List<Item>
)