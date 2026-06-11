## HYVOR DEVELOPMENT

This is the starting point of developing HYVOR products. It contains the other repositories as submodules.

| Repository   | Description                             | Open-source? |
| ------------ | --------------------------------------- | ------------ |
| **Products** |                                         |              |
| `talk`       | Hyvor Talk, commenting platform         | No           |
| `blogs`      | Hyvor Blogs, blogging platform          | No           |
| `post`       | Hyvor Post, newsletter platform         | No           |
| `relay`      | Hyvor Relay, email sending API          | Yes          |
| `agora`      | Hyvor Agora, community platform (WIP)   | No           |
| **Meta**     |                                         |              |
| `core`       | hyvor.com, provides auth, billing, etc. | No           |
| `internal`   | Hyvor Internal, PHP library             | Yes          |
| `design`     | Hyvor Design, design system             | Yes          |

## First Time Setup

### Step 0: Pre-requisites

-   [Git](https://git-scm.com/downloads)
-   [Docker](https://docs.docker.com/engine/install/)
-   [mkcert](https://github.com/FiloSottile/mkcert) (make sure to run `mkcert -install` to install the root CA)

### Step 1: Clone the Repository

Create a new directory for HYVOR development, if you don't have one already:

```shell
mkdir hyvor/dev
cd hyvor/dev
```

All below commands are to be run in this directory.

Clone this repository:

```shell
# Option 1: Clone the repository with submodules
# IMPORTANT: THIS REQUIRES ACCCESS TO PRIVATE REPOSITORIES (HYVOR EMPLOYEES ONLY)
git clone --recurse-submodules https://github.com/hyvor/dev .

# Option 2: Clone the repository without submodules
# and then update open-source submodules (ex: relay) manually
git clone https://github.com/hyvor/dev .
git submodule update --init relay
```

### Step 2: Init

Run the following command to initialize the project. You only need to run this once.

```shell
./init
```

This command:

-   Generates SSL certificates for the development server using `mkcert`.
-   Creates the docker network `hyvor-network`.
-   Creates data directories for databases and Minio (S3).

### Step 3: Run

Once init is done, you can run services and components.

#### 3.1: Start the services

These are the shared development services used by all components. To run all services, run:

```shell
./services
```

It starts the following services:

1. Traefik
    - Proxy for `*.hyvor.localhost`
2. Postgres
    - ```
      DATABASE_URL="postgresql://postgres:postgres@hyvor-service-pgsql:5432/database_name"
      ```
    - Available on the host at `localhost:54321` if needed (for example, to connect to it using Tableplus).
3. Mailpit
   - For email testing
   - ```
     MAILER_DSN=smtp://hyvor-service-mailpit:1025
     ```
4. SeaweedFS
   - Local S3
   - ```
     S3_ENDPOINT=http://hyvor-service-seaweedfs:8333
     S3_REGION=us-east-1
     S3_BUCKET=default
     S3_KEY=
     S3_SECRET=
     ```

The following services can be started optionally by running `./services --monitoring`:

| Service    | URL                                                        | Docker host, Username, Password          |
| ---------- | ---------------------------------------------------------- | ---------------------------------------- |
| Grafana    | [http://grafana.localhost](http://grafana.localhost)       | hyvor-service-grafana:3000, admin, admin |
| Prometheus | [http://prometheus.localhost](http://prometheus.localhost) | hyvor-service-prometheus:9090, -         |

#### 3.2: Start one or more components

To run a specific component, run:

```shell
./run core
```

If you want to run another component, you can run it like this in a new terminal:

```shell
./run talk
```

Then visit the component URL in your browser:

-   [https://hyvor.localhost](https://hyvor.localhost)
-   [https://talk.hyvor.localhost](https://talk.hyvor.localhost)
-   ...

The `./run` script supports a couple of options:

```shell
# sync the design system files to the component (frontend/src/design)
# useful for developing the design system
./run core --design

# run E2E profile (the component must be configured for a E2E profile in compose.yaml)
./run core --e2e
```

### Stop

To stop all services, run:

```shell
docker compose down
```

To stop a specific component, run `CTRL+C` in the terminal where you ran the `./run` command.

### How it works

-   Code
    -   Each component has a Dockerfile that builds the development environment with all the required dependencies.
    -   They also have a `compose.yaml` file that sets up the containers, sometimes with additional services like Redis, etc.
    -   Everything runs in Docker containers, so you don't need to install anything on your local machine (except for basic requirements)
-   Domains
    -   Traefik listens to port 80 and 443 on your local machine.
    -   It routes requests to the correct service based on Docker labels using auto discovery.
    -   It uses the SSL certificates generated by `mkcert` to serve HTTPS.
    -   `mkcert` (usually) configures your OS and browser to trust the mkcert root certificate, so you don't see SSL warnings. A browser restart may be required.

### Adding a new component

1. `git submodule add <repository-url> <component-name>`
2. Update `$components` in `./init`
3. Add database name (`hyvor_<component>`) to `./meta/compose/pgsql/init.sh`

### PHPStorm Setup

-   CLI Interpreter.
    -   Go to Settings -> PHP, add new CLI interpreter.
    -   Select 'Docker, Vagrant, VM, Remote' -> Docker Compose, then the correct container
    -   Lifecycle -> Connect to existing container
-   Path mappings
    -   If the project uses bind mounts, it should be configured automatically.
    -   If not, add the path mappings manually to map from `<project>/backend` to /app/backend
-   PHPUnit
    -   Go to Settings -> PHP -> Test Frameworks
    -   Add new PHPUnit (PHPUnit by Remote Interpreter)
    -   Select the CLI interpreter you created earlier
    -   Set the composer autoload path
    -   Set default configuration path (usually `/app/backend/phpunit.dist.xml`)
-   PHPStan
    -   Go to Settings -> PHP -> Quality Tools -> PHPStan
    -   Enable PHPStan Inspection
    -   Set the interpreter
    -   Set the configuration path (usually `/app/backend/phpstan.dist.neon`)
    -   Go to Settings -> Editor -> Inspections -> PHP -> Quality Tools -> PHPStan
    -   Set Severity to 'Error'
