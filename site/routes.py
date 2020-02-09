#!/usr/bin/python3
# vim: ts=4 sw=4 et ai:
# -*- coding: utf8 -*-

from flask import ( Flask,
                    render_template,
                    request,
                    redirect,
                    session
                    )
import logging

logging.basicConfig()
log = logging.getLogger('flask')
log.setLevel(logging.DEBUG)

app = Flask('stittsvillebrainery')

@app.route('/', methods=['GET'])
def index():
    log.info("in index, request.method is GET")
    return render_template('index.html')

def main():
    host = '0.0.0.0'
    port = 8080

    log.info("starting on %s:%d", host, port)
    app.run(debug=True, host=host, port=port)

if __name__ == '__main__':
    main()
