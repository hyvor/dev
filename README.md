## HYVOR DEV

This is the starting point to start developing HYVOR products.

-   Sets up the development environment
-   Handles certificates
-   Runs the development Caddy server

### Products

-   Core (hyvor.com)
-   Talk (talk.hyvor.com)
-   Blogs (blogs.hyvor.com)

### Clone the Repository and Initialize

Create a new directory for HYVOR development, if you don't have one already:

```bash
mkdir hyvor/dev
cd hyvor/dev
```

Clone this repository:

```bash
git clone --recurse-submodules https://github.com/hyvor/dev .
```

### Pre-requisites

-  [Docker](https://docs.docker.com/engine/install/)
- [mkcert](https://github.com/FiloSottile/mkcert)

### Setup

Initialize the development environment:

```bash
make init
```

This command will run the `make init` command in each submodule, then set up required certificates and run the development server.

Then, add the following lines to your `/etc/hosts` file:

```bash
127.0.0.1 hyvor.dev
127.0.0.1 talk.hyvor.dev
127.0.0.1 blogs.hyvor.dev
```

(as more products are added, you will need to add them to the `/etc/hosts` file)

### Development Server

Run `make dev` with the components you want to run.

core and blogs:

```bash
make dev C="core blogs"
```

talk:

```bash
make dev C="talk"
```

To know:

- Vite and Laravel dev servers are run on ports between 41000 and 41999.
- Caddy serves on port 443 with HTTPS.
  - It will automatically make the CA trusted on your system. However, additional work may be required to make browsers trust the CA. See [this](https://thomas-leister.de/en/how-to-import-ca-root-certificate/).
  - Caddy is run without sudo. You might need to run the following if you get a permission error ([source](https://serverfault.com/a/807884)):
    ```bash
    sudo setcap CAP_NET_BIND_SERVICE=+eip $(which caddy)
    ```

### Databases and Services

To start the databases via Docker, run:

```bash
make compose-up
```

To stop the databases, run:

```bash
make compose-down
```