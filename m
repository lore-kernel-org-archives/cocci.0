Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A45C05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GPl6L3ANkjk7c/+H3EX0T5HoiMcAs/6G65twwkDRWN0=;
  b=kuoHTZT0Ic73KhXFIudNTPq4HBnJpw7S4iv0aA8RUzJtkwOvNjtPKJpE
   3kz23qnTSOODDhWVvak62Et94XsMfC6O08UY2bnq3ZpI8/pwBbmKXwdPr
   ZNDP+r2tGBO+rj5Pp/lItGDbw4Ou48SbxQf6DQ+7HGtjhVI4NzuE7q3T8
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89939523"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 21:10:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B95F3E743F; Sun, 29 Jan 2023 21:10:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 61928E743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 21:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GPl6L3ANkjk7c/+H3EX0T5HoiMcAs/6G65twwkDRWN0=;
  b=bpYoxCeeWUpYeDbNAbMrxmVYCEsGZArC03T//ECC+n15CFN2A5Vd9AiX
   tmVnT4QqzMPtjVJrdyNAO1OupBa0JfHVaO3I7P+mwWRl7U+CH4QGLv0ML
   mZ9yw9mQZ1lZT8PFYpcBaPBXwdsu3ilPzM7YW9qTGxpkTooU9wLbOHyBi
   0=;
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46290982"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 21:10:01 +0100
Date: Sun, 29 Jan 2023 21:09:59 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
Message-ID: <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>  <alpine.DEB.2.22.394.2301272148570.4094@hadrien>  <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>  <808cd549-f96d-872d-a4db-30ea33095207@web.de>  <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>  <alpine.DEB.2.22.394.2301281432120.2822@hadrien>  <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>  <alpine.DEB.2.22.394.2301291826510.2852@hadrien>  <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2116676869-1675023000=:2852"
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 838
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301292109320.2852%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2116676869-1675023000=:2852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jan 2023, Luca Coelho wrote:

> On Sun, 2023-01-29 at 19:55 +0200, Luca Coelho wrote:
> > On Sun, 2023-01-29 at 18:28 +0100, Julia Lawall wrote:
> > > > After mangling a lot with the rules, I can see that this now works,
> > > > but
> > > > only if I select the vlv_dsi.c file alone, like this:
> > > >
> > > > spatch --sp-file ~/dev_priv_i915.spatch -I
> > > > drivers/gpu/drm/i915/display \
> > > >  --all-includes --in-place ./drivers/gpu/drm/i915/display/vlv_dsi.c
> > > >
> > > >
> > > > If I try to run the rules in all files in that directory, only the
> > > > intel_display.c file is affected:
> > > >
> > > > spatch --sp-file ~/dev_priv_i915.spatch -I
> > > > drivers/gpu/drm/i915/display  \
> > > >  --all-includes --in-place ./drivers/gpu/drm/i915/display
> > > >
> > > >
> > > > Of course, I can work around this by using find and running spatch
> > > > individually in every file... But not ideal.
> > >
> > > OK, so perhaps the problem is not actually the rules, but rather the
> > > way in which the header files are being collected.
> >
> > Yeah, after banging my head on the rules, I realized that the rules
> > themselves were not really the issue.
> >
> >
> > > What version of Coccinelle do you have?  Someone (Kees?) reported a
> > > problem with the collecion of header files at one point fairly
> > > recently, and I think I fixed it.  It should be available in the
> > > github version of Coccinelle.
> >
> > This is what I have:
> >
> > luca@kveik:~/gfx/linux-drm-tip$ spatch --version
> > spatch version 1.1.1 compiled with OCaml version 4.13.1
> > Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3 --enable-opt
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: PCRE
> >
> > It's the standard one from Debian testing.
> >
> > I'll try the github version.  Thanks for pointing out!
>
> It seems to be working slightly better, but it's still not finding all
> the occurrences that I find by calling spatch with all the files
> individually... :( I tried the latest head from github,
> 87350d742df39d847b15af39865329c2fe23460d.

Could you give a specific case that idn't found?

thanks,
julia


>
> --
> Cheers,
> Luca.
>
--8323329-2116676869-1675023000=:2852--
