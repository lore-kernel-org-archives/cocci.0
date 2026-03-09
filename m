Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1066FFC9EDF
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hByiriUscvsxXXWqKTu3Ek+a2fGYBBquO5DnD6u+qDU=;
  b=di1VXr97uFbQMfKtyP09kS3LieBvK3h14IAmfo2HJI2u/UZsfTYlAI6j
   rhK5U6iQLPPRsNwcUsXukPiS6aENhdeYg5xZBr7fOVGYrOHD/Tu8Nsdgw
   jDKirakZ8QLyr77TbNTRrFUqgkC25oT7Q8jSR3I+DAy1KaTJsF+7hvGtm
   8=;
X-CSE-ConnectionGUID: SRAhWxA6SCOJPnRr/9OAoA==
X-CSE-MsgGUID: wbDSciwQR/GY5cewCIpBwg==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266778554"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 07:07:48 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 971A680611; Mon,  9 Mar 2026 07:07:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4F99F804CA
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 07:07:44 +0100 (CET)
X-CSE-ConnectionGUID: lkla9QxnTmCnlaLvEdaIwg==
X-CSE-MsgGUID: 09MlBl07TAe/NyoiImiUqQ==
IronPort-SDR: 69ae63b0_sIeD4aByphmDMkwmmxjM9tLFHLqD29dhbbikR+7ce1hvT9M
 cxBWGokLNLDCsZMg5xkyCoU6BGeJdkoO16Bqi2Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H3CABRYq5pgAwR49RagQmBUoI/aH00BAtJhFiPU4Ikh?=
 =?us-ascii?q?DuHPIdViHmBVoF8Ag8BAwENTgECBAEBAwSEdwkCjSECHgcBBDYEDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCGA4CAlYGARQBAYJ+g?=
 =?us-ascii?q?iMBBhABAw8nB6pugTKBAYIMAQEGgmnXex8sIlmBZwmBHy+FboJlAYYvhD8nD?=
 =?us-ascii?q?4FVRIE8glIxPoQaKYNbgmmCJoEOh0sGhQyGTlJ4HANZLAFVExcLBwWBI0MDK?=
 =?us-ascii?q?i8tI0sFLR2BIyEdFxQfWBsHBRIhKoFpeIIBD4ZoeQMuXhoOIgI6XEo+CgFaB?=
 =?us-ascii?q?YIlAgELbT03CQsbBD2Ocj6EPYFuxj00B4I4gWeBZAyfbQYTL4NxAZNgDpMLi?=
 =?us-ascii?q?EOQQyKpH4ICCxWBXDMaJE+CZ08DGQ+SVMh2RTI8AgcBCgEBAwmFRgEBjCI0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:LkdolaqJZWdFIU4ChtpTDHUaV5r1eYIsimQD101hICG9Afbo8/
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOgbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMqySMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A8EKGe2trTOyCbDWrItKL+hWv6IshcXnUnU7AJXO?=
 =?us-ascii?q?9ImBtQZmLZFOZ2bxrxp8=3D?=
X-Talos-MUID: 9a23:lhWXYgX9QZu0y5Hq/Ge9oTVIMJ83342jT2YclpQnvsi5LBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266778541"
X-MGA-submission: =?us-ascii?q?MDFiQtPJ7ncFSCq/GOie3N89C4pqNXQaV2fgs5?=
 =?us-ascii?q?j7qfz3iLVD/xGPZ57tybB0aEU4zYI3k3fZzQzElJv7ctpF/KnRVMxQhd?=
 =?us-ascii?q?ACcsU1Wlm+n2IwMOdvqY2ISh+HoNqydm9BqC09yFFQkwbtyhT0UzZOb0?=
 =?us-ascii?q?WxNbItZp+ImgxhbrXNeQWc9w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:07:44 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1wCrnC24Yr-00QfAT; Mon, 09
 Mar 2026 07:07:43 +0100
Message-ID: <c21af64b-dfd1-471d-b9bf-3f1c91b5bdfd@web.de>
Date: Mon, 9 Mar 2026 07:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
 <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
 <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
 <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de>
 <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr>
 <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
 <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDMPduLSc76RdjWlX4UXdyySioePEKKlXbCjxCqgG0JHYlFrHij
 7LAdEdFVySaYHvH7oDgLPpk5nqcNcXQj6tYnyk703QNZC8DRehL4ki/UxIWuP2x3xwov+ro
 N/Deko5K0gFrFwszQ2QpJhzjSVK/byrUYseqFtXJW7ZJR1ouzPMICSJa7V48OtwSZhi0pp3
 5UliTJgj0bQSOz/m8B0+g==
UI-OutboundReport: notjunk:1;M01:P0:RTZh+OdBvc8=;X7jv405R+oVLrOdrKtbMfHNg4/e
 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
 DvjA0oZs=
Subject: Re: [cocci] Too limited support for SmPL statement lists?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3347
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/zsV4sBtWendOTvczMwe2Nw>

> A statement list metavariable only matches the code starting right after=
 a {.
> It can't start in random places. =E2=80=A6

I got the impression then that the supported functionality is so limited f=
or
the metavariable type =E2=80=9Cstatement list=E2=80=9D so far.
It seems that it is unlikely to be usable besides discussed test cases.

Statements are often mixed with variable declarations and definitions.

Regards,
Markus
