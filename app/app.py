"""
Simple Flask Web Application for DevOps Practice
This application demonstrates basic web functionality for learning DevOps concepts.
"""

from flask import Flask, render_template, jsonify
import os
import socket
import sys

app = Flask(__name__)

@app.route('/')
def home():
    """Home page route"""
    return render_template('index.html')

@app.route('/health')
def health():
    """Health check endpoint for monitoring"""
    return jsonify({
        'status': 'healthy',
        'service': 'devops-demo-app',
        'version': os.environ.get('APP_VERSION', '1.0.0')
    }), 200

@app.route('/info')
def info():
    """System information endpoint"""
    return jsonify({
        'hostname': socket.gethostname(),
        'platform': sys.platform,
        'python_version': sys.version,
        'environment': os.environ.get('ENVIRONMENT', 'development')
    }), 200

@app.route('/api/status')
def status():
    """API status endpoint"""
    return jsonify({
        'api': 'active',
        'endpoints': [
            '/health',
            '/info',
            '/api/status'
        ]
    }), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
