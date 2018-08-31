local jwt = require "resty.jwt"
local jwt_secret = os.getenv('JWT_SECRET')
local _M = {}

assert(jwt_secret ~= nil, "Environment variable JWT_SECRET not set")

function _M.verifyToken(x,keys)

    local key = ngx.req.get_method() .. ngx.var.request_uri

    for k,v in pairs(keys) do
        if string.match(key,v) ~= nil then
            local jwt_token = ngx.var.http_x_access_token
            if jwt_token == nil then
                ngx.exit(ngx.HTTP_UNAUTHORIZED)
            else
                if not jwt:verify(jwt_secret, jwt_token).verified then
                    ngx.exit(ngx.HTTP_FORBIDDEN)
                end
            end
            break
        end
    end

end

return _M