Committy
========

Introduction
------------

A Vim plugin for using single line comments as commit messages.

It is intended to encourage regular commits.

Usage
-----

1. Add an @ after the # in a comment.
2. This indicates you wish to use this comment as a commit.
3. Unstaged changes in the current file will be staged and committed using the comment as the commit message.

Example
-------

```python
# This comment is ignored
#@ This comment is my commit message
```

Upon :w or :wq, the comment is modified to become a normal comment, the file is staged and committed.

```python
# This comment is ignored
# This comment is my commit message
```

Compatability
------------

Currently intended for use with Python files, with single line comments.

Installation
------------

If you are using Vim 8+:

```bash
git clone https://github.com/benjaminr/committy.git ~/.vim/pack/vendor/start/committy
```
