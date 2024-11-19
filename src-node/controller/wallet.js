const DbConnection = require("../db/conection")

module.exports = {
    async post(req, res) {
        const data = req.body
        try {
            //let result = await DbConnection.raw(`SELECT VERSION()`)
            await DbConnection.transaction(async (trx) => {
                const result = await trx('CARTEIRA')
                    .insert({
                        CAR_NOME: data.CAR_NOME,
                        CAR_DESCRICAO: data.CAR_DESCRICAO,
                    })

                await trx.commit() // Confirma a transação
                res.json(result)
            })
        } catch (error) {
            console.error("Error inserting data:", error);
            res.status(500).json({
                error: "Failed to insert data"
            });
        }
    },
    async get(req, res) {
        const query = req.body.query
        try {
            const result = await DbConnection('CARTEIRA')
            res.json(result)
        } catch (error) {
            console.error("Error selecting data:", error);
            res.status(500).json({
                error: "Failed to select data"
            });
        }
    }
}