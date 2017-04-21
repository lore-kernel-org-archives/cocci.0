From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 21 Apr 2017 23:24:01 +0200
Subject: [Cocci] modifying array initializers?
In-Reply-To: <alpine.DEB.2.20.1704212321530.3038@hadrien>
References: <1492780343.2564.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704211607100.3038@hadrien>
 <1492800782.19290.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704212131230.3038@hadrien>
 <1492809572.24783.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704212321530.3038@hadrien>
Message-ID: <1492809841.25417.0.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-04-21 at 23:22 +0200, Julia Lawall wrote:

> > @@
> > identifier fn;
> > fresh identifier wrap_fn = "_wrap_" ## fn;
> > @@
> > +static int wrap_fn(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +???????return fn(skb, info);
> > +}
> > +
> 
> Use ++ instead.??You may need to put the new function all on one
> line.

Indeed, that works (and yes, I had to put it on a single line)

Thanks!

johannes
