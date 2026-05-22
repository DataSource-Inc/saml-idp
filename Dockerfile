FROM node:18-alpine

# samlp dependency is github:mcguinness/node-samlp - npm needs git to clone it.
RUN apk add --no-cache git

ADD ./package.json package.json
RUN npm install

EXPOSE 7000 7000

# ADD ./node_modules node_modules
ADD ./lib lib
ADD ./views views
ADD ./app.js app.js
ADD ./config.js config.js
ADD ./idp-public-cert.pem idp-public-cert.pem
ADD ./idp-private-key.pem idp-private-key.pem
ADD ./public public

ENTRYPOINT [ "node",  "app.js", "--acs", "https://foo.okta.com/auth/saml20/example", "--aud", "https://www.okta.com/saml2/service-provider/spf5aFRRXFGIMAYXQPNV" ]
