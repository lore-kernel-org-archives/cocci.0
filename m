From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 18 Sep 2018 11:22:23 +0200
Subject: [Cocci] 0079-netdev-destructor.cocci very slow
In-Reply-To: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 (sfid-20180917_235548_596100_F1A753F4)
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 (sfid-20180917_235548_596100_F1A753F4)
Message-ID: <1537262543.2957.19.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2018-09-17 at 23:55 +0200, Hauke Mehrtens wrote:
> The 0079-netdev-destructor.cocci spatch in backports is very slow for
> me. For bigger files I get a warning that it takes over to 15 seconds to
> apply it to just one file, for the complete backports tree it takes over
> an hour to apply.
> 
> This is the patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/tree/patches/0079-netdev-destructor.cocci
> 
> When I remove the <-- --> in the first rule, it is applied in some
> seconds on the complete tree, so an speed improvement of about 100
> times, but it is not working correctly any more. ;-)
> 
> Is this normal or how can I improve the spatch to be faster? I am using
> coccinelle 1.0.7 build with default configure arguments against the
> libraries from Debian stable.

We've had this discussion before :-)
I think we determined that it was normal.

> If this is normal I should probably try to reduce the number of files it
> tries to apply this against in gentree.py before spatch gets started.

spatch should already try that internally, but perhaps with some extra
knowledge we can do a better job ...

johannes
