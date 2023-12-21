Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E81C35274
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yHw7F4a8CCoFwFAlYX0y0v9iSG51vrBqRmuc2WP4CdY=;
  b=OUKeY0yQnORx+vBAbGRLmPO+sAWk1PvPVx3woiSE+bDFwippIWfwIVcK
   +yxEr2v9ZsDdL6v1yqenb2WIt1CD8FG9nH7x/GAiVnlFw2ergW1t5USWz
   RuV7OOg9H6bGiqk5p4gF59r5TVFF8ajEx/dsR446AP66LunvTHf514zhm
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143540304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 13:57:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8513CE0CCE; Thu, 21 Dec 2023 13:57:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DCFCAE0AF1
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 13:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yHw7F4a8CCoFwFAlYX0y0v9iSG51vrBqRmuc2WP4CdY=;
  b=UKuHq262MQr0yvSfa/Q8FOSpnr9b8H2w8530fPCOVYnl3tbd8s1o6YsX
   psnrJU0T4hTPemKZV70Abddb7h2+Kjtmbjq2hoiCC/3yIHPYEAuNW2fsA
   KOs0OPt83okSMQuCGILSPDDbBszCvu0CxBKdxeHtRJNRtX06mDMUS8K12
   g=;
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143540288"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 13:57:28 +0100
Date: Thu, 21 Dec 2023 13:57:28 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    cocci@inria.fr
In-Reply-To: <fe67dbb7-7dc9-40a4-a136-19a659e35fd6@web.de>
Message-ID: <6253ddc-2c97-aaa2-63a2-4181f4703460@inria.fr>
References: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com> <0ecaecf0-6a50-43b1-8458-59d41bc5fd37@web.de> <80d307c-e3f7-8f84-78d4-b19113f441f7@linux.intel.com> <fe67dbb7-7dc9-40a4-a136-19a659e35fd6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Transforming data structure accesses with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1357
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/6253ddc-2c97-aaa2-63a2-4181f4703460%40inria.fr>



On Thu, 21 Dec 2023, Markus Elfring wrote:

> > In general, I don't want to spend my time on perfecting a .cocci script as
> > further improvements tend to be needed around the areas highlighted
> > anyway. It's enough for me that the most mechanical transformation cases
> > are covered by spatch and I can handle the troublemakers myself while
> > inspecting the results.

Seems fine to me :)

julia
