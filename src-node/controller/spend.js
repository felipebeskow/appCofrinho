const DbConnection = require("../db/conection")

module.exports = {
    async post(req, res) {
        let query = req.body
        try {
            //let result = await DbConnection.raw(`SELECT VERSION()`)
            await DbConnection.transaction(async (trx) => {
                const result = await trx('CATEGORIAS')
                    .insert({
                        CAT_NOME: query.nome,
                        CAT_DESCRICAO: query.descricao,
                    })
                    .returning(['CAT_UUID', 'CAT_NOME', 'CAT_DESCRICAO'])

                await trx.commit() // Confirma a transação
                console.log(result)
                res.json(result)
            })
        } catch (error) {
            console.error("Error inserting data:", error);
            res.status(500).json({
                error: "Failed to insert data"
            });
        }
    }
}