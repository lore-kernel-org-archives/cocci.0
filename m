From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed,  4 May 2016 22:30:52 -0700
Subject: [Cocci] [RFC 0/2] coccinelle: extend test coverage
Message-ID: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I wanted to extend tests coverage for coccinelle but noticed
that tests are limited to single c file, these are attached
to respective .res files, but this also means that you have
a direct relationship and requirement between tests from
a single C file and a respective cocci file.

To go wild we want to be able to support really complex
types of examples. Fortunatley the backports project has
been using Coccinelle extensively daily, when a backports
developers needed to replace a series of patches with a
Coccinelle patch pycocci was extended to provide 
SmPL <--> Patch equivalence support. We can easily take
advantage of this to extend Coccinelle test cases way
beyond a single C file, but to more complex real life
style projects.

I don't think we should convert all test cases to this
new mechanism but, I'd like to see what are folks' thoughts
over using pycocci SmPL <--> Patch equivalence proof support
to help expand the tests cases for Coccinelle.

Luis R. Rodriguez (2):
  pycocci: add missing new line
  tests: convert sp.cocci test to pycocci proof

 Makefile                            | 1 +
 scripts/test.sh                     | 8 ++++++++
 tests/{sp.cocci => 0001-sp.cocci}   | 0
 tests/0001-sp/replace-typedef.patch | 9 +++++++++
 tests/{ => code/0001-sp}/sp.c       | 0
 tests/sp.res                        | 4 ----
 tools/pycocci                       | 2 +-
 7 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100755 scripts/test.sh
 rename tests/{sp.cocci => 0001-sp.cocci} (100%)
 create mode 100644 tests/0001-sp/replace-typedef.patch
 rename tests/{ => code/0001-sp}/sp.c (100%)
 delete mode 100644 tests/sp.res

-- 
2.7.2
