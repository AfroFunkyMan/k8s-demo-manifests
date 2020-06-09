ARG DEP_IMAGE=cr.yandex/crpio465qcfelrmo3fv8/esb-monorepo/production-dependencies:latest
FROM $DEP_IMAGE

ENV PORT=80

COPY dist/apps/controllers/metadata dist/apps/controllers/metadata

EXPOSE $PORT

ENTRYPOINT node --inspect=0.0.0.0:7777 dist/apps/controllers/metadata/main.js
