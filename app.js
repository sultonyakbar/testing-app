const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Simple Hello World route
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
        <title>Hello World</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            .hello-world {
                text-align: center;
                padding: 2rem;
                background: rgba(255,255,255,0.1);
                border-radius: 10px;
                backdrop-filter: blur(10px);
            }
            h1 {
                font-size: 3rem;
                margin: 0;
            }
            p {
                font-size: 1.2rem;
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="hello-world">
            <h1>Hello World! 🌍</h1>
            <p>Node.js Application Running in Docker Container</p>
        </div>
    </body>
    </html>
  `);
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Application is healthy',
    timestamp: new Date().toISOString()
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📍 Access the app: http://localhost:${PORT}`);
});

module.exports = app;
