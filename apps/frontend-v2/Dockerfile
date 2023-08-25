FROM node:18-slim AS base
RUN yarn set version stable
 
# Prune the workspace for the `frontend-v2` app
FROM base as pruner
WORKDIR /app
COPY . .
RUN yarn dlx turbo prune --scope=frontend-v2 --docker 
 
# # Add pruned lockfile and package.json's of the pruned subworkspace
FROM base AS installer
WORKDIR /app
COPY --from=pruner /app/out/json/ .
COPY --from=pruner /app/out/yarn.lock ./yarn.lock
# Install only the deps needed to build the target
RUN yarn install --immutable
 
# Copy source code of pruned subworkspace and build
FROM base AS builder
WORKDIR /app
COPY --from=pruner /app/out/full/ .
COPY --from=installer /app/ .
RUN yarn dlx turbo run build --scope=frontend-v2
 
# # Start the app
# FROM builder as runner
# EXPOSE 8080
# CMD ["yarn", "workspace", "frontend-v2", "preview"]