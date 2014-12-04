# PRIM Resources

[![Build Status](https://travis-ci.org/cbitstech/prim-resources.svg?branch=master)](https://travis-ci.org/cbitstech/prim-resources) [![security](https://hakiri.io/github/cbitstech/prim-resources/master.svg)](https://hakiri.io/github/cbitstech/prim-resources/master)

This application provides the JSON API that is consumed by PRIM Front End as
well as other client applications.

## Generate an API Consumer record

```console
bin/rake consumers:create PROJECT=Intellicare IP=127.0.0.1 NAME="intellicare dashboard"
```

This will print a token. You can test it locally (assuming you have the Rails
server running on port 3001) with:

```console
curl -4 http://localhost:3001/v1/participants -H "X-AUTH-TOKEN: 743c5c1d7..."
```
