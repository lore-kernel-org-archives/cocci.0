Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0F2C0219B
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oGR1BErvo56a5sW0P2J7iiFfdTwP9YHw0KpExF6xOBY=;
  b=tYX2XiY6bUzIGys15qrHZD4N94zTQp28mcAmmRaLjQEDw2B/b1gawEDq
   N97ASbPNl8EslgEbotBz23G5j649SmklM3eDGtjPiuOmnhCJsHicjIW5i
   3+JEE7VrPHkMozhIN9K7DV7AqoclLSyXYNsUm/TUPF75zA2j5bUB+N54J
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
   d="scan'208";a="206884603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 10:59:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8385AE0D1D; Thu,  6 Feb 2025 10:59:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 94D03E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 10:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oGR1BErvo56a5sW0P2J7iiFfdTwP9YHw0KpExF6xOBY=;
  b=DQXapnkHokBa056s6m/8D/EXYLbpM9BFyo/d20G/ZaLRl7OZZTn1ihQx
   pLiDcQ+GaiM1/pRA/ajBcLcX0IMiAR1WVTSSNqNWQVmmWUaub79Q/3hFH
   XU7irpsOT4jRoGQZevUUAxCpr3ZQlThCO/jmR2zikLSinwhT614/SR7d8
   I=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108363219"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:59:20 +0100
Date: Thu, 6 Feb 2025 10:59:20 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@inria.fr>
In-Reply-To: <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
Message-ID: <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net> <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1399391631-1738835960=:4500"
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2354
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/ca7c1a14-522a-9c2c-4f85-2fda289b83e8%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1399391631-1738835960=:4500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 6 Feb 2025, Johannes Berg wrote:

> On Thu, 2025-02-06 at 10:31 +0100, Johannes Berg wrote:
> >
> > There's a second issue: we have this
> > spatch: https://p.sipsolutions.net/765e55f2b951326c.txt
> > It's not pretty, but it's intended to (again for backport reasons)
> > manipulate some code in net/mac80211/cfg.c (see also [1]). We run all
> > our spatches with --include-headers, and this one when running on
> > net/mac80211/ieee80211_i.h, goes into some kind of infinite loop? I.e.
> > just
> >
> > spatch --include-headers --in-place --sp-file /tmp/765e55f2b951326c.txt net/mac80211/ieee80211_i.h
> >
> > never finishes?
>
> I stand corrected, I wasn't patient enough. On a machine _much_ faster
> than my laptop (server CPU), it finished (with warnings about
> inconsistent modifications) after a bit more than 10 minutes.

You can try --profile to find out what it is spending the most time on.

--show-trying shows if there is some function in the source code that is
particularly problematic.

These options might require also using --debug; I don't remember.

julia
--8323329-1399391631-1738835960=:4500--
