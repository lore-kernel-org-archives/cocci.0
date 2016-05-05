From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:39 -0700
Subject: [Cocci] [PATCH 0/5] coccinelle: extend testing with check-pycocci
Message-ID: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle has its own test framework built-in to spatch, this
is used to test against small tests cases written in tests/*.c
with their respective tests/*.cocci and tests/*.res file. This
is however a bit limited as it only handles single C file. In
real world projects where more files are used we need to support
testing against larger series of file structures.

pycocci already had SmPL <=> Patch equivalence support, we can
leverage this to extend testing in a more generic fashion. This
does that work.

For now, we disable pycocci-tests given we touch your git tree
for these tests.

Luis R. Rodriguez (5):
  pycocci: use os.path.abspath() for gitname
  pycocci: add git branch support to git library
  pycocci: skip proof if git dir is dirty
  pycocci: add clean version of SmPL <=> Patch equivalence proof support
  pycocci: enable SmPL <=> Patch equivalence tests

 Makefile                                           |  3 +
 docs/pycocci.1                                     | 24 +++++-
 scripts/pycocci-check.sh                           |  8 ++
 tests/pycocci/code/0001-proto3/proto3.c            |  7 ++
 tests/pycocci/code/0001-proto3/proto3.h            |  3 +
 tests/pycocci/patches/0001-proto3.cocci            | 11 +++
 .../0001-proto3/0001-change-prototypes.patch       | 18 +++++
 tools/pycocci                                      | 89 ++++++++++++++++------
 8 files changed, 140 insertions(+), 23 deletions(-)
 create mode 100755 scripts/pycocci-check.sh
 create mode 100644 tests/pycocci/code/0001-proto3/proto3.c
 create mode 100644 tests/pycocci/code/0001-proto3/proto3.h
 create mode 100644 tests/pycocci/patches/0001-proto3.cocci
 create mode 100644 tests/pycocci/patches/0001-proto3/0001-change-prototypes.patch

-- 
2.7.2
