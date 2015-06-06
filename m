From: johannes@sipsolutions.net (Johannes Berg)
Date: Sat, 06 Jun 2015 14:12:23 +0200
Subject: [Cocci] [PATCH 3/4] gentree.py: add SmPL patch equivalence
	proof support
In-Reply-To: <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20150606_021855_421040_8CC03CC0)
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20150606_021855_421040_8CC03CC0)
Message-ID: <1433592743.2467.7.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2015-06-05 at 17:10 -0700, Luis R. Rodriguez wrote:
> If you have an SmPL patch that you think is ready to replace
> a series of unified diff patches you can pass as an argument
> to gentree.py '--prove-cocci' with the cocci file as the
> an extra argument and gentree.py will try to prove equivalence
> between the unified diff series and your Coccinelle SmPL patch.
> 
> You can use this as a guide when trying to replace an existing
> unified diff series carried within backports with a respective
> Coccinelle SmPL patch. You can use this to get a warm fuzzy or
> to provide backports maintainers with a warm fuzzy of comfort
> that your SmPL patch is sufficient.

I don't like this at all.

gentree.py is supposed to be a tool to generate a new backport tree.
You're (ab)using it for (s)patch development purposes that it was never
intended for.

It's already grown to be a spaghetti mess of different options, some of
which cause partial tree creation (or no proper tree creation at all,
iirc) and I think adding more to this will make it unmaintainable.

Additionally, there's no real reason why this needs to be part of
gentree. In theory, you can just apply both patches to any kind of tree
(doesn't have to be a backport) and see the difference.

In practice, I understand that it might make sense to apply them to a
backport tree because that's where the original patch (non-spatch) came
from, since presumably you want to use it for development. However, I
still think this is far enough from the original purpose just like
test_cocci and profile_cocci that it shouldn't be there.

I'd support changing gentree to support a "up to this patch" mode, in
which it stops processing at a certain patch and other scripts can then
do remaining work like cocci profiling (which IMHO really shouldn't be
here at all) or this comparison testing.

I can also see how adding more to this script is convenient, since it's
just a few lines of code in the right place in the script, but this has
already made it complicated to follow all the different code paths and
change them appropriately for any changes.

As a consequence, I cannot support this change and would much rather
remove more of the cocci test options from here - really something like
profiling and equivalence testing should be part of a script provided by
upstream coccinelle anyway, instead of in the backports project.

johannes
