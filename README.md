# Health Practice

## Quick facts

- Ruby 3.0.0
- Rails 6.1
- Needs mongo and redis

## Running tests

### Local environment

1. Make sure `mongo` and `redis` are running
2. `bin/rails test`

### Docker environment

`docker-compose up --build` will set up 5 containers:

1. `mongo`
2. `redis`
3. `web` - the application running in development mode
4. `checker` - a small container that makes a `GET /healthiness` request every 2 seconds
5. `tests` - runs the test suite once

## Container configuration

The application is shipped via a Docker image and is configured purely through environment variables. Here they are:

```bash
MONGODB_HOSTS=localhost:27017

REDIS_HOST=localhost
REDIS_DEFAULT_DB=0
REDIS_USER
REDIS_PASSWORD
```
