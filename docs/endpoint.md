# Backend API Documentation – Login & Access Management

Base URL: `/api`

---

## authentication

### POST /auth/login

request
```json
{
  "username": "andi",
  "password": "123456"
}
```

response – single role
```json
{
  "status": "success",
  "token": "jwt_token"
}
```

response – multiple roles
```json
{
  "status": "choose_role",
  "session_token": "temp_jwt_token",
  "roles": [
    { "id": "uuid", "name": "finance" },
    { "id": "uuid", "name": "hrd" }
  ]
}
```

---

### POST /auth/select-role

header
```
authorization: bearer temp_jwt_token
```

request
```json
{
  "role_id": "uuid"
}
```

response
```json
{
  "status": "success",
  "token": "jwt_token"
}
```

---

## menus

### GET /menus

header
```
authorization: bearer jwt_token
```

response
```json
[
  {
    "id": "uuid",
    "name": "dashboard",
    "path": "/dashboard",
    "children": []
  }
]
```