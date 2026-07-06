Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EBFC43458
	for <cocci@archiver.kernel.org>; Mon,  6 Jul 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tmJiATXPCqJylA6R9x6Fe9+39b2n1CBLFdjUiDsXmwU=;
  b=ImZP6sCL6l9HiDoss9Y/1NjWfMEvl7sSKRHO6CcFO0RDb0vChEQirfE8
   /Mxz5tQR2tdqzvtzT5pB2DVn0/yS/FQFGbkDk9g89Kuij6QxKLKrDQhC4
   2ygkdJotEXw3G9mSywba+ZClJA4XwpAQeQQmweQAgb5saOwKy+N1oWf6j
   I=;
X-CSE-ConnectionGUID: 8t3OQLcSQM2AwALkA6KXjA==
X-CSE-MsgGUID: x3Ccx1oXQM+5qmbWpB9OWg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,151,1779141600"; 
   d="asc'?scan'208";a="285124291"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jul 2026 20:35:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7FB95824FC; Mon,  6 Jul 2026 20:35:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1B6868243D
	for <cocci@sympa.inria.fr>; Mon,  6 Jul 2026 20:35:15 +0200 (CEST)
X-CSE-ConnectionGUID: OFNWq6rGQ9muw2XyiYDvkg==
X-CSE-MsgGUID: iT0OtOeFSxizxglUFoTXGQ==
IronPort-SDR: 6a4bf562_VuQZxRQ7PpKttXWgmuv+vYGA4GNxlOBG08HT8uLhJkj4/mR
 iOkTrvud+wQ1sKBgxTUJd6NE+rf9sBpVx2TpWng==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GlAgCO9EtqgTbdVdFaHgEBCxIMhFGBaTMEVIRYkXegF?=
 =?us-ascii?q?wIIBwEDAQgDAQFPAgQBAQECBIR/Ao1OAh4HAQQ0EwECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDX4BAQECARIRHQEBNwEECwshIQICDwEjAQUBHAYTIoJhgiIBB?=
 =?us-ascii?q?iMnA61zgQJCiz2BMoEBggwBAQbcdIEbCQkJAQsBGIEfgViGdg0BgV2IG3onG?=
 =?us-ascii?q?4INhEA+iB6CaoImgQyRL1KBFANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XF?=
 =?us-ascii?q?h5YGwcFEiAqQUQBIwMnWT84C0MFgVkCgghOIx8DOX+BMHVKeS2BAgECEB4Kb?=
 =?us-ascii?q?EIkgUgDC209NxQbBItsECENghIXD7gRlReEJ6Iog3EBk2GTGZkIqRcCCgcHE?=
 =?us-ascii?q?SSBWyOBXHCDN1ADGQ+OIYQCzjxCNT0CBwIHAgwDC4I5gy4TCwGMFoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wv+oKpcT5N6edckSfRDWiwnm2G6
IronPort-HdrOrdr: A9a23:73kan6OwUz+0O8BcThujsMiBIKoaSvp037Dk7TEVdfU1SL3lqy
 nKpp4mPHDP+U0ssR0b6LO90ey7MBThHP1OkPQs1NWZLXPbUbuTXedfBOLZqlWKexEWtNQtrJ
 uIG5IeNDSaNykfsS+V2njbLz9t+qj+zImYwcnbi1liJDsEV0ii1WtE48Sgf3GejTMpOaYE
X-Talos-CUID: 9a23:G0hpoW6GWKGxw05RXNss02AyJdl7aFLknXLNPBWIGGdYZKOWRgrF
X-Talos-MUID: 9a23:DmBWywSRu9OOVPBFRXTtuGlFKOBlzZ++CVIdnpE7lc64BQNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,151,1779141600"; 
   d="asc'?scan'208";a="285124279"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHFHxU4BBSZEECv5iZoi+TAC+RwhAV3IN7vNQ?=
 =?us-ascii?q?3ryQgE0ZRcRTfsPHuWDIttc11w/3QNslSUBG6XCB/ZRFI2tC0O6WTnr5?=
 =?us-ascii?q?nXI/7siQISMTIrjDs9WIprNl56b2fr/gqYHyDyjxpAxonE7o1n/I8GDQ?=
 =?us-ascii?q?jFM8BkGlgE3DLNrBzklnofmw=3D=3D?=
Received: from mail-wr1-f54.google.com ([209.85.221.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:35:14 +0200
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2067033f8f.1
        for <cocci@inria.fr>; Mon, 06 Jul 2026 11:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362914; x=1783967714;
        h=mime-version:message-id:date:user-agent:references:organization
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmJiATXPCqJylA6R9x6Fe9+39b2n1CBLFdjUiDsXmwU=;
        b=FK6bZkl0O6bLduoO0Ss4aJkD5F9OO3heVPeZ8AcvrVk+stiH0i7+jLXn9dAxi60NEo
         mGo9TpLHRWP7HFGYZCLnuawVLNVO1720P3/wvKgss3aCmqY5N58UHD82Y2Kp3YQ68y7f
         g2xS/oFsa/6McPUbgNOqBOI8N4rSKEi/HLPDum8RMcSnc0z6jzOQzh7h8gYGhHpsvRrw
         7DAPFT+cHtJNqRQcXhV00ZvOVc2zlYRvDBCaIkxVlz3Aw+nQilB20uIy1BvqHgBrzVO1
         NfeJ53J0lmISMFGG2kdU4+Q8PueeY6ryNCALtzj32vAac1APWA/U4OInN5TIWU4DJRRF
         WKgQ==
X-Gm-Message-State: AOJu0YwUEMERfjZzzPYzycZgWNe6ybSntmIWKKhXiGEXpIC9O8wf5cG0
	fgByUQgWq8pqOSRB238NxFH7ovHi9LLy7CH0DpsDELHQwntS9Wtg2eZidQCYPgTmYix+H4jXrd8
	z6sS7w2L8Uyu6SVA=
X-Gm-Gg: AfdE7clPFzRFp2D3XSNHpbh0jnKvOCL4z6X+jKuG7qP0977aJ7Vp/eNnCeY9Eof95K0
	2XG6BG3u9L66AfYc3mqdEUF+SKGLuuSzQQCVENwlpqeWgmEK7wZAxDef0zkMYtQaP1V80666gzc
	S3mUZHYJk4sXIGdvOXJmnHhyCR+C6/b9VpQRlfC9HJzgjmdRyOocOAdQmu9+DR7+JvpBZ7lRVH1
	HBtsFGmjlc5N7Li9lH+9HfzfLJarC6PDpCb5uXqV+xz7pKmtwEKr0+TZmfxxjyokxEtcGU1ygtu
	jqKuoNPRWfk5P5G9ohEb+8AvJAo9mCUmEiw5g9++qZ6yTGZVl/RdNTcA9wGUbsqxHlR60KMYA/Q
	Kr0QSwF4s/SxDKjkiLehmKxb/K2yCU2qAbyOp1x2AnaM8liDncFQPtHinevkkYYEOu1X3r/hZ6a
	h+5W89c44=
X-Received: by 2002:a5d:5407:0:b0:473:ba02:8cbc with SMTP id ffacd0b85a97d-47de663c413mr1437469f8f.0.1783362914286;
        Mon, 06 Jul 2026 11:35:14 -0700 (PDT)
Received: from bstg ([146.70.193.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm28361788f8f.26.2026.07.06.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:35:13 -0700 (PDT)
From: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
In-Reply-To: <90E16A8E-6BEA-4492-B0A6-437D873A024B@inria.fr>
Organization: BayLibre
References: <86h5mc6m8v.fsf@baylibre.com>
	<90E16A8E-6BEA-4492-B0A6-437D873A024B@inria.fr>
User-Agent: mu4e 1.14.2; emacs 32.0.50
Date: Mon, 06 Jul 2026 20:35:11 +0200
Message-ID: <868q7o6k68.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [cocci] GNU-style function calls
Reply-To: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
X-Loop: cocci@inria.fr
X-Sequence: 3595
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/n0Zl8RtMv00JU0y897EvUw>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Julia!

Julia Lawall <Julia.Lawall@inria.fr> writes:

> There is a =E2=80=94simple-spacing argument where it should preserve the =
spacing you put in the semantic patch.

Ah, yes, indeed, that works perfectly!

Thank you!  Cocci is awesome :-)

Have a lovely evening.
=2D-=20
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEKBAEWCgCyFiEE/uKz0RP8AKMWLWBhUsKUMB6ixJMFAmpL9V8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRGRUUyQjNEMTEzRkMwMEEzMTYyRDYw
NjE1MkMyOTQzMDFFQTJDNDkzGBxhYXJzZW5vdmljQGJheWxpYnJlLmNvbQAKCRBS
wpQwHqLEkwxDAQDoioh4oJKTvMVaD0GgClTi+KCmcZUk6SduoMapvju87gEAtifv
UbSd5PQ4Qrx0ALOPC+iKESYni+whkJEVaCtaaAc=
=DVHq
-----END PGP SIGNATURE-----
--=-=-=--
