const execa = require('execa')
const fs = require('fs-extra')
const path = require('path')
const promiseRetry = require('promise-retry')
const test = require('ava')
const zip = require('lodash.zip')
const { Client } = require('pg')

const habari2jekyll = require('../src/index.js')

const database = 'habaridb'
const directory = path.join(__dirname, '..', '.tmp')
const port = 6117
const password = 'habari'
const username = 'habari'

test.before(async () =>
  execa.shell(
    `
      docker run -d --rm \
        -p ${port}:5432 \
        -e POSTGRES_PASSWORD=${password} \
        -e POSTGRES_USER=${username} \
        -e POSTGRES_DB=${database} \
        --name habari2jekyll \
        --volume ${__dirname}:/docker-entrypoint-initdb.d/ \
        postgres:latest 
    `,
    {
      cwd: __dirname
    }
  )
    // Seeding database takes a few seconds
    .then(() => new Promise((resolve) => setTimeout(resolve, 5000)))
    .then(() => promiseRetry(
      async () => {
        const client = new Client({
          database,
          host: 'localhost',
          password,
          port,
          user: username
        })

        await client.connect()
        await client.end()
      },
      {
        maxTimeout: 5000,
        retries: 3
      }
    ))
)

test('Gets Habari posts', async (t) => {
  const expectedFiles = [
    [
      path.join(directory, '2010-12-21-new-ursi-project-description-1.md'),
      `---
title: New URSI Project Description
date: 2010-12-21T10:23:43-08:00
---

Click the following link to view the description of the New URSI Project. <a href="http://portal.mind.unm.edu/habari/user/files/NewURSIProjectDescription.pdf">NewURSIProjectDescription.pdf</a>`
    ],
    [
      path.join(directory, '2012-06-25-march-15th-2012-coins-weekly-tips-and-updates.md'),
      `---
title: March 15th, 2012 COINS' Weekly Tips and Updates
date: 2012-06-25T14:25:35-07:00
---

Updates

NI Updates Page

You may have noticed a change in the format of the Updates for Neuroinformatics located on the homepages in COINS. Under Navigation there are different pages that you can click on to access overview and training documents. We are working on creating more training materials for our users, including video tutorials.

Assessment Manager

If you have a study visit that you are no longer entering data for, you can now hide it from the data entry cover sheets, this will eliminate the possibility of an operator entering data for a visit in error. To hide a study visit, go to the study details page in MICIS and click on the Study Visits button at the top of the page. You will be directed to a page that lists all of the study visits, select Edit next to the visit that you would like to hide. You will then check the box next to Hidden? and click Continue.

Helpful Tips

Go to  Studies below and select How to create subject types.pdf to view a training guide on creating subject types for your study. `
    ]
  ]

  t.plan(2)

  return habari2jekyll({
    database,
    directory,
    host: 'localhost',
    port,
    password,
    prefix: 'habari__',
    username
  })
  .then((files) => {
    t.deepEqual(
      files,
      expectedFiles.map(i => i[0]),
      'returns array of files'
    )

    return fs.readdir(directory)
  })
  .then((results) => {
    const files = results.map(f => path.join(directory, f))

    return Promise.all([
      files,
      Promise.all(files.map(f => fs.readFile(f, 'utf8')))
    ])
  })
  .then(([files, contents]) => {
    t.deepEqual(
      zip(files, contents),
      expectedFiles,
      'saves Habari entries as Jekyll posts'
    )
  })
})

test.after(async () => Promise.all([
  execa.shell(`docker stop habari2jekyll`),
  fs.remove(directory)
]))
