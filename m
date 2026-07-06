Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6630C43458
	for <cocci@archiver.kernel.org>; Mon,  6 Jul 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xGiuG9BD5G9oM/Gc4UyzXZEm5zrUyQEd7cPEZXdrNk4=;
  b=HLaNEYI481fEkNfW06ykBHrubewskbhTHba81yet29YY0EyvXCoFX3eU
   0N32/5Pf6GLdIVdQDshfJFEF+VICAY1c4/KBNRkf/EDWCFQmKoiyp0rQ1
   Y/1Hhcm0FGMTcT1P23qvsDGYzjcbRg9bk08u5uyAfDYNhhaYQEUAH0rLq
   A=;
X-CSE-ConnectionGUID: JyiPoVoUR6ai0Pvfw+VWnw==
X-CSE-MsgGUID: lVsj12/lQSyX4vPdTgXF2w==
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
   d="asc'?scan'208";a="285120729"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jul 2026 19:50:32 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B7A8F813BC; Mon,  6 Jul 2026 19:50:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 555F280E40
	for <cocci@sympa.inria.fr>; Mon,  6 Jul 2026 19:50:28 +0200 (CEST)
X-CSE-ConnectionGUID: eUz1uaazS2uviYuX1zLmWQ==
X-CSE-MsgGUID: 6MkqvE1AQvi9mebFn7ce4A==
IronPort-SDR: 6a4beae3_cxgLGIKuOZL2t3gRAOwAd3f1g4RVyuIQbdrc6ktcM8tX4US
 MjRGe4CWAI25ErY/Qa9FRJvPH3hv9UtPjR9cO0g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GFB2b46UtqgTKAVdFahRqBCl8zBFSEWINPjASdaYRSA?=
 =?us-ascii?q?ggHAQMBCAQBPRICBAEBAQIBA4V4AYxWAh4HAQQ0EwECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NgjArgSgEM0EBAQEBA?=
 =?us-ascii?q?QEBAQECAQEBAQEBAQEBAQEBAQEDAQEBAwEBAQMBAQEBBQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg2BFhEdAQE4OyECEQEjAQUBV4JhgiIBBkoDEa10gQJCiz2BMoEBggwBA?=
 =?us-ascii?q?QaBCD4GgR3aC4EbCQkJAQoCGIEfgViBOIU+DQGBXYgbeicbgg2KDoMOgmqCJ?=
 =?us-ascii?q?oEMgXiPKIFmA1ksAVUTFwsHBYFmA4EGbjIdgSM+FzRYGwcFgR1EgSeBAoR5I?=
 =?us-ascii?q?x8DOX+BMHVKeS2BAxIeCoFSgSoDC209NxQbBItfECENgXkZFw+DS4FxgTKSa?=
 =?us-ascii?q?7NPhCeMIZYHhVuReJMZmQijLgFDhSUCCgcHESSBWyOBXHCDNwlHAxkPji0Wg?=
 =?us-ascii?q?y4yzjxCNT0CBwIHAgwDC4I5gy4TCwGMFoFLAQE?=
IronPort-PHdr: A9a23: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
 EI5bHHLQLVei7Ymfmdu2le0hA==
IronPort-Data: A9a23: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
 x9KBHusT5aqWPcIaNWwWjn3ZrBKPC3JKUT5bw==
IronPort-HdrOrdr: A9a23:X/NgzqnPS94H7y6coOe/QCCkJR3pDfIE3DAbv31ZSRFFG/Fw9v
 re58jzsCWftN9/YgBHpTntAtjifZq+z+8M3WByB8baYOA3ghrNEGgK1+KLqF3d8kXFl9K1vp
 0QFpSWZueAb2SSwfyKhzWQIpIPxJ2o/smT6ts2DE0AceipUcxdBs5CZDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3A8IlSM2trm3Ib0G+K0cLhSP3I6IsoT2+E0X7ZMXT?=
 =?us-ascii?q?iFHhoeaClEE20/Zxdxp8=3D?=
X-Talos-MUID: 9a23:SX1ZQwVje554YHrq/GHJhyh8GZ5B2rqvWUUAm7sA5MKJaQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,151,1779141600"; 
   d="asc'?scan'208";a="285120718"
X-IronPort-Outbreak-Status: No, level 2, Malware - Malware
X-MGA-submission: =?us-ascii?q?MDEIWSMYaAXmbAL6IMpbgdpoyszzX0R/TquUDq?=
 =?us-ascii?q?OOsT+zLt5Y5e5KsxhrgF2pcZT/SeXzzYdK5386ljp5j8bOQq9wxhyhfH?=
 =?us-ascii?q?1cH01qRNzo/kCHmTt9G/XmT5SdUl+plm7YNNHqOa6SzWwSmp7rIarqmD?=
 =?us-ascii?q?p3f12Ao/Gk9NOnMvqCudNtYw=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 19:50:28 +0200
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c19bad03so31087425e9.2
        for <cocci@inria.fr>; Mon, 06 Jul 2026 10:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360227; x=1783965027;
        h=mime-version:message-id:date:user-agent:organization:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGiuG9BD5G9oM/Gc4UyzXZEm5zrUyQEd7cPEZXdrNk4=;
        b=TB/szQ2XanOpeT32qpYLXQvND8hYAE1rnJxXYQZuQTDsFL08/7tizIWhzeHGhtK5Ap
         gsu9yx9LFIiRwWv1yo8dT+ESAV2pqKQSJ5YXUIFLW9ATB+ygiaM6SmzPrCowYlFYBacf
         tsfL8PI7VQ6Y1hnJvq8/k3o2FOsH10HIThOdQH9VS1yE4pisuleLA5JlNu9DJK+okgRE
         CH/eDOwdZddGM/s9BudSkOGxaZ4S+DKwJOuJlUOGJOlxxlLGq9E4Z8p8Yn7yucXhSqz9
         +9n81UQICMgBdLm1Ua0sHD7tOAICaMmrda/RbWl0rUvO8mJ196sJj8Ft2fLOlK6HLD3t
         tU6g==
X-Gm-Message-State: AOJu0YxK1fXIIRZ2h20WKy+3ExLduffGQR2+N0UfdDxBG0WF35ONCX7k
	GKxwUHndXiutMpXHnL7OrUt+FjHPa7azeDPot2uXAAE1OilaWMHTbOXB1dOPrNEV8BgXoE0qR7i
	bAifldlX49fqqvwo=
X-Gm-Gg: AfdE7cka9oLExYdN2JO1qJaUSuTUmdzKQop3kw/tEicSi79j7qKprhN69npwGUHbtOs
	jS+zYns3p0NtxpXOpnTDSs6E/uKaZ9+4Hy9/04lDuNaGopSID0gcIgrYb40BKvHD9sOgzQS4GiS
	kYTnaKNZfqXFLFwC4LzoKaSUSPNVdVvlsEHf/MB6RflEMSoD5TdSGTexUL0yUqytC7VUQmWrZo8
	2QSgy9ICcbwFeemn868j8q2xpNE0fqOg9TTqHVJutRySVCHgmCjGpMkw9daaKtAf8Jjy2atTQ0f
	N/RXWSiOrZiHk8nKMJsyMstdwZMKKnc/uuQF3dXk4VJpp+n1zIeK3ilGodm8mi/+LMA19lah4rX
	WhJc0gszZ6YEfhmk7I5iWxgMfMX1J4D0ERayX6P8VuaGdVUj+THUYkHt1peFt28VpWkHtoCrVEH
	F4Z1TwXUI=
X-Received: by 2002:a05:600c:8b27:b0:492:3d05:5639 with SMTP id 5b1f17b1804b1-493df083892mr17923815e9.36.1783360227266;
        Mon, 06 Jul 2026 10:50:27 -0700 (PDT)
Received: from bstg ([146.70.193.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0072acfsm1274415e9.4.2026.07.06.10.50.25
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:50:26 -0700 (PDT)
From: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
To: cocci@inria.fr
Organization: BayLibre
User-Agent: mu4e 1.14.2; emacs 32.0.50
Date: Mon, 06 Jul 2026 19:50:24 +0200
Message-ID: <86h5mc6m8v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: [cocci] GNU-style function calls
Reply-To: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
X-Loop: cocci@inria.fr
X-Sequence: 3593
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/-T2XaEu0DtyX_Mr42cyTAg>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I work on GCC, meaning we use GNU-style function calls, where the
call operator is preceded by a whitespace, like so:

  foo (a, b);

I've had decent luck with applying Cocci to the codebase, but if Cocci
rewrites a call, it removes the whitespace preceding the call operator:

  /tmp$ cat test.cc
  void
  thing ()
  {
    foo (a, b);
  }
  /tmp$ cat test.cocci
  @@
  expression x, y;
  @@

  - foo (x, y);
  + foo (y, x);
  /tmp$ spatch --sp-file test.cocci --c++=3D14 test.cc
  init_defs_builtins: /usr/lib64/coccinelle/standard.h
  HANDLING: test.cc
  diff =3D=20
  --- test.cc
  +++ /tmp/cocci-output-157607-636042-test.cc
  @@ -1,5 +1,5 @@
   void
   thing ()
   {
  -  foo (a, b);
  +  foo(b, a);
   }
  /tmp$=20

This isn't too much of a problem; I go back and modify the function
calls manually, but it would be nice if Cocci handled it.

Is it possible to keep the spaces in line with the code style w/ Cocci?

Thanks in advance!  Have a lovely day.
=2D-=20
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEKBAEWCgCyFiEE/uKz0RP8AKMWLWBhUsKUMB6ixJMFAmpL6uAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRGRUUyQjNEMTEzRkMwMEEzMTYyRDYw
NjE1MkMyOTQzMDFFQTJDNDkzGBxhYXJzZW5vdmljQGJheWxpYnJlLmNvbQAKCRBS
wpQwHqLEk6mcAP4xDqx5jutyx6mVie0MppEFU887sRa0wgKGCZy478Ey/AD/T7bS
oKZzh+3MgpvIIWroipMDnBXo3lVFejLG/HBcKAk=
=gBds
-----END PGP SIGNATURE-----
--=-=-=--
