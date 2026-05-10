Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E5CD3427
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xSzWnLCJFfgtZhbx2KpfoJMb4dDfkDWPbjW1dICPiME=;
  b=nS6k5A1aP1UFiTmSfTv80ntDZadQNXZAQbk0tu4kbCnEPXkwp1uOd/pV
   OK26JFm1cvXW2fHZ5vHKZ6udUHhx24+8NgH4vPxATf76sfw/1vsZ1nYpX
   x1D1jbmgoeohYWZqORcJAtNxd5mWj7sJYf35tVQGvyno253FBsVO6iXO0
   Q=;
X-CSE-ConnectionGUID: zrjgyl4nThKj71mJxRpizw==
X-CSE-MsgGUID: zhIRiNbYSouT7mRYv4vC6g==
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
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276015966"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 10:23:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6381780544; Sun, 10 May 2026 10:23:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7E2D3804C0
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 10:23:31 +0200 (CEST)
X-CSE-ConnectionGUID: uHnpzupZSNytNCsgefcyUw==
X-CSE-MsgGUID: 5MyxP3cJQSSGiWvnBlnQ2g==
IronPort-SDR: 6a004083_ft67byqZUTY2FRg88hJOH5oaG0cREgWLK9O/atpwoiUVbE9
 4AB2jp+1m3HilPyuJ91vjnxMw0aVd3jNnw3nbBA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G5AgD+PgBqgAMP49RahRqBZjQEC0mEWI9TgiSEO4c8h?=
 =?us-ascii?q?1WIeYNSAg8BAwENTgECBAEBAQIEhHUKAo0zAh4HAQQ0EwECBAMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHDjuGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAhgOAgJWBgEUAQGCfoIjAQYQA?=
 =?us-ascii?q?QMPJwe0a4EygQGCDAEBBtpmHywiWoFnCYEfLoVygmcBhjGEQCcPgVVEgTyCU?=
 =?us-ascii?q?jE+hEODW4JpgiaBDo8CUngcA1ksAVUTFwsHBYEjQwMqLy0jSwUtHYEjIR0XF?=
 =?us-ascii?q?R9YGwcFEiEqbktkLFwaAwMNITVZdQoBSQWBdAKCHhlfIy8DToEFAgELbT03C?=
 =?us-ascii?q?QsbBD2LPB0PginKOzQHgjiBZ4FkDJ9tBhMvl1IOkwsemGgiqR+BfyOBXDMaJ?=
 =?us-ascii?q?IM2UAMZD5JWwyZFMj0CBwIHDQMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x73mzT3kt/dh9lkY6MF0eCBbhw
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:Pr1q+KowmioLwNE0aRnplFAaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AEwd2YmvNy7phf5aNVPhU8Cdj6Is4UnvF3mrIEXS?=
 =?us-ascii?q?eGHpPY6aaRFGb6Z57xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Auqo4Bg786W09y82+HtWSo8Jhxow1xrW+MBsGs6w?=
 =?us-ascii?q?9gOaFCjJ2ETObtW64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="146151920"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH+J6qQsPIPMf4cQsLv5TVK9RIysr3DBw0U0f?=
 =?us-ascii?q?O+wIVfyIQoTbvAyW/AcwXAtbDBVUoBsm+jPqwY/EG4xZ1kJfnC7PxAo/?=
 =?us-ascii?q?gWEQ2kRNtletoZwr7QZ5e+6KasvINxea9Ua9k9FLHnCi6XWrQFKnXOct?=
 =?us-ascii?q?iWTF2tI6FTEtCd1PrpQDJGfQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 10:23:31 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqXS-1wqDee0CY2-00NLYM; Sun, 10
 May 2026 10:23:30 +0200
Message-ID: <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
Date: Sun, 10 May 2026 10:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xYBJBi0vhhO+Pc5Hl4oaOhmaEz2IHqPYmfb1w5pznoF1E5g5BlN
 ArWLfIkD4Nfm5hm12pekiXn8Bg3srd20wM5X3K3Yb3P4Twj/+9QxzSy0OsFJymRLJxCVpdo
 tDzKln7+Ocz/5RHLR9WPdVLOCvIl/u4P4d0SxOd9URqPYXr/xpUQjJnKha1R5BRKKSkLFRd
 z6NeXMcBgZCzkckOJDrmQ==
UI-OutboundReport: notjunk:1;M01:P0:3MZBcUcApD4=;qaWkKB1A0e1As/J2nOzzTycvgj4
 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
 t6F98Ky8pOA9hILIq/oEEcQA==
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3491
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/QIcXFmgzMNNSZSkEKkW00w>

>> * Would you like to distinguish item concatenation better from
>>   the more advanced application of a merge algorithm?
>=20
> There is no more advanced applicationof the merge algorithm.  There is
> only one merge algorithm.  It does only one thing.

How do you think about to point the circumstances out under which this one
would be applied?


>> * Where is the information presented and explained that such data struc=
tures
>>   would be involved here?
>=20
> What data structures?

Would you become more interested in the clarification of corresponding cas=
e distinctions?


>> I hope that data processing requirements can be clarified accordingly.
>=20
> The requirements are whatever requirements you have.
Do you care for the ordering of generated data anyhow?

Regards,
Markus
