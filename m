Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9B6C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DVDzpCgG0KDXhIhy3/n7tWyuNAalNR6QHjiUGPQ58Js=;
  b=AZVal5CwKDLjY5JfmRplXUynSd8EAjshqcF/3UadnRhgqd4HgkxcoPMg
   LFMrWU7u75DFMitDBazuw7SDc5nPYOwBhqZMm2tjHCFR/Vihgvso2+DoZ
   P3OL8ECvZJzUCFaZhSiALMpDuwAk89raY2rBDOozMI5UJb2aDT60iDqEc
   s=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206889020"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 11:13:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0E9DE0D1D; Thu,  6 Feb 2025 11:13:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1865E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 11:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DVDzpCgG0KDXhIhy3/n7tWyuNAalNR6QHjiUGPQ58Js=;
  b=DkqckZxZnibjgKppvRNgNk+CGkj2KbXM+ieV6Ky9Boai+v++vR9enull
   SBgvcozUoZXfhl3YCOWo1bUitLxVCOkL3gyJMIROxB5tVXlOojiqGVlIb
   O6sQLrp6ohPr1ih5brI0JC5Ck8/FRH98maeTbMxY0tj8Z9HwG6HMhhskS
   0=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108366008"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:13:18 +0100
Date: Thu, 6 Feb 2025 11:13:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@inria.fr>
In-Reply-To: <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Message-ID: <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>  <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>  <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2358
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/66addf31-2af9-457c-24e1-a97367d84d8f%40inria.fr>



On Thu, 6 Feb 2025, Johannes Berg wrote:

> On Thu, 2025-02-06 at 10:59 +0100, Julia Lawall wrote:
> >
> > You can try --profile to find out what it is spending the most time on.
> >
> > --show-trying shows if there is some function in the source code that is
> > particularly problematic.
> >
> > These options might require also using --debug; I don't remember.
>
> Interesting. It says:
>
> > [...]
> > rule starting on line 86 =
> > -----------------------------------------------------------------------
> > dependencies for rule rule starting on line 86 satisfied:
>
> which is indeed the rule that modifies a function in the header file, an
> inline:
>
> @@
> @@
> static inline int
> ieee80211_get_mbssid_beacon_len(...)
> {
> ...
> -if (rnr_elems) {...}
> ...
> }
>
> That seems ... simple enough?

This looks like it could be related to the bug that was corrected and that
leads to the performance problem (ie the old implementation was faster
because it was incorrect).

Is it essential to verify that there is exactly one such if on every
control-flow path?

If You just want to remove all tests on rnr_elems, it will probably be
much faster to do:

 @@
 @@
 static inline int
 ieee80211_get_mbssid_beacon_len(...)
 {
 <...
 -if (rnr_elems) {...}
 ...>
 }

julia

>
> However, the debug log continues:
>
> > [...]
> >      trying  something else
> >      trying function: vif_to_sdata: ieee80211_i.h:1215
> >      trying  something else
> >      trying function: ieee80211_get_mbssid_beacon_len: ieee80211_i.h:1237
>
> which makes sense, that's where the function is, but now it's just
> "stuck". I guess it'll finish eventually, but that seems ... strange?
> That spatch fragment doesn't even seem so bad, least compared to other
> things?
>
> Isolating just that spatch above results in the same. Looks like the
> profile isn't very good when I abort it, so I'll let it run and report
> back what it says later.
>
> johannes
>
