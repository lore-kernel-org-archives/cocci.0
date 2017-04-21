From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Apr 2017 21:32:06 +0200 (CEST)
Subject: [Cocci] modifying array initializers?
In-Reply-To: <1492800782.19290.1.camel@sipsolutions.net>
References: <1492780343.2564.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1704211607100.3038@hadrien>
 <1492800782.19290.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1704212131230.3038@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 21 Apr 2017, Johannes Berg wrote:

> On Fri, 2017-04-21 at 16:07 +0200, Julia Lawall wrote:
> >
> > Just add ..., here (note the comma at the end).
>
> I thought I tried that, but maybe not. It doesn't work - at least in my
> version - though:
>
> HANDLING: net/wireless/nl80211.c
> ?????
> previous modification:
>
> ? <<< static int wrap_fn(struct sk_buff *skb, struct genl_info *info)
> ? <<< {
> ? <<< return fn(skb, info);
> ? <<< }
> ? <<<?
> CONTEXT
> According to environment 2:
> ???rule starting on line 1.wrap_fn -> id _wrap_nl80211_wiphy_netns
> ???rule starting on line 1.fn -> id nl80211_wiphy_netns
>
> current modification:
>
> ? <<< static int wrap_fn(struct sk_buff *skb, struct genl_info *info)
> ? <<< {
> ? <<< return fn(skb, info);
> ? <<< }
> ? <<<?
> CONTEXT
> According to environment 2:
> ???rule starting on line 1.wrap_fn -> id _wrap_nl80211_vendor_cmd
> ???rule starting on line 1.fn -> id nl80211_vendor_cmd
>
> Fatal error: exception Failure("rule starting on line 1: already tagged
> fake token\n")
>
>
> Sounds like it doesn't like to add multiple things here, let me think
> about how to work around that.

If you don't find a solution, send back the rule and the code that causes
trouble, and I will take a look.

julia
