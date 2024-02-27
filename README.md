# Scripts For Managing Many Git Repositories

> mass-git-scripts

This repo contains a few scripts for managing large numbers of git
repositories, either all those belonging to a user or organization on GitHub, or
simply all repositories in a direct:ory.

The inspiration for this was the need to back up all of my personal repositories
(over 100) with full history and all branches. I thought it would make a good
side project to write a script to do this.

## Requirements

A few programs are required to run these scripts:

- [**jq**](https://stedolan.github.io/jq/): A lightweight and flexible
  command-line JSON processor
- [**parallel**](https://www.gnu.org/software/parallel/): A shell tool for
  executing jobs in parallel using one or more computers
- [**gh**](https://cli.github.com/): GitHub CLI

You should be able to install them with your local package manager, for example
on ubuntu:

```bash
sudo apt install jq parallel gh
```

## Installation

To use, clone this repository somewhere and add it to your path. For example:

```bash
git clone https://github.com/f3rno64/mass-git-scripts.git ~/.bin/mass-git-scripts

echo 'export PATH="$PATH:$HOME/.bin/mass-git-scripts"' >> ~/.bashrc
```

## Usage

The examples below assume you have installed this repository, and the scripts
within are available in your path.

### git-clone-all

> Repositories that are already present in the target folder are skipped. The
> command output will report the number of **skipped** and **cloned**
> repositories.

The **`git-clone-all`** script clones all repositories belonging to a user or
organization on GitHub, specified via the **--owner** flag.

The target directory in which the repositories will be cloned **must** be
specified and exist. Pass it via the **--dir** argument.

You can set the clone depth with **--depth**; by default, the
**entire history** is cloned.

To limit the number of repositories cloned, pass the **--limit** flag. The
default **--limit** flag value is **25**. If you wish to clone all repositories,
consider setting the limit to a very high value, like **--limit 1000**.

The script clones repositories in parallel, with the number of concurrent jobs
specified with the **--jobs** flag. The default number of jobs is
**8**.

Some examples:

```bash
git-clone-all --owner f3rno64 --dir ./f3rno64 --limit 200 --jobs 20
git-clone-all --owner google --dir ./google --limit 10000 --jobs 50 --depth 1
git-clone-all --owner microsoft --dir ./microsoft
```

### git-pull-all

> The command output will report the number of new commits pulled if there are
> any.

When you have many repositories in a single directory, and they are frequently
updated, **git-pull-all** can be used to update the active branch for each repo
with the latest changes from the active remote.

This is very useful if you keep all repositories for an organization (such as your
employer) in a single directory.

To use, just pass the directory containing the repositories as the first
argument to the script:

```bash
git-pull-all ~/.src/github/f3rno64
```

## Developing

To contribute, clone this repo and hack away! There is only one useful script
in the manifest, **`lint`**, which uses **shellcheck** and **markdownlint** to
lint the scripts and README.

Run it to ensure your changes are up to standard. It is also run as a
pre-commit hook.

Make sure to install dependencies for development with `pnpm i`.

## Conclusion

**mass-git-scripts** is a set of useful tools for anyone working with many git
repositories organized in separate folders by their owner (user or
organization).

Give it a try and see how it can improve your workflow.

## License

Distributed under the **MIT** license. See [**`LICENSE.md`**](./LICENSE.md)
for more information.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
