[ ![Codeship Status for WorldBibleSchool/nutool](https://codeship.com/projects/84a938e0-1eb7-0134-67cf-3632048523f1/status?branch=master)](https://codeship.com/projects/160174)

Nu-tool is the social e-learning platform.

# Local Environment Setup

Be sure to install docker and docker-compose. Use official docks for that
to find specifics for your OS :
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker-compose](https://docs.docker.com/compose/install/)

For convenience and social authentication purposes, you should edit your
hosts file.

# Osx

```sudo nano /etc/hosts```

Add _docker.dev_ as the app domain. This domain is currently settled for
development.

On OSX docker is used with virtual machine. So you need to find out the
ip of VM with ```docker-machine ip default``` or the name of the machine
you use for running docker. Run ```docker-machine ls``` to see the list.
Add the ip to your hosts file:
```
192.168.99.100  docker.dev
```

For convenience, I suggest use aliases for console commands (that will
make your workflow slower). Edit your ```.bash_profile``` or
```.bash_aliases``` if you have one.

```
alias comp='docker-compose'
alias crw='docker-compose run web'
alias dms='docker-machine start'
alias dm='docker-machine'

```

# Environment variables

In order to use features of the application, you need to set your
environment variables. Copy ```.env.example``` file  to ```.env```
fill the variables
------------------

Assuming, you have done everything correctly you should build the web
image first. This should be done to enable bundle cache container first.
```
# comp build web
docker-compose build web
```

Finally, you'll need to run your database migrations for the database:
```
# crw rails db:migrate
docker-compose run web rails db:migrate
```

You can run the development server with a simple ```docker-compose up```.
That can take some time, while docker pulls necessary images.
```docker-compose up``` runs all containers at once.

You may want to run only web image:
```
docker-compose up web
```

or to run tests only:
```
docker-compose run test rspec
```

To run guard constantly running your spec files when you change them:
```
docker-compose up test
```

When you add any gems to your Gemfile - no need to rebuild the container
and install all the gems from scratch:
```
# crw bundle install
docker-compose run web bundle
```

To run any rails (rake) task, you may:
```
# crw rails ...
docker-compose run web rails ...
```

---

Use http://docker.dev:8080 to visit the website and
http://docker.dev:1080 to review outgoing emails that are catched

------

To check the application most close to the heroku hosting environment,
you should use the ```docker-compose.production.yml```:

```
docker-compose -f docker-compose.production.yml run app rails db:migrate
docker-compose -f docker-compose.production.yml up
```

## Clone Production DB from Heroku

Local database must be deleted for this.

```
heroku pg:pull postgresql-defined-80513 nu-tool_development --app nutool
```
