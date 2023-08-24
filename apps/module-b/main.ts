import express from 'express'

express()
  .get('/', (_req, res) => {
    res.send('Hello People!')
  })
  .listen(3000, () => {
    console.log(`Example app listening on port ${3000}`)
  })
