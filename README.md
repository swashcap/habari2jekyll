# habari2jekyll

Convert [Habari][habari] content to Markdown files for use with
[Jekyll][jekyll].

## Use

This project uses [async/await][async], and requires Node.js 8.x.x or greater.
Install globally:

```shell
npm install -g habari2jekyll
```

Then, use via the CLI:

```shell
habari2jekyll --database database_name \
  --directory ./output/to/here \
  --host localhost \
  --port 5432 \
  --password secrets \
  --username postgres
```

See `habari2jekyll --help` for more info:

```shell
habari2jekyll --help

  Usage: habari2jekyll [options]


  Options:

    -V, --version           output the version number
    -d, --database [value]  Database name
    --directory             Directory for output files
    -h, --host [value]      Database hostname
    --prefix [value]        Database table prefix
    -p, --port [value]      Port
    -w, --password [value]  Password
    -u, --username [value]  Username
    -h, --help              output usage information`
```

## Testing

1. Ensure [Docker is installed][docker] and running
2. Install all dependencies:

    ```shell
    npm install
    ```
3. Lint project code via [standard][standard]:

    ```shell
    npm run lint
    ```
4. Run tests via [ava][ava]:

    ```shell
    npm test
    ```

    Occasionally, ava won't perform test teardown, resulting in a persisted test
    Postgres container. Manually remove it:

    ```shell
    docker stop habari2jekyll
    ```

[async]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function
[ava]: https://github.com/avajs/ava
[docker]: https://docs.docker.com/engine/installation/
[habari]: http://habariproject.org/en/
[jekyll]: http://jekyllrb.com
[standard]: https://standardjs.com

