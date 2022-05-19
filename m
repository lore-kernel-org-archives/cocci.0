Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C32C433F5
	for <cocci@archiver.kernel.org>; Thu, 19 May 2022 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=c7D4kZy3/IC6BR4EhuBPyvop/uJARrWetY9ve88AYRg=;
  b=GOnGJQiiA4ROMkeSHmCflavu8hXUWTX8RV7QxDWHJAAIJityPA9FWbNZ
   Yy8A1XLyuz6xMS2F6TslljE86xfZyT0Pz7Lv1sbUfTAjHTHvtHaGPfema
   GCAyEMxfF1lVFPZi/3NhTZpaxPXPPL6Q2drjLIi8hRpz4oE/h1Z+DDTSQ
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
X-IronPort-AV: E=Sophos;i="5.91,237,1647298800"; 
   d="scan'208";a="37119518"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2022 14:31:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75AB2E0096; Thu, 19 May 2022 14:31:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8F1F3E0094
	for <cocci@sympa.inria.fr>; Thu, 19 May 2022 14:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c7D4kZy3/IC6BR4EhuBPyvop/uJARrWetY9ve88AYRg=;
  b=nHO5qvvu0L4UFv1k2dOYsDwOHSlLGnzUlupH6vqlmbLihFBzsmdLRZIq
   elUHreZUWXYiL/+EhxUrauU9SrimGWCYVxvdpNcwHeA9k3EDXEaGYokHN
   5WvS5f33Z2LMdqSkaBVVOlmypwc4iRrUnK7zYp9aWCVMw/EbGbgcRsPhw
   U=;
X-IronPort-AV: E=Sophos;i="5.91,237,1647298800"; 
   d="scan'208";a="37119512"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:31:37 +0200
Date: Thu, 19 May 2022 14:31:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci@inria.fr
In-Reply-To: <9a0a9798f3be1950e11155a87d357442122e1685.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.22.394.2205191426480.2389@hadrien>
References: <9a0a9798f3be1950e11155a87d357442122e1685.camel@sipsolutions.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] more precise switch/case matching
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 399
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205191426480.2389%40hadrien>



On Thu, 19 May 2022, Johannes Berg wrote:

> Hi,
>
> So I'm trying to do something like this:
>
> @@
> expression E;
> identifier OTHER =~ "NL80211_CHAN_WIDTH_(?!320)";
> @@
> switch (E) {
> case OTHER:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
> case NL80211_CHAN_WIDTH_320:
> +#endif
> }

This one might work if you make the rule in two steps:

@@
expression E;
position p;
identifier OTHER =~ "NL80211_CHAN_WIDTH_(?!320)";
@@

switch (E) {
case OTHER:
case NL80211_CHAN_WIDTH_320@p:
}

@@
expression E;
position r.p;
@@

switch (E) {
+#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
case NL80211_CHAN_WIDTH_320@p:
+#endif
}

A ... before the +if might be helpful if the above isn't sufficient.

>
>
> which I _wanted_ to add both the + lines only in case there was
> something like
>
>         switch (chandef->width) {
>         case NL80211_CHAN_WIDTH_20_NOHT:
>         case NL80211_CHAN_WIDTH_20:
>         case NL80211_CHAN_WIDTH_40:
>         case NL80211_CHAN_WIDTH_80:
>         case NL80211_CHAN_WIDTH_80P80:
>         case NL80211_CHAN_WIDTH_160:
>         case NL80211_CHAN_WIDTH_320:
>                 break;
>
> so what I wanted was
>
>         switch (chandef->width) {
>         case NL80211_CHAN_WIDTH_20_NOHT:
>         case NL80211_CHAN_WIDTH_20:
>         case NL80211_CHAN_WIDTH_40:
>         case NL80211_CHAN_WIDTH_80:
>         case NL80211_CHAN_WIDTH_80P80:
>         case NL80211_CHAN_WIDTH_160:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_320:
> +#endif
>                 break;
>
>
> but what I got was
>
>         switch (chandef->width) {
>         case NL80211_CHAN_WIDTH_20_NOHT:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_20:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_40:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_80:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_80P80:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_160:
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
>         case NL80211_CHAN_WIDTH_320:
> +#endif
>                 break;
>
>
> because it's apparently treating each case kind of separately.
>
> Is there any way to not do that?
>
>
> Similarly, I don't see a way to make something like this work:
>
> @@
> expression E, value;
> @@
> switch (E) {
> +#if CFG80211_VERSION >= KERNEL_VERSION(5,18,0)
> case NL80211_CHAN_WIDTH_320:
> ...
> (
>  break;
> |
>  fallthrough;
> |
>  return;
> |
>  return value;
> )
> +#endif
> }
>
> it actually results in adding only the +#if line, never the +#endif
> line, which is a bit surprising?

Maybe it will work if you duplicate the + line in each branch of the
disjunction.  Actually, it should have complained about that...

julia
