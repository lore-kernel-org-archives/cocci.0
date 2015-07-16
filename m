From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed, 15 Jul 2015 17:21:28 -0700
Subject: [Cocci] [PATCH 0/2] coccinelle: extend pycocci checks
Message-ID: <1437006090-25479-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Cocccinelle has received quite a bit of features, one is the ability
to use git grep functionality for indexing. Another is some fixes for
parallelism support. Instead of just assuming everyone has the latest
release of coccinelle have the script check for the release installed
and use sensible defaults which are known to work the best. This also
infers what indexing option should be used for you:

 - Use glimpse if you have glimpseindex; otherwise:
 - Use git grep if you have a git tree; otherwise:
 - Use cocci grep

We'll use the new --jobs (paramap support) if the release is > 1.0.2,
otherwise we'll default to our old Python wrappar parallelism support.

This also preps up pycocci to be extended later with other tools, for
example we're considering to add SmPL patch proof support into pycocci
now, with the reqs checks stuff in place this should be rather easy to
ensure folks have the requirements present.

If there are no issues I'll push these into the Coccinelle git tree.

Luis R. Rodriguez (2):
  pycocci: add requirements class
  pycocci: figure out if to enable --jobs, --use-gitgrep or
    --use-glimpse

 tools/pycocci | 289 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 279 insertions(+), 10 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
