#!/bin/bash
set -e

CONTAINER=mail_server

echo "📧 Creando cuentas de correo..."
docker exec -it $CONTAINER setup email add alice@server.local 'ClaveSegura1!'
docker exec -it $CONTAINER setup email add bob@server.local   'ClaveSegura2!'

echo "✅ Usuarios creados: alice@server.local y bob@server.local"

