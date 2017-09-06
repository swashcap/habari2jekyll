const fs = require('fs-extra')
const moment = require('moment')
const path = require('path')
const { Client } = require('pg')

const writeFile = async (filePath, content) => {
  const exists = await fs.pathExists(filePath)

  // Don't write over existing file!
  if (exists) {
    throw new Error(`File ${filePath} already exists`)
  }

  return fs.writeFile(filePath, content)
}

/**
 * habari2jekyll
 *
 * @param {Object} props
 * @param {string} props.database
 * @param {string} props.directory
 * @param {string} props.host
 * @param {string} props.prefix
 * @param {string} props.port
 * @param {string} props.password
 * @param {string} props.username
 * @returns {Promise<string[],Error>}
 */
module.exports = async function habari2jekyll ({
  database,
  directory,
  host,
  password,
  port,
  prefix,
  username
}) {
  const client = new Client({
    database: database,
    host: host,
    password: password,
    port: port,
    user: username
  })
  const dir = path.isAbsolute(directory)
    ? directory
    : path.join(process.cwd(), directory)

  await client.connect()

  const { rows: entries } = await client.query(
    `
    SELECT content, pubdate, slug, title FROM ${prefix}posts
      WHERE status = (
        SELECT id FROM ${prefix}poststatus WHERE name = 'published'
      )
      AND content_type = (
        SELECT id FROM ${prefix}posttype WHERE name = 'entry'
      );
    `
  )
  await fs.ensureDir(dir)
  await client.end()

  return Promise.all(entries.map(({ content, pubdate, slug, title }) => {
    const date = moment(pubdate * 1000)
    const filePath = path.join(dir, `${date.format('YYYY-MM-DD')}-${slug}.md`)
    const fileContent = `---
title: ${title}
date: ${date.format()}
---

${content}`

    return writeFile(filePath, fileContent).then(() => filePath)
  }))
}
