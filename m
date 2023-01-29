Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95703C05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OkM6urVibOAUxSarZMjW0uIvAvm3+Oo2Oxw0XBT6m7o=;
  b=gRxPzUROd7M64JTkeyQhsLrF/KTIcHcok588EZn6oGmDaQ16fmTRT0IJ
   jfeeQyERejTGHIQEUUEt8kLhPGIGv7qM9QNX9/6GMpj7bEZSDv3egHnm8
   Wyk05jUzV72vaS1X1ub3fEiZR4jL/ysG2yvWg3pxx56k3d0LhMTp5nv/Z
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89939579"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 21:10:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A448E743E; Sun, 29 Jan 2023 21:10:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B81CEE743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 20:15:34 +0100 (CET)
IronPort-SDR: 63d6c5d6_YGBnJEYwK5GxBmQrZfH29qLJlPrw+N9f30TCNzl7lEO25yy
 tuau6qXJHRIg52t5eI1udHoh2PyWy2/MBR+DYtg==
X-IPAS-Result: =?us-ascii?q?A0GtAwBAxNZj/0YpCbBagQmBT4ItgV4rAwQLhRSIfogkE?=
 =?us-ascii?q?Z0sgX4PAQMBDUQEAQGFBwKFJh4GBjIHDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEAQECgQYThXWCNykBg38BBSNWEAsYAgImAgJXBoY0BwGoUYEyg?=
 =?us-ascii?q?QGEc5pmgWeBFCyJEYgVQ4INgRWDKj6ERINYgmcEgQiSUogKCoE5dYElDoFGg?=
 =?us-ascii?q?Q8CCQIRSCxANwMZKx1AAws7Mgo/NQsLShAbGhsHgQYqKBUDBAQDAgYTAyICD?=
 =?us-ascii?q?SgxFAQpEw0nJmkJAgMiYgMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDAh9Pc?=
 =?us-ascii?q?i4REwUDCxUqRwQINgUGGzYSAggPEg8GJkMOQjc0EwZcASkLDhEDUIFNBC+BY?=
 =?us-ascii?q?gYpJqBGAUuBJXg6wniDf4FSnxgygUSna5dPqBOBaAE2gVkzGggwgyNOAxkPp?=
 =?us-ascii?q?GI/bwIHAQoBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:5bTgbq3l1m7MQuZqzxTkrQqjBI0kLtp133Aq2lEZdPWaSKOlfq
 eV7ZYmPH7P+VUssR4b9+xoVJPsfZqYz/9ICOoqTNOftWvd0ldARbsKheDfKn/bexEWndQtrZ
 uIHZITNDS9NykesS/j2njeLz87+qjgzEm3v5am80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89937735"
X-MGA-submission: =?us-ascii?q?MDGDSJyGZqZGvyr2BUvf//DvtRIAEToBiFMedy?=
 =?us-ascii?q?CYff1FTdxN9COe7/suc5sSsG++rbDPFRgzz0sQxDdXY1XHHk3intaB3j?=
 =?us-ascii?q?2ZSnYqTe4EysYIuS/fEgSHAULhexV89s/jNaUJue9gsnrhE1JNsRj7L9?=
 =?us-ascii?q?zH1PUnsaUT0qFbEI2XjgxS0A=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 20:15:34 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMD9H-005ziR-SY;
	Sun, 29 Jan 2023 21:15:33 +0200
Message-ID: <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Sun, 29 Jan 2023 21:15:31 +0200
In-Reply-To: <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
	 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 840
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel%40coelho.fi>

On Sun, 2023-01-29 at 19:55 +0200, Luca Coelho wrote:
> On Sun, 2023-01-29 at 18:28 +0100, Julia Lawall wrote:
> > > After mangling a lot with the rules, I can see that this now works,
> > > but
> > > only if I select the vlv_dsi.c file alone, like this:
> > >=20
> > > spatch --sp-file ~/dev_priv_i915.spatch -I
> > > drivers/gpu/drm/i915/display \
> > > =C2=A0--all-includes --in-place ./drivers/gpu/drm/i915/display/vlv_ds=
i.c
> > >=20
> > >=20
> > > If I try to run the rules in all files in that directory, only the
> > > intel_display.c file is affected:
> > >=20
> > > spatch --sp-file ~/dev_priv_i915.spatch -I
> > > drivers/gpu/drm/i915/display  \
> > > =C2=A0--all-includes --in-place ./drivers/gpu/drm/i915/display
> > >=20
> > >=20
> > > Of course, I can work around this by using find and running spatch
> > > individually in every file... But not ideal.
> >=20
> > OK, so perhaps the problem is not actually the rules, but rather the
> > way in which the header files are being collected.
>=20
> Yeah, after banging my head on the rules, I realized that the rules
> themselves were not really the issue.
>=20
>=20
> > What version of Coccinelle do you have?  Someone (Kees?) reported a
> > problem with the collecion of header files at one point fairly
> > recently, and I think I fixed it.  It should be available in the
> > github version of Coccinelle.
>=20
> This is what I have:
>=20
> luca@kveik:~/gfx/linux-drm-tip$ spatch --version
> spatch version 1.1.1 compiled with OCaml version 4.13.1
> Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D/etc=
 --libdir=3D/usr/lib --enable-ocaml --enable-python --with-python=3Dpython3=
 --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>=20
> It's the standard one from Debian testing.
>=20
> I'll try the github version.  Thanks for pointing out!

It seems to be working slightly better, but it's still not finding all
the occurrences that I find by calling spatch with all the files
individually... :( I tried the latest head from github,
87350d742df39d847b15af39865329c2fe23460d.

--
Cheers,
Luca.
