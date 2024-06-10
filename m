Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF14C27C55
	for <cocci@archiver.kernel.org>; Mon, 10 Jun 2024 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=c7XiLPp0eQr/Dx1veU9zu5bKLbPuvbnJlMQkjzGwG7k=;
  b=hm7eB1t4Be5OjYIwP5NNMaoMZF80rndAgC2V5XLmPe1hR1aUACflM11m
   nboyE5xJkzbTqxEAmNE+H0DLgWTD+TID0WJoxBZ9/nM1hYm1Ej4+niLsW
   +JmzSzV8sWzLY7wXKHz/yo8+7zDF6RADZS3/GJq3YBILvhH3e2IzB57yY
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="169824378"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2024 11:36:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 097C7E013D; Mon, 10 Jun 2024 11:36:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D174E0035
	for <cocci@sympa.inria.fr>; Mon, 10 Jun 2024 11:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c7XiLPp0eQr/Dx1veU9zu5bKLbPuvbnJlMQkjzGwG7k=;
  b=RKgIlq5Qvfii9c33U6emGOM+1AnmMuLpLUVMqPobUERvnS1M9h0Ps9EA
   3TtC5dGdkle9BPrNytK4Rwmx6dGs/hbI8+zaGuNWw1igC8/krMlLvyVt9
   Kl9qU5D4pk0Ua+fnLAf9S1RPs0o7FBXKmE71T7FpRlA+ISPIu04mV+rQ7
   8=;
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="169824355"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:36:43 +0200
Date: Mon, 10 Jun 2024 11:36:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@inria.fr>
In-Reply-To: <51e451891bff494df7040c5e5724c68f325411d3.camel@sipsolutions.net>
Message-ID: <c4f5f925-32fa-add2-5551-542e751043aa@inria.fr>
References: <9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>   <f0ad5ab5-d3ea-ac6-3c6e-dd1be07f4e41@inria.fr>  <a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel@sipsolutions.net>  <aebf2712-a3cb-1b53-c173-1a6fcc821f51@inria.fr>
 <51e451891bff494df7040c5e5724c68f325411d3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] strange braces behaviour
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1788
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/c4f5f925-32fa-add2-5551-542e751043aa%40inria.fr>



On Mon, 10 Jun 2024, Johannes Berg wrote:

> On Mon, 2024-06-10 at 09:04 +0200, Julia Lawall wrote:
> > commit 7eded3b97dadb1f0f4ed29d6c56856647c04b656
> > Author: Julia Lawall <Julia.Lawall@inria.fr>
> > Date:   Sun Jun 9 16:07:57 2024 +0200
> >
> >     should use the non fake end node when after is attached to it; that is
> > part of the code
>
> Thanks.
>
> I built master (commit ac9af0e8b7c76341de1999389ce285b72ebaf81b) now.
>
> > > Also, I'd like to check against the similar issue I had with removing a
> > > whole switch statement ("-switch(...) {...}")
> >
> > Maybe it will indeed fix this as well.
>
> So first of all, it doesn't even parse what I wanted:
>
> @@
> @@
>  sta_link_apply_parameters(...,
> -                          struct link_station_parameters *params)
> +                          struct station_parameters *params)
> {
> ...
> -u32 link_id = params->link_id < 0 ? 0 : params->link_id;
> +u32 link_id = 0;
> ...
> -bool changes = ...;
> ...
> -switch (mode) { ... }
> ...
> }
>
> but this isn't supported:
>
> minus: parse error:
>   File "...", line 13, column 17, charpos = 295
>   around = '...',
>   whole content = -switch (mode) { ... }
>
> but I guess that's fair.

Thanks for the report.

It might work to write

{
switch ... // all the detail you put below
&
- S
)

where S ia a statement metavariable.

I haven't tried it though.

julia

>
> But trying to do this:
>
> @@
> @@
>  sta_link_apply_parameters(...,
> -                          struct link_station_parameters *params)
> +                          struct station_parameters *params)
> {
> ...
> -u32 link_id = params->link_id < 0 ? 0 : params->link_id;
> +u32 link_id = 0;
> ...
> -bool changes = ...;
> ...
> -switch (mode) {
> -case STA_LINK_MODE_NEW:
> -...
> -break;
> -case STA_LINK_MODE_LINK_MODIFY:
> -...
> -break;
> -case STA_LINK_MODE_STA_MODIFY:
> -...
> -break;
> -}
> ...
> }
>
>
> There's a "return -EINVAL" inside the _NEW case in the original code:
>
> static int sta_link_apply_parameters(struct ieee80211_local *local,
>                                      struct sta_info *sta,
>                                      enum sta_link_apply_mode mode,
>                                      struct link_station_parameters *params)
> {
>         struct ieee80211_supported_band *sband;
>         struct ieee80211_sub_if_data *sdata = sta->sdata;
>         u32 link_id = params->link_id < 0 ? 0 : params->link_id;
>         struct ieee80211_link_data *link =
>                 sdata_dereference(sdata->link[link_id], sdata);
>         struct link_sta_info *link_sta =
>                 rcu_dereference_protected(sta->link[link_id],
>                                           lockdep_is_held(&local->hw.wiphy->mtx));
>         bool changes = params->link_mac ||
>                        params->txpwr_set ||
>                        params->supported_rates_len ||
>                        params->ht_capa ||
>                        params->vht_capa ||
>                        params->he_capa ||
>                        params->eht_capa ||
>                        params->opmode_notif_used;
>
>         switch (mode) {
>         case STA_LINK_MODE_NEW:
>                 if (!params->link_mac)
>                         return -EINVAL;
>                 break;
>         case STA_LINK_MODE_LINK_MODIFY:
>                 break;
>         case STA_LINK_MODE_STA_MODIFY:
>                 if (params->link_id >= 0)
>                         break;
>                 if (!changes)
>                         return 0;
>                 break;
>         }
> ...
>
>
> which spatch leaves around:
>
> @@ -1814,113 +1814,93 @@ enum sta_link_apply_mode {
>  static int sta_link_apply_parameters(struct ieee80211_local *local,
>  				     struct sta_info *sta,
>  				     enum sta_link_apply_mode mode,
> -				     struct link_station_parameters *params)
> +				     struct station_parameters *params)
>  {
>  	struct ieee80211_supported_band *sband;
>  	struct ieee80211_sub_if_data *sdata = sta->sdata;
> -	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
> +	u32 link_id = 0;
>  	struct ieee80211_link_data *link =
>  		sdata_dereference(sdata->link[link_id], sdata);
>  	struct link_sta_info *link_sta =
>  		rcu_dereference_protected(sta->link[link_id],
>  					  lockdep_is_held(&local->hw.wiphy->mtx));
> -	bool changes = params->link_mac ||
> -		       params->txpwr_set ||
> -		       params->supported_rates_len ||
> -		       params->ht_capa ||
> -		       params->vht_capa ||
> -		       params->he_capa ||
> -		       params->eht_capa ||
> -		       params->opmode_notif_used;
> -
> -	switch (mode) {
> -	case STA_LINK_MODE_NEW:
> -		if (!params->link_mac)
> -			return -EINVAL;
> -		break;
> -	case STA_LINK_MODE_LINK_MODIFY:
> -		break;
> -	case STA_LINK_MODE_STA_MODIFY:
> -		if (params->link_id >= 0)
> -			break;
> -		if (!changes)
> -			return 0;
> -		break;
> -	}
> +	return -EINVAL;
> +	return 0;
> +}
>
> and it also has the closing brace here, so it somehow leaves a closing
> brace too much also in this case, even with the fix.
>
> So perhaps not the same issue?
>
> (I worked around it for now by leave the switch/case/break instead of
> removing, so it's kind of just a dead switch after the change, doesn't
> do anything but structurally still exists)
>
> Thanks,
> johannes
>
