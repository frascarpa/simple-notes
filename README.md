#  BE
serve the `be` folder on port 8088. (make sure htaccess rewrite is working properly)

backup db with `pg_dump -h localhost -U postgres simple-notes > db.sql`
restore db with `psql -h localhost -U postgres -d simple-notes < db.sql`

run `composer install` for installing the JWT dependency needed for authentication. 

# FE

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```
Configure the baseurl inside api.js with the proper FE webserver address (all the requests will be proxied to BE).

Configure vue.config.js with the proper address of the BE api endpoint, to be used as target of the proxy.