From: knut.omang@oracle.com (Knut Omang)
Date: Thu,  4 Jan 2018 14:39:33 +0100
Subject: [Cocci] [PATCH v3 0/1] Support for generalized use of make C={1,
	2} via a wrapper program
Message-ID: <cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch implements features to make it easier to run checkers on the
entire kernel as part of automatic and developer testing.

This is done by replacing the sparse specific setup for the C={1,2} variable
in the makefiles with setup for running scripts/runchecks, a new program that
can run any number of different "checkers". The behaviour of runchecks is
defined by simple "global" configuration in scripts/runchecks.cfg which can be
extended by local configuration applying to individual files, directories or
subtrees in the source.

The runchecks.cfg files are parsed according to this minimal language:

       # comments
       # "Global configuration in scripts/runchecks.cfg:
       checker <name>
       typedef NAME regex
       run <list of checkers or "all"

       # "local" configuration:
       line_len <n>
       except checkpatch_type [files ...]
       pervasive checkpatch_type1 [checkpatch_type2 ...]

With "make C=2" runchecks first parse the file scripts/runchecks.cfg, then
look for a file named 'runchecks.cfg' in the same directory as the source file.
If that file exists, it will be parsed and it's local configuration applied to
allow suppression on a per checker, per check and per file basis.
If a "local" configuration does not exist, either in the source directory or
above, make will simply silently ignore the file. This way the semantics
of "no in-tree runchecks.cfg file" is equivalent to a configuration where
all checks have been suppressed.

The idea is that the community can work to add runchecks.cfg files to
directories, serving both as documentation and as a way for subsystem
maintainers to enforce policies and individual tastes as well as TODOs and/or
priorities, to make it easier for newcomers to contribute in this area. By
ignoring directories/subtrees without such files, automation can start right
away as it is trivially possible to run errorless with C=2 for the entire
kernel.

For the checker maintainers this should be a benefit as well: new
or improved checks would generate new errors/warnings. With automatic testing
for the checkers, these new checks would generate error reports and cause
builds to fail. Adding the new check a 'pervasive' option at the top level or
even for specific files, marked with a "new check - please consider fixing" comment
or similar would make those builds pass while documenting and making the new check
more visible.

The patch includes documentation with some more details.

This patch has evolved from an earlier shell script implementation I made
as only a wrapper script around checkpatch. That version have been used for a
number of years on a driver project I worked on where we had automatic checkin
regression testing. I extended that to also run checkpatch to avoid having to
clean up frequent unintended whitespace changes and style violations from others...

I have also tested this on some directories I am familiar with.  The
result of that work is available in two patch sets of 10 and 11 patches.
I will post these fixes as separate patch sets later.

Version 2 and 1 of this set and related discussion can be found here:

   v2: https://lkml.org/lkml/2017/12/16/343
   v1: https://lkml.org/lkml/2017/11/16/458

Changes from v2:
-----------------
* Squashed patches #1 and #2 from v2.
  Fixed a few spelling errors + some suggested text improvements
  in the docs.
* Shelved patch #3 as it's usefulness is not clear
* Removed patch #4-#5 as they were included here
  as examples for discussion
* rebased to v4.15-rc6

Changes from v1:
-----------------
Based on feedback, the implementation is completely rewritten and extended.
Instead of patches to checkpatch, and a sole checkpatch focus, it is now a
generic solution implemented in python, for any type of checkers, extendable
through some basic generic functionality, and for special needs by subclassing
the Checker class in the implementation.

This implementation fully supports checkpatch, sparse and
checkdoc == kernel-doc -none, and also has been tested with coccicheck.
To facilitate the same mechanism of using check types to filter what
checks to be suppressed, I introduced the concept of "typedefs" which allows
runchecks to effectively augment the check type space of the checker in cases
where types either are not available at all (checkdoc) or where only a few
can be filtered out (sparse)

With this in place it also became trivial to make the look and feel similar
for sparse and checkdoc as for checkpatch, with some optional color support
too, to make fixing issues in the code, the goal of this whole exercise,
much more pleasant IMHO :-)

Thanks,
Knut

Knut Omang (1):
  runchecks: Generalize make C={1,2} to support multiple checkers

 Documentation/dev-tools/coccinelle.rst |  12 +-
 Documentation/dev-tools/index.rst      |   1 +-
 Documentation/dev-tools/runchecks.rst  | 215 ++++++++-
 Documentation/dev-tools/sparse.rst     |  30 +-
 Documentation/kbuild/kbuild.txt        |   9 +-
 Makefile                               |  23 +-
 scripts/Makefile.build                 |   4 +-
 scripts/runchecks                      | 734 ++++++++++++++++++++++++++-
 scripts/runchecks.cfg                  |  63 ++-
 scripts/runchecks_help.txt             |  43 ++-
 10 files changed, 1114 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/dev-tools/runchecks.rst
 create mode 100755 scripts/runchecks
 create mode 100644 scripts/runchecks.cfg
 create mode 100644 scripts/runchecks_help.txt

base-commit: 30a7acd573899fd8b8ac39236eff6468b195ac7d
-- 
git-series 0.9.1
