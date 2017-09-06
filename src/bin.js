#!/usr/bin/env node

const habari2jekyll = require('./index.js')
const indentString = require('indent-string')
const pkg = require('../package.json')
const program = require('commander')

program
  .version(pkg.version)
  .option('-d, --database [value]', 'Database name')
  .option('--directory', 'Directory for output files')
  .option('-h, --host [value]', 'Database hostname')
  .option('--prefix [value]', 'Database table prefix', '')
  .option('-p, --port [value]', 'Port')
  .option('-w, --password [value]', 'Password')
  .option('-u, --username [value]', 'Username')
  .parse(process.argv)

habari2jekyll(program)
  .then(files => console.log(`Files saved:

${files.map(f => indentString(f))}
`
  ))
  .catch(console.error)
