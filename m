From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Apr 2017 23:22:31 +0200 (CEST)
Subject: [Cocci] modifying array initializers?
In-Reply-To: <1492809572.24783.1.camel@sipsolutions.net>
References: <1492780343.2564.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704211607100.3038@hadrien>
 <1492800782.19290.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704212131230.3038@hadrien>
 <1492809572.24783.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1704212321530.3038@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 21 Apr 2017, Johannes Berg wrote:

>
> > > Sounds like it doesn't like to add multiple things here, let me
> > > think about how to work around that.
> >
> > If you don't find a solution, send back the rule and the code that
> > causes trouble, and I will take a look.
>
> I tried for a while now, but didn't find one. I think the problem is
> that it's evaluating all of these things at once, and then it doesn't
> know how to place two of the new wrap_fn functions when they both
> should go before nl80211_ops[].
>
> The code is net/wireless/n80211.c, and my current version of the
> spatch, as you suggested, is this:
>
>
> @@
> identifier fn;
> fresh identifier wrap_fn = "_wrap_" ## fn;
> @@
> +static int wrap_fn(struct sk_buff *skb, struct genl_info *info)
> +{
> +       return fn(skb, info);
> +}
> +

Use ++ instead.  You may need to put the new function all on one line.

julia

> static struct genl_ops nl80211_ops[] = {
>         ...,
>         {
> -               .doit = fn,
> +               .doit = wrap_fn,
>                 ...
>         },
>         ...
> };
>
>
> It *does* work to match multiple .doit instances now, but it seems to
> get confused when trying to place more than one wrap_fn right before
> nl80211_ops[].
>
> I tried pulling it out into a separate rule, attaching it to some other
> token, e.g. after nl80211_post_doit(), but I can't seem to get that to
> work.
>
> johannes
>
