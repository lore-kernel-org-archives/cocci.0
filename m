Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B64C25B78
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2024 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e8m27S8HNjxUiFyQDaDEJHf52O937JBC9WTx9Ep0rFQ=;
  b=VGazsJVPYjAEt6GowzHetMHH1Bk3+T3r3X7SJdzL3jyeK50UCHGFOwfu
   Vh6kGlzfmL7sUUCp+AsAEs+2xsW4bVCkzPGf05Vi0D/LOrxXq4At2Lb+a
   PArx7jxu6OedTZKa9WJ+k2CN99amIuhNDaIb6AcBiWGQwq/hrHUqO/BN2
   c=;
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
X-IronPort-AV: E=Sophos;i="6.08,214,1712613600"; 
   d="scan'208";a="169023342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2024 22:28:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62B72E013D; Tue,  4 Jun 2024 22:28:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A12C0E0035
	for <cocci@sympa.inria.fr>; Tue,  4 Jun 2024 22:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e8m27S8HNjxUiFyQDaDEJHf52O937JBC9WTx9Ep0rFQ=;
  b=Gh25UcX1/+TPjKu7IAppaNSgaOBPCllL3A/qUpPAwFlgc4zmcUkZ6PCF
   /SpnkBJuzdLjHRDyeuZjJoO22C7EAv5bVftNI5g6OGvRzMD5q3BlJKZ82
   6ezgk1CzO0cvJiSG1CCnPlw9zRCCCMnEDxne2VZaSClG7u8+N4y6tLsEH
   k=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712613600"; 
   d="scan'208";a="88837414"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:27:59 +0200
Date: Tue, 4 Jun 2024 22:27:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@inria.fr>
In-Reply-To: <9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.22.394.2406042226270.3312@hadrien>
References: <9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] strange braces behaviour
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1777
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/alpine.DEB.2.22.394.2406042226270.3312%40hadrien>



On Tue, 4 Jun 2024, Johannes Berg wrote:

> Hi,
>
> So I've been trying a few similar things, but today we came across this
> one:
>
> Given this function from the current Linux kernel:
>
> void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
> {
>         struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>         struct ieee80211_link_data *link;
>
>         if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>                 return;
>
>         rcu_read_lock();
>
>         link = rcu_dereference(sdata->link[link_id]);
>         if (WARN_ON(!link)) {
>                 rcu_read_unlock();
>                 return;
>         }
>
>         wiphy_work_queue(sdata->local->hw.wiphy,
>                          &link->color_change_finalize_work);
>
>         rcu_read_unlock();
> }
>
>
> Applying the following spatch:
>
> @@
> identifier func =~ "ieee80211_color_change_finish";
> @@
> func(...)
> {
> -...
> }
>
>
> leads to
>
> void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
> {
> }
> }
>
>
> with
> spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15
> and also with
> spatch version 1.1.1 compiled with OCaml version 4.14.1

Thanks for the report.  I will look into it.

>
>
> Trying this spatch:
>
> @@
> identifier func =~ "ieee80211_color_change_finish";
> @@
> func(...)
> -{...}
> +{}
>
>
> works fine with
> spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15
>
> but *fails* with
> spatch version 1.1.1 compiled with OCaml version 4.14.1
>
> saying
>
> EXN: Failure("rule starting on line 1: already tagged token:\nC code
> context\nFile \"./test.c\", line 3, column 0, charpos = 76\n  around =
> '}',\n  whole content = }") in ./test.c
>
> which is almost stranger than the left-over closing brace, especially
> the difference between those two spatch versions I have?
>
>
> Any thoughts?

This is indeed much more mysterious...

julia

> (I have a similar situation with removing a whole switch() statement
> from the code, but I'll leave that for later)
>
> Thanks,
> johannes
>
