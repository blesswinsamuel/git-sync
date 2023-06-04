FROM registry.k8s.io/git-sync/git-sync:v3.6.5 as git-sync

FROM alpine

RUN apk add --no-cache git git-lfs openssh-client

COPY --from=git-sync /git-sync /git-sync

# Setting HOME ensures that whatever UID this ultimately runs as can write to
# files like ~/.gitconfig.
ENV HOME=/tmp
WORKDIR /tmp

# Default values for flags.
ENV GIT_SYNC_ROOT=/tmp/git

ENTRYPOINT ["/git-sync"]
