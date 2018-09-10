From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 10 Sep 2018 12:43:44 +0200 (CEST)
Subject: [Cocci] New release after 1.0.7?
In-Reply-To: <1536564277.3224.7.camel@sipsolutions.net>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 (sfid-20180814_152007_774372_35ED45D6)
 <1536564277.3224.7.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1809101241150.3655@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 10 Sep 2018, Johannes Berg wrote:

> Julia,
>
> On Tue, 2018-08-14 at 15:19 +0200, Julia Lawall wrote:
>
> > Sorry, I'm not sure where 1.0.7 came from. [...]
>
> > I would indeed like to make a release now that the compiations issues are
> > resolved and things seem more stable.
>
> Were you able to clear this up?
>
> I see now that the website advertises the 1.0.7 release, however
>
>  * it's not tagged in git(hub) - all previous releases have a tag
>  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
>    the website
>  * it *looks* like the actual 1.0.7 release was cut from a much newer
>    git commit, likely with the fix?

I'm still somewhat lost about it.  There is now a 1.0.7 source code on the
web site, which is the proper 1.0.7.  But the binaries on the web site are
still 1.0.6.  The previous thing that seemed to be 1.0.7 was an accidental
side effect of a test of the release script.  I think that my engineer was
waiting me to confirm something before putting a tag in github, but I'm
not sure what I was to confirm.  I will try to clear everything up.  But
the source code on the Coccinelle website is the official 1.0.7.

julia
