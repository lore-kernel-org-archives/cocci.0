Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71064F30928
	for <cocci@archiver.kernel.org>; Thu,  5 Mar 2026 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AA0wbvFLcjFkEk3WCZMTVKwr/GkznqqOePx9WUSee9Q=;
  b=UD7eDsr1YIAmd0NGFT2B3A9Qq8U9fmkpWZwc/Yt4jlr3fQK/W7ySEwWu
   yRz5nHRm20Rlpee8mp1q6sQAs327Yad+mh4QwIPNIXss3NoWyEjXkXJ8q
   kLePGQibjNlxBpTtXL0CPiJnpChuvD1EdHWt07bkZBed42giIA6UtvmBd
   U=;
X-CSE-ConnectionGUID: xxlmOGhWRZqwSo//SKkmYQ==
X-CSE-MsgGUID: feS5IvkrSfun06djhJlILg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,102,1770591600"; 
   d="scan'208";a="266362805"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2026 11:21:55 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1CE5882BD4; Thu,  5 Mar 2026 11:21:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7039081452
	for <cocci@sympa.inria.fr>; Thu,  5 Mar 2026 11:21:50 +0100 (CET)
X-CSE-ConnectionGUID: vCLVs3UCSTuZHO6hX+BYig==
X-CSE-MsgGUID: DrNMAT9LR1ilY6KT/ZqIXQ==
IronPort-SDR: 69a9593d_1JyyulHS4A0yQ6B56ZZgySovvQEHjIKCY929Gw30gxkuDVb
 y6L2mfzUWQ4EbS9LYxmUvblXFg+JlYweY7ZStvg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GiBwD0V6lpgA4P49RagQmBUAKCP4EHXjQEC0mEWI9Tg?=
 =?us-ascii?q?iSEO48Rik6BfQIPAQMBDT0RAQIEAQEDBIUAAo0gAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw1JARABggCBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERGwsBBAsLDgwCGA4CAlYGF?=
 =?us-ascii?q?QEBgn4BgiIBBhABAw8nBw2qIIEygQGCDAEBBtpkHywiWYFnAwYVgQouhW+CZ?=
 =?us-ascii?q?QGKbicPgVVEgRUngwM+gmEEGIFGg1uCaYImgQ6MA2KGQVJ4HANZLAFVExcLB?=
 =?us-ascii?q?wWBI0MDgQYjSwUtHYEjIR0XFB9YGwcFEiEqgXR4ggEPhmt5Ay54DiICOlxKP?=
 =?us-ascii?q?goBWgWCGAIBC209NwkLGwQ9jnE+gjMCgQ4rghMfkzCzGDQHgjiBZ4FkDIoul?=
 =?us-ascii?q?T8GEy+XUg6TCy6HZZBzjgmbOIFoOoFcMxokT4JnTwMZD44tFoNeM4RgwUZFM?=
 =?us-ascii?q?gI6AgcBCgEBAwmFRgEBggaKUIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:qk73LKgmsDeXZpv8903z2RoWbHBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AC1JShmnyHYxo7YaxeoMtJ2X8N7bXOWP26EnLeHK?=
 =?us-ascii?q?TMlp0ep2yF1+gu4lVksU7zg=3D=3D?=
X-Talos-MUID: 9a23:6WzYyAg8SeShpE1Y20ozqcMpGN1Oxo2SWWQ3yJQCipenCWtCIhattWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,102,1770591600"; 
   d="scan'208";a="140486257"
X-MGA-submission: =?us-ascii?q?MDH59mh/dochlPH47lWBjIsj7yaCx69nlhuHS/?=
 =?us-ascii?q?rC0eW61uM9aqzEP4MNZPRHgnEe9vb9kDgi9fMH66wdiV2PE6JLTIMQYi?=
 =?us-ascii?q?HqW7RK03l+I/YVGx9BLaQllWw8vj3lKCMLnrWiJF4qIGlo2eaRsViIKv?=
 =?us-ascii?q?wgZWAIC28TnELVnIOBmeADHA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 11:21:49 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6b8s-1vbd3d3Gv8-00ulzH; Thu, 05
 Mar 2026 11:21:47 +0100
Message-ID: <5d971202-2bea-42ec-a963-dfd56cf75b1d@web.de>
Date: Thu, 5 Mar 2026 11:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>
References: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BKPyfMpF3yuHQ//T0qFNPjoDL7Z3iWGRzRO+Jbp9+RkmBUkjarr
 4XOLvefYyu+tlrutiR5jRhmBdUuVmuBhYrk/aQz1GbknDKrNaPnITk/WKLfg5IGp0QyqXNO
 JWOhOL32RQeh/Q6t1m9+ap18D7YYNJX/wwpk/BFGIUmcDYKMUsewXGgL/QL10atd6GMZIY6
 HmBOWfXS7CJJtEs4jgaHA==
UI-OutboundReport: notjunk:1;M01:P0:MlmB4uQYPus=;qPdhBj24ozYGcy2YegtS3f00ge/
 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
 CjNTGGHjLMRw99iwk=
Subject: Re: [cocci] [RFC] Coccinelle: Use IS_ERR_OR_NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3323
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/m1QB2s9ugiyK7icWT1wbJw>

> after a colleague of mine recently gave a talk about Coccinelle, I had l=
ook
> myself and created the below semantic patch to find and convert uses of
> IS_ERR() plus NULL check to IS_ERR_OR_NULL() in the Linux kernel.

Thanks for your growing development interests in such an area.


> On 7.0.0-rc2 the patch applies to 79 files and finds most places I ident=
ified
> manually. Fantastic!

Did your code review approach differ from another information representati=
on?
https://elixir.bootlin.com/linux/v7.0-rc1/A/ident/IS_ERR


> How are new semantic patches normally handled:
> - are they first discussed on some mailing list?

Would you like to achieve the integration of another coccicheck script?


> - should I then create the individual patches myself and send them to th=
e
>   subsystem maintainers myself?

The change acceptance can vary between involved maintainers.

Your source code search pattern would represent a refactoring.
Such adjustments fall into the category =E2=80=9Ccode cleanup=E2=80=9D.
They might need to be combined with more convincing changes.
https://lore.kernel.org/all/?q=3DIS_ERR_OR_NULL

Regards,
Markus
