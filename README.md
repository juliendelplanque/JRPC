# JRPC
[![Build Status](https://travis-ci.org/juliendelplanque/JRPC.svg?branch=master)](https://travis-ci.org/juliendelplanque/JRPC)
[![Coverage Status](https://coveralls.io/repos/github/juliendelplanque/JRPC/badge.svg?branch=master)](https://coveralls.io/github/juliendelplanque/JRPC?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)

Yet another [JSON-RPC 2.0](https://www.jsonrpc.org/specification) implementation for Pharo Smalltalk

- [Features](#features)
- [Installation](#installation)
- [Examples](#examples)
- [Comparison with other JSON RPC implementations](#jrpc-vs-others)
- [Contributing](#contributing)

## Features
- Client and Server support for JSON-RPC 2.0.
- Only depends on Pharo's built-in packages.
- Uses STONJSON to parse JSON internally.
- Transport agnostic (like JSON-RPC 2.0 spec claims).
- Can currently be used over
  - HTTP
  - TCP
- It is easy to add other transport layers.
- Additional `data` when an error occured in the `error` object.

## Examples

Explore the [documentation](docs/Examples.md)

## Installation

To load the project in a Pharo image or declare it as a dependency of your project follow this [instructions](docs/Installation.md).

## Comparison with other JSON RPC implementations

| Property     | JRPC               | LtJsonRpc          | NeoJSONRPC         |
|--------------|--------------------|--------------------|--------------------|
| Server       | :white_check_mark: | :white_check_mark: | :x:                |
| Client       | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| JSON backend | STONJSON           | Json               | NeoJSON            |
| Tests        | :white_check_mark: | :x:                | :x:                |

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
