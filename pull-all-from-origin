#!/usr/bin/env bash

N_REPOS_UPDATED=0
N_REPOS_SKIPPED=0

INITIAL_PATH="$(pwd)"

INPUT_REPO_BASE="$*"

if [[ -z "$INPUT_REPO_BASE" ]]; then
  REPO_BASE_DIR_PATH="$(pwd)"
else
  REPO_BASE_DIR_PATH="$(pwd)/$INPUT_REPO_BASE"
fi

if [[ ! -d "$REPO_BASE_DIR_PATH" ]]; then
  echo "$REPO_BASE_DIR_PATH is not a directory."
  exit 1
fi

cd "$REPO_BASE_DIR_PATH" || exit 1

GIT_REPO_COUNT="$(find $REPO_BASE_DIR_PATH -maxdepth 1 -type d -exec test -e '{}/.git' ';' -print | wc -l)"

echo "Found $GIT_REPO_COUNT git repositories in $REPO_BASE_DIR_PATH to update..."
echo ""

for DIR in ./*; do
  if [[ ! -d "$DIR" ]]; then
    continue
  fi

  REPO="$(basename "$DIR")"

  cd "$DIR" || exit 1

	if [[ ! -d "./.git" ]]; then
    cd ..
		continue
	fi

	ACTIVE_REMOTE="$(git rev-parse --abbrev-ref --symbolic-full-name @\{u\} | cut -d'/' -f1)"
	ACTIVE_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

	if [[ -n $(git status --porcelain) ]]; then
    N_REPOS_SKIPPED=$((N_REPOS_SKIPPED + 1))
		echo "  - $REPO: uncommitted changes, skipping..."
    cd ..
		continue
	fi

  HASH_BEFORE=$(git rev-parse HEAD)

  git pull "$ACTIVE_REMOTE" "$ACTIVE_BRANCH" > /dev/null 2>&1

  HASH_AFTER=$(git rev-parse HEAD)
  N_COMMITS=$(git rev-list --count "$HASH_BEFORE".."$HASH_AFTER")

  if [[ "$HASH_BEFORE" != "$HASH_AFTER" ]]; then
    echo "  - $REPO: pulled $N_COMMITS new commits (branch $ACTIVE_BRANCH from $ACTIVE_REMOTE)"
    N_REPOS_UPDATED=$((N_REPOS_UPDATED + 1))
  else
    echo "  - $REPO: up to date"
  fi

  cd ..
done

cd "$INITIAL_PATH" || exit 1

echo ""

if [[ -z $N_REPOS_UPDATED ]]; then
  echo "No repositories were updated."
else
  echo "Updated $N_REPOS_UPDATED, skipped $N_REPOS_SKIPPED git repos."
fi
