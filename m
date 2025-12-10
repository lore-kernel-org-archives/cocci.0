Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD91D3C913
	for <cocci@archiver.kernel.org>; Wed, 10 Dec 2025 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kxlmPvVEzciQ/rUl3P9JzzRrj2emvvR4ihMYehxI5wc=;
  b=FqJ36UzScE8EXfxiD7HRdaf0TX3LI/ENe6nYN5o5k7kw3pE1IZlrvOmc
   WUKcvWzZByEi9aaBTdHuONjYcZ/gaETyfoXtjEhXmUrDVxJIVz1vZuYiN
   7EBB/MvE+8R3lxBgUjH1gsWMduNlq232c1S4WZ2mz14XgdpeaMKhR57an
   c=;
X-CSE-ConnectionGUID: XHkWV7FHRmKWyWQkuSrE+A==
X-CSE-MsgGUID: Wf384bZHQDKB7Na15SGx2g==
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
X-IronPort-AV: E=Sophos;i="6.20,264,1758578400"; 
   d="scan'208";a="253780371"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2025 15:25:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7E0E38129C; Wed, 10 Dec 2025 15:25:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A8721812AC
	for <cocci@sympa.inria.fr>; Wed, 10 Dec 2025 15:25:38 +0100 (CET)
X-CSE-ConnectionGUID: RT1CpF7+RE6Z26T//V3JHA==
X-CSE-MsgGUID: YgN4x2SoRiq8s8KfqEjiuA==
IronPort-SDR: 693982e2_r/VlccVCyaRDuwE7Cw9s5KgDedreX3BXlfziLFDc+44xxk1
 D8f8nrMVfzB9HHC2mINeGCcqC2i0xmi1qdwqGPw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FDAwD7gTlpgA4P49RaHgEBCxIMQIFFC4JAZyVZMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjGgCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsODAImAgJWB?=
 =?us-ascii?q?hUBAYJ+giMBBhABAw8nB7NkgTKBAYIMAQEG2mEfLCJZgWQJgR0uhW6CZQGJb?=
 =?us-ascii?q?HonD4FVRIE8C4J4PoRDg1uCaYImgQ6GDgUGiX4GiUFSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDA4ELI0sFLR2BIyEdFxNgPRdAg0kYBmgPBoERGUkCAgIFAkA6gWYGHAYcE?=
 =?us-ascii?q?gIDAQICgQ0MgXcCAgSCFX6CCg+HRYEIBS6BNgIBC209NwkLGwY9lQ5OghKEF?=
 =?us-ascii?q?5Mksxk0B4I4gWeBZAyfbAYTL5dSDgaTBZkGqUCBaDqBXDMaJIM2TwMZD44hh?=
 =?us-ascii?q?DO+f0I1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 PIz
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:he5M0671v5O+CR5ghwPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AhdZNB2q33m6LWXXaUE7YzA7mUfoZK1bF4iiTGWL?=
 =?us-ascii?q?mOzw3dPrSdwSy2Ioxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUPWa0w0EDZUFGwXNzhJ+Eww6dDUj0quIVFBXqpI?=
 =?us-ascii?q?8utDULnxTNS6wjjWqa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,264,1758578400"; 
   d="scan'208";a="133335033"
X-MGA-submission: =?us-ascii?q?MDFvx+X4eaE/KlKHnhrRom3zlOPZTWYyIwsWKQ?=
 =?us-ascii?q?Eni60S04o9hz/d4phUqgr24limj1I6B2t9bVfG5yo1N05LbOtibjAh2j?=
 =?us-ascii?q?+7RYoM5K7PbbeloXH4e+OHX0Oq58wFuWu3xDKSuu70ISzhU0VxD4QRc2?=
 =?us-ascii?q?X7N+80KSI5ftmAEgJIPZD70w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:25:38 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.204]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1vVOW10quP-00KvJP; Wed, 10
 Dec 2025 15:25:36 +0100
Message-ID: <2bf7a6df-e3d1-4468-8a8e-632258e00587@web.de>
Date: Wed, 10 Dec 2025 15:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mathias Krause <minipli@grsecurity.net>
Cc: cocci@inria.fr
References: <ccea6cbd-8c39-425d-93ca-0685c8154619@grsecurity.net>
 <fb348ba6-0d58-4e94-b86e-b620cc60c2ce@web.de>
 <c1622b03-ada2-4978-92ee-268b0868671c@grsecurity.net>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c1622b03-ada2-4978-92ee-268b0868671c@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oR7KghxaGg5ZHez9Qd90My5bMBhfLk092tlCzc66OFQbZ046kTE
 Dn4jm2wnqOObUCyjiG4MwsJ/gkyM2/sD7XD548DtZGjHp0QFvD72kPpIxWZZ2pd4PC3gBQz
 L7HVbM3Aa87f+tkcK5m9twcqqec32BCDrwbzlkkNVd6itDHRJhj33FxGKGTAAFN9nJmytDo
 Fkkdy4r6Y+kGu4Ax+t4ww==
UI-OutboundReport: notjunk:1;M01:P0:KKxy45sEpk8=;NjcLWc+UTwNyqVQCbeOensrROmf
 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
 WJ3BbRIg=
Subject: Re: [cocci] Matching function pointer casts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3260
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/DOZURkjRrISOiD4gUbFXbA>

> I meanwhile found a workaround but it's ugly -- not because cocci fails
> to match on function pointer casts (I implemented that by making use of
> its python script capabilities) but because of actual source code
> guards, the function pointer assignments are wrapped in.
>=20
> It's an '#if ... #else ... #endif' block that, apparently, doesn't get
> processed correctly. The preprocessor condition is non-trivial as in not
> simply being "0" or "1" but still easy enough to handle (one level of in=
direction).

Thanks for such background information.

There are some development challenges remaining for better support
of conditional =E2=80=9Ccompilation=E2=80=9D (or analysis) also by the mea=
ns of the Coccinelle software.

Regards,
Markus
