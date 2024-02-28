package br.com.roberto.msloaddatabase.transportlayers.listener


import org.springframework.stereotype.Component

@Component
class SQSListenerLoadFile {

    //@SqsListener("your-queue-name")
    fun receiveMessage(message: String) {
        println("Received message: $message")
        // Adicione sua lógica de processamento aqui
    }

}