From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 8 Jun 2015 23:29:27 +0200
Subject: [Cocci] RFD: SmPL patch equivalence support strategy
Message-ID: <20150608212927.GU23057@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I recently respinned my old 2013 series on adding support for
SmPL patch equivalence support on the Linux backports project.
What this functionality did was to enable folks using regular
patches to replace them with a Coccinelle SmPL patch and then
get see a diff between both strategies. There are obviously
several ways to do this, the algorithm embraced in the tool
functionality extension I wrote can be summarized as follows
though:

Tree upstream: original code. Now copy it to two new trees,
Tree a, and Tree b.

Tree a: apply Coccinelle SmPL patch
Tree b: apply patch series

diff -u -p a/ b/

If there is equivalence the diff should yield 0 delta.
In practice there are some surprises which folks should
expect and because of this the order of choosing a/ first
instead of b/ was chosen here:

1) Extra new code (additions, green on git diff) are things
   that you have not yet covered on your Coccinelle SmPL patch.
2) Code removals observed (deletions, red in git diff) are
   things your Coccinelle SmPL patch did that your old
   patch series did not, so it was unexpected.

A person's first use of Coccinelle might be to expect 2)
to be "bad", its why I chose the order of extra code to
reflect deletions. In practice though 2) is pretty common
but its because it might show work you forgot to do over
an entire tree. In the end the order is quite subjective
but we need to pick one.

The above solution was implemented on the Linux backports
project but its integration was within the gentree.py script
and that script already does quite a lot of things for us,
we've decided its integration just adds complexity which
likely should instead be implemented within Coccinelle.

Are there other folks who could make use of this? If so I
could take some time to write a Coccinelle tool for this.
Are there any concerns if we were to work on this for
integration into Coccinelle? Any reason why we shouldn't?
Is the algorithm described above sufficient?

In practice the tool just displayed a 'git diff --stat'
output, if you wanted to see the actual differences you
would have to change directory to the copy directory created
and run 'git diff', as git was used for tracking the changes.
Using git is not a requirement, it was just convenian for us
as we had a debug git option for development on backports.
What we do for a generic tool might differ.

 Luis
