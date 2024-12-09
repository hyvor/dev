## HYVOR DEV

This is the starting point to start developing HYVOR products.

-   Sets up the development environment
-   Handles certificates
-   Runs the development Caddy server

### Products

-   Core (hyvor.com)
-   Talk (talk.hyvor.com)
-   Blogs (blogs.hyvor.com)

### Get Started

Create a new directory for HYVOR development, if you don't have one already:

```bash
mkdir hyvor/dev
cd hyvor/dev
```

Clone this repository:

```bash
git clone --recurse-submodules https://github.com/hyvor/dev .
```

Initialize the development environment:

```bash
make init
```

This command will run the `make init` command in each submodule, then set up required certificates and run the development server.
