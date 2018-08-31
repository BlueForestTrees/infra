local jwt = require "resty.jwt"
local jwt_secret = os.getenv('JWT_SECRET')
local gateway = {}

assert(jwt_secret ~= nil, "Environment variable JWT_SECRET not set")

function gateway.verifyToken()
    local jwt_token = ngx.var.http_x_access_token
    if jwt_token == nil then
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    else
        assert(jwt_secret ~= nil, "Environment variable JWT_SECRET not set")
        if not jwt:verify(jwt_secret, jwt_token).verified then
            ngx.exit(ngx.HTTP_FORBIDDEN)
        end
    end
end

return gateway