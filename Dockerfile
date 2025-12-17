FROM nixpkgs/nix AS build

WORKDIR /src

# copy shell.nix and build environment first, so it will be cached
ADD shell.nix /src
RUN nix-shell --command "echo shell ready"

# copy Gemfile and Gemfile.lock first for dependency caching
COPY Gemfile* /src/
RUN nix-shell --command "bundle config set --local path 'vendor/bundle' && bundle install"

# copy source
COPY . /src/

FROM ruby:3.2-slim AS final

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY --from=build /src /app

# set user to nonroot user
RUN useradd -m -u 1000 nonroot
USER nonroot:nonroot

# Expose port 3000
EXPOSE 3000

# run rails server
CMD ["bundle", "exec", "bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
