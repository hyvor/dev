# Component Guide

This is a guide on how to create a new component (product).

- Create 2 docker containers for frontend and backend (see Hyvor Blogs repo for example). These two will have a `dev` profile.
- You will also have a `e2e` container with a `e2e` profile (usually when you start writing E2E tests).
- Docker containers should run in the `hyvor-network` network.
- Set up composer watch syncing for the internal library and design system.

### Internal Library Syncing

We sometimes may need to update internal library code while developing the component.

First, make sure you have a `backend/packages` directory with a `.gitkeep` file in it. Add this to `.gitignore` as well. Then, in `composer.json`

```json
"repositories": {
    "local": {
        "type": "path",
        "url": "./packages/*",
        "options": {
            "symlink": true
        }
    }
},
```

The `./run` script will automatically sync the internal library to the `backend/packages/internal` directory. Any changes you make in the internal library will be reflected inside the backend container.

### Design System Syncing

You may also want to sync the design system to the component.
