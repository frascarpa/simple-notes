# simple-notes
serve the be folder with apache on port 8088.

With postman, call http://localhost:8088/~fscarpa/api/create_user.php

make a post call: body: raw and send the user fields (nickname, email, password)

backup db with `pg_dump -h localhost -U postgres simple-notes > db.sql`
restore db with `psql -h localhost -U postgres -d simple-notes < db.sql`