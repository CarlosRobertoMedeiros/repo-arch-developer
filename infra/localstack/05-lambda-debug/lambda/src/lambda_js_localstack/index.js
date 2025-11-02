exports.handler = async (event) => {
    // Espera receber event.param1 e event.param2
    debugger;
    const { param1, param2 } = event;

    console.log("Parâmetros recebidos:", param1, param2);

    // Calcula ou cria um terceiro valor
    const param3 = `Resultado de ${param1} + ${param2}`;

    return {
        statusCode: 200,
        body: JSON.stringify({
            param1: param1,
            param2: param2,
            param3: param3
        }),
    };
};