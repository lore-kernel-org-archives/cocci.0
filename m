From: remicles2@gmail.com (Remington Furman)
Date: Fri, 1 Dec 2017 09:57:27 -0800
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <1512116859.25588.4.camel@sipsolutions.net>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
Message-ID: <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Johannes and Julia,

Wow, you two are great.? Thank you for the quick response.? More
notes below, including another spatch error after downgrading to
spatch 1.0.4.

On 12/01/2017 12:27 AM, Johannes Berg wrote:
 > +cocci list
 >
 > Hi,
 >
 > Looks like you made a really deep investigation here - awesome, thanks
 > for doing that!

It's the least I could do, considering the work you've put in
before me.

 > On Thu, 2017-11-30 at 21:43 -0800, Remington Furman wrote:
 >>
 >> Full log using genl-const.cocci
 >> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
 >> meta: parse error:
 >>??? File "./patches/0027-genl-const/genl-const.cocci", line 2, column 
10,
 >> charpos = 13
 >>??? around = '__genl_const',
 >>??? whole content = attribute __genl_const;
 >> [...snip callstack...]
 >
 > FWIW, the patch is pretty simple:
 >
 > @@
 > attribute __genl_const;
 > @@
 > (
 > -const struct genl_multicast_group
 > +__genl_const struct genl_multicast_group
 > |
 > -const struct genl_ops
 > +__genl_const struct genl_ops
 > )
 >
 > (yes, that's the full patch)

I had considered trying to manually apply the patch, but didn't
know what files it would touch, or if spatch would fail on other
patches later on.

 >> This is very similar to this problem:
 >> <https://www.spinics.net/lists/backports/msg04216.html>
 >> The conclusion of that thread is that the --integrate workflow is
 >> no longer supported.
 >>
 >> However, I am not using --integrate, and I am still getting
 >> errors about parsing '__genl_const'.
 >
 > Yeah this --integrate is unrelated to the problem - the problem is that
 > spatch can't parse this patch (any more).
 >
 >> Is that a bug in the patch
 >> or possibly a regression in spatch?
 >
 > I think it's a regression in spatch.

Ok, I'm glad Julia confirmed that the behavior changed between
releases.

 >> I've tried v4.14-rc2 also,
 >> but nothing older.
 >
 > That's a kernel version so not really relevant - spatch doesn't even
 > attempt to apply the changes since it can't parse them.
 >
 >> This page has a lot of great example info, and suggested that it
 >> could be a problem with my version of spatch. Specifically, that
 >> I was missing the menhir and libmenhir-ocaml-dev packages when
 >> building Coccinelle and a rebuild should help.
 >> <http://stonyslp.blogspot.com/2017/08/backport-driver.html>
 >
 > That I don't know - I've never built spatch myself.

If I remember correctly, I had to because the version in my package
manager was only 1.0.0-rc19, and that was too old for the backports
tag I checked out.? So, I chose the latest release in git.

 >> Unfortunately, I still have the same errors after running make
 >> distclean and rebuilding.
 >>
 >> I have:
 >> coccinelle $ git describe --tags
 >> 1.0.6-365-gd73c6e6
 >> coccinelle $ spatch --version
 >> spatch version 1.0.6-00365-gd73c6e6 compiled with OCaml version 4.01.0
 >> Flags passed to the configure script: [none]
 >> OCaml scripting support: yes
 >> Python scripting support: yes
 >> Syntax of regular expresssions: PCRE
 >
 > That seems reasonable as far as configuration is concerned.
 >
 >> I found this patch which describes how older versions can't
 >> handle the __genl_const changes (20150209):
 >> <https://www.spinics.net/lists/backports/msg03223.html>
 >>
 >> But, I also see commit 748116c8 from shortly after (20150507)
 >> which introduced genl-const.cocci and says only spatch 1.0.0-rc23
 >> is needed.
 >
 > Right.
 >
 >> I feel like I'm close to figuring this out, but would appreciate
 >> any help or pointers.
 >
 > Yeah I think you're pretty close.
 >
 > Can you try obtaining/building spatch 1.0.4? That definitely works for
 > me, so I think there's probably a regression in spatch somewhere
 > between 1.0.4 and the version that you're running.
 >
 > johannes

Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
fine.? But, later on my CPU was held at 100% for 29 minutes:

Applying SmPL patch 0079-netdev-destructor.cocci
[...waited 29 minutes...]
^CTraceback (most recent call last):
 ? File "./gentree.py", line 1107, in <module>
 ??? ret = _main()
 ? File "./gentree.py", line 724, in _main
 ??? logwrite=logwrite)
 ? File "./gentree.py", line 906, in process
 ??? failure = apply_patches(args, "backport", source_dir, 'patches', 
bpid.target_dir, logwrite)
 ? File "./gentree.py", line 601, in apply_patches
 ??? output = sprocess.communicate()[0]
 ? File "/usr/lib/python2.7/subprocess.py", line 791, in communicate
 ??? stdout = _eintr_retry_call(self.stdout.read)
 ? File "/usr/lib/python2.7/subprocess.py", line 476, in _eintr_retry_call
 ??? return func(*args)
KeyboardInterrupt


Any ideas there?? Perhaps I will try another release version of
spatch and report back.? Or I will update the genl-const.cocci
patch and try the latest spatch release again.

Thank you,
Remington
