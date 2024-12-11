const { google } = require('googleapis');
const { Readable } = require('stream');
const path = require('path');

// Carregar as credenciais do seu projeto


const GOOGLE_API_FOLDER_ID = '0B_8InX3YWZabTE1nSkUzeEg3U1U'


module.exports = {
    async post(req, res) {
        try {
            
            const auth = new google.auth.GoogleAuth({
                keyFile: path.join(__dirname, '/../credenciais.json'),
                scopes: ['https://www.googleapis.com/auth/drive']
            });
            
            const driveService = google.drive({
                version: 'v3',
                auth 
            });

            const fileName = req.file.originalname;

            const fileMetadata = {
                name: fileName,
                parents: [GOOGLE_API_FOLDER_ID]
            }

            const fileBuffer = req.file.buffer;
            
            const readableStream = new Readable();
            readableStream.push(fileBuffer);
            readableStream.push(null);

            const media = {
                mimeType: 'image/jpg',
                body: readableStream
            }

            const response = await driveService.files.create({
                resource:fileMetadata,
                media,
                fields: 'id'
            })

            console.log(response.data.id)

        } catch (error) {
            console.error('Erro ao enviar o arquivo:', error);
            res.status(500).json({
                message:'Erro ao enviar o arquivo',
                error
            });
        }
    },
}