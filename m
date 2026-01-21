Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D75C44536
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ivGYDSKsJ8lbz5Gsk7O0WlNFHLbSi8AeQnnStLnIDXc=;
  b=TFAt/zUhNOfFwfFf/7sXGUoZKF4uPC08gCDrLJUOysQnGSXLzBOMQJh3
   rQVvl1aPbyadpIXgMJA9H4lJ5ZtppKnd1rd+61/UZomglre+i+iuAYfqg
   0GrZZ5WlMlKqOX3oFk07oDS/P7uO3BWH65qgf/w+3Lm0rM6OdmS55oxuj
   U=;
X-CSE-ConnectionGUID: NFWM4oz8RBSHg6j7YEMPQw==
X-CSE-MsgGUID: A7KbGuZVTomYcmvidJK+7w==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259682994"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 16:12:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A0D4381A21; Wed, 21 Jan 2026 16:12:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 259F081A0E
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 16:12:40 +0100 (CET)
X-CSE-ConnectionGUID: Yz9DX66CTFK/OF9+5cL4fQ==
X-CSE-MsgGUID: M80IzBbxTymlloLFpWB4PA==
IronPort-SDR: 6970ecda_rHcs7WaDcIj8EIwxzxjJVjn8xACPE/DOg1LjFWM57DA36m+
 lrsCEwjhcCLU5OazyQ9HTRn4apU+d0IJa74LvHg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GiDABg7HBpeAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VACgj9oJVkzBAtJhFiPU4IkgRODKIc8h1WIeYFWgXwCDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAo0EAh4HAQQ2BA0BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAFDDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7EwgTKBAYIMAQEG2mQfLCJZg?=
 =?us-ascii?q?WcJgR8uAYVtgmUBhiqDQ3onD4FVRIEVJwuCQAcxPoRDg1uCaYImgQ6UCFJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBI0MDKi8tIw88BS0dgSMhHRcTH1gbBwUTI1MGGwYcEgIDA?=
 =?us-ascii?q?QICOlMMgXUCAgSCEHuCAQ+HBYEABS5vGg4iAkFuAgELbT03CQsbBD2Pd0WDM?=
 =?us-ascii?q?oF7xzU0B4I4gWeBZAyfbQYTL5dSDgaTBR6YaCKpH4ICChaBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hPoN1xw5CNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 wQFy/X0INZLXmUU81NvYB92kdaTc3c=
IronPort-Data: A9a23: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
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:ZehgpanZfpMWnx08cwP6CeGtFbrpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A8c9Tqmn8BTtUo+rbO005mUPo0MTXOUzPnVvgfRG?=
 =?us-ascii?q?TNUhKD5q7GBzN84c4nfM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3Nt1HAzv2/mo/3dJz092ovB5HJiaqIH+UGEfu58?=
 =?us-ascii?q?Wh9iBMSh3HxmFsx7reqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="136629147"
X-MGA-submission: =?us-ascii?q?MDGNUZixopzQpMMxplmGME+u9zfM1Fm7y1m3n0?=
 =?us-ascii?q?8XndRdv37LT16732fA87Y4GtPduZ9OhLRyf54jrlzPfxefdPOUID5T28?=
 =?us-ascii?q?VksHa+Xc41KL5PBz33WbYD2OHeiG94Xqq1GXXfVtCU8XVjVvmEKyjsbC?=
 =?us-ascii?q?F3RJHHSxZhHCXTmIuYusYTng=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 16:12:26 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1vfI5d3yoW-008siy; Wed, 21
 Jan 2026 16:12:25 +0100
Message-ID: <9cb005e7-1253-45ce-bb54-cd6de96c3d5a@web.de>
Date: Wed, 21 Jan 2026 16:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Felix Gu <gu_0233@qq.com>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
 <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
 <fb3420c5-a510-4d72-8d6f-6f0d44ad9289@web.de>
 <54744c7e-71b1-ef69-f0f8-bb67dcdffe47@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54744c7e-71b1-ef69-f0f8-bb67dcdffe47@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4t7p7eFO6DcVP6CfoiDHDXgWYrGSx1lnyOVJlZFIHeNlfxHKKf
 Dr9RZQUdNlPpJuUAZMRPWTYdQLkbRTxBbiKSf85uSD+qRpd4QS7fentEcvunrGujWlif3Vu
 Nhlt3ZCdcfv3jY9Mvw9j4zcPuRp8ZphVwP/Vwxd0XBFu9DFu0Q7IFfACl8yN7+8GW45Tz9C
 tviLEjEa7p/33RMGFHt3A==
UI-OutboundReport: notjunk:1;M01:P0:pMdDIcQWLmQ=;/vT0VtZ0i2ADnckE5rkxVAhIBIb
 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
 n7AzofVWxhYRw6nrNHzWHp9dlTia5
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3295
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/e5XjGw3aRGBtd9Tcmgz2gw>

>> It seems that this source code search approach is =E2=80=9Ctoo simple=
=E2=80=9D so far.
>> How would you like to improve it for the avoidance of unwanted false po=
sitives?
>=20
> Lots of research papers have worked on this problem.

Such information sources are evolving.


>                                                       You can find the
> definition and see if it returns NULL.

* Would a corresponding lookup need a cross-reference?

* How do you think about the possibility to mark any functions (or macros)
  in a systematic way that they can fail?

* Will identifier lists become more interesting for knowledge representati=
on accordingly?


>                                         YOu can find other calls to the
> function and see if they test for NULL.

Corresponding statistical analyses can become also interesting occasionall=
y.


>                                          But you may always get false
> positives, because there may be some combinations of arguments that can
> never lead to a failure.

Can we know any programming interfaces better which can only succeed?

Regards,
Markus
