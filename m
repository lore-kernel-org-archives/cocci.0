Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40166C433EF
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XGRK5FBGaVWT/q5DmMSpxCuTSepgVJrAFHxGKRpPMkM=;
  b=dT7iWVmXUHSYfpHuLYjZdfzKXSZ57qCRSUF0I3Jq5Iupf6JYupNkYN6f
   OenAo6qE1A1cZxv3zOBRyI8ajlB5wLIUKjmzHVEIAwuk6+0CseObYSR9o
   LGVTEZoXTz1l1faqzVfYabXmChXiGaftCxX/q4D14qkmx5quf9bpsZhiv
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37264565"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 10:10:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54EF9E4374; Fri, 20 May 2022 10:10:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F69FE0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 10:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XGRK5FBGaVWT/q5DmMSpxCuTSepgVJrAFHxGKRpPMkM=;
  b=KbxFbbXlElsFjaTTaYwf5slbBa/q9A8nOZ6/e/wKTSO6AEVBx5+40TQj
   ZFCeFG+XKVb87u0X6a9sqNihKwLdrUq2evlAymJSLNaKMH2UizJvKoNRi
   1LvYi5GRo+nt6s2Iq774+HjxQGHzJ7s/iqqCDL11t6HjUwV9FYjoh/5RM
   M=;
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37264540"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 10:10:11 +0200
Date: Fri, 20 May 2022 10:10:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci@inria.fr
In-Reply-To: <4a2ec549dfaa78af3bab6a1bf4dcb3aadc2797e5.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.22.394.2205201007470.2929@hadrien>
References: <9a0a9798f3be1950e11155a87d357442122e1685.camel@sipsolutions.net>  <alpine.DEB.2.22.394.2205191426480.2389@hadrien> <4a2ec549dfaa78af3bab6a1bf4dcb3aadc2797e5.camel@sipsolutions.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] more precise switch/case matching
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 402
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205201007470.2929%40hadrien>



On Fri, 20 May 2022, Johannes Berg wrote:

> Hi Julia,
>
> Thanks for your answer!
>
> > This one might work if you make the rule in two steps:
> >
> > @@
> > expression E;
> > position p;
> > identifier OTHER =~ "NL80211_CHAN_WIDTH_(?!320)";
> > @@
> >
> > switch (E) {
> > case OTHER:
> > case NL80211_CHAN_WIDTH_320@p:
>
> Interestingly, I had actually played with that too, but didn't want to
> make my email overly long. However, somehow I had not gotten it to work
> with position matches either.
>
> Your version does work, mostly (see below).
>
> > @@
> > expression E;
> > position r.p;
> > @@
> >
> > switch (E) {
> > +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
> > case NL80211_CHAN_WIDTH_320@p:
> > +#endif
> > }
> >
> > A ... before the +if might be helpful if the above isn't sufficient.
>
> That doesn't parse.
>
> But I put a 'break' after the +#endif to catch the case I wanted.

OK, I also considered that.

>
> > > @@
> > > expression E, value;
> > > @@
> > > switch (E) {
> > > +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
> > > case NL80211_CHAN_WIDTH_320:
> > > ...
> > > (
> > >  break;
> > > >
> > >  fallthrough;
> > > >
> > >  return;
> > > >
> > >  return value;
> > > )
> > > +#endif
> > > }
> > >
> > > it actually results in adding only the +#if line, never the +#endif
> > > line, which is a bit surprising?
> >
> > Maybe it will work if you duplicate the + line in each branch of the
> > disjunction.  Actually, it should have complained about that...
> >
>
> Indeed that works, but no complaints.
>
>
> Now, I don't need this to deal with everything - we check this spatch in
> our CI pipelines and compile afterwards so that we know it did the right
> thing, so really we just use spatch because patches break all the time
> when things just change slightly (context).
>
> What ended up working for me is the below spatch. One thing I don't
> understand there is the second @p match, it feels like in that case it
> shouldn't match if there's no OTHER ahead of it, but it still does ... I
> first thought I wanted "position q != r.p" but that had the opposite
> effect, making both spatches apply in the same place, rather than in
> mutually exclusive places ...

I believe that for switch there is a direct link from the switch header to
each of the cases, and another that falls through from one case to the
next.  It's very complex...

julia

>
> Anyway, I think it works now, thanks for the ideas!
>
> johannes
>
> @r@
> expression E;
> position p;
> identifier OTHER =~ "NL80211_CHAN_WIDTH_(?!320)";
> @@
>
> switch (E) {
> case OTHER:
> case NL80211_CHAN_WIDTH_320@p:
> }
>
> @@
> expression E;
> position r.p;
> @@
> switch (E) {
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
> case NL80211_CHAN_WIDTH_320@p:
> +#endif
>   break;
> }
>
> @@
> expression E, value;
> position r.p;
> @@
>  switch (E) {
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>  case NL80211_CHAN_WIDTH_320@p:
> (
>   ...
>   break;
> +#endif
> |
>   ...
>   fallthrough;
> +#endif
> |
>   ...
>   return;
> +#endif
> |
>   ...
>   return value;
> +#endif
> )
>  }
>
>
