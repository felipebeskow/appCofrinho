const { google } = require('googleapis');
const { Readable } = require('stream');
const path = require('path');

// Carregar as credenciais do seu projeto
const auth = new google.auth.GoogleAuth({
    keyFile: path.join(__dirname, '/../credenciais.json'),
    scopes: ['https://www.googleapis.com/auth/drive']
});

const drive = google.drive({ version: 'v3', auth });
module.exports = {
    async post(req, res) {
        console.log(req.file)
        try {
            const fileName = req.file.originalname;
            const fileBuffer = req.file.buffer;

            const fileMetadata = {
                name: fileName
            };

            const readableStream = new Readable();
            readableStream.push(fileBuffer);
            readableStream.push(null);

            const media = {
                mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                body: readableStream
            };

            const response = await drive.files.create({
                resource: fileMetadata,
                media: media,
                fields: 'id'
            });

            res.send(`Arquivo enviado com sucesso: ${response.data.id}`);
        } catch (err) {
            console.error('Erro ao enviar o arquivo:', err);
            res.status(500).send('Erro ao enviar o arquivo');
        }
    },
}