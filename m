Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F030D44172
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eIq/sPoDsIc11xxU5e3fiUEB3mctegmW6wUArYyZHSA=;
  b=eHYdNpBjjLPmW54acCCiUPhEj/CyVOfSZqgDUxIFkBSWhKcQpH7zk5Ct
   bknFR5lwhHXw1RuYVPH8F2VP39iQ6h4Ft3iKzsume0LtZWbgJewJlpsq9
   LOO/VeI9enHchl0hBgkrU6IFX0p7riiBlTVuAK09+fPltLnRmcpkmfAvC
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194711352"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 16:20:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 658F2E0D1E; Tue, 19 Nov 2024 16:20:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F055E00B7
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 16:20:12 +0100 (CET)
IronPort-SDR: 673cacac_xkMQGvAikN0bUCJ30U9EXCCDgpPBH7WI61vIh8NQ6821Pao
 aNVUQAGUngwRwME39SVWVAwFjeryIfBwoM/QGbA==
X-IPAS-Result: =?us-ascii?q?A0GZAADmqzxngAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYnUzBAtIhFaPTYF0MIQ7hzuHVoh1gWqBag8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCDIJ0AopQAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REnBAsLGgImAgJWBgEUAQGCfYIwAQMOIweyCoEygQGCDAEBBtpbHywiV4FkC?=
 =?us-ascii?q?YEaLgGFaYJiAYVZS4Q8Jw+BVUSBPIMDPoQFPoNbgmmCRYUPJYgXaJodUnscA?=
 =?us-ascii?q?1kyAVUTFwsHBYEpISwDgXlOf4E2gVEBQoJOSoMugV4FN0mCSmlLNwINAjaCJ?=
 =?us-ascii?q?CRZgk+BJQQFg2mBC4NhhF6EIx1AAgELbT01CQsbBj2gXYMvFYFOs0uUWzQHg?=
 =?us-ascii?q?jiBZYFjDJ9ZBhMvl0AOBpJ6mHcio1CFNTWBSCSBXDMaJIM2TwMZD44hDBaEC?=
 =?us-ascii?q?8VzQjU7AgcBCgEBAwkBgVWDcAEBiXeBSwEB?=
IronPort-PHdr: A9a23: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
 jnnkaXuNHFd/tiS8cZOX6A8x+qYPXBnPRe7QVbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lIRgrKOCtxXZFcBcTsqjsMiBIKoaSvp037BL7TESdfUxSKalfq
 +V8MjzqiWE7Ar5NEtPpTn4AtjkfZq+z+8X3WByB9qftWDd0QOVxedZjLcKqweKJ8SUzIFgPM
 lbE5RDNA==
X-Talos-CUID: =?us-ascii?q?9a23=3AcYvmHGpk2BGZ9uNXr8ZZIx3mUdooNSHyzmjtGE6?=
 =?us-ascii?q?lOzZ1Z72XalSo85oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AiiJaQA/UlGfCyMJBRAaKnO2Qf8FVx57zBmsLrck?=
 =?us-ascii?q?HueOibAZZYA2jpjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194711308"
X-MGA-submission: =?us-ascii?q?MDEPbaPDLZQWinzYBllXP1LNmUWzYkF3gqie/N?=
 =?us-ascii?q?yTdFxl2JopsN1YYvV2qzBr5kjd785h4jKAI2dDor/dmDlPRaD/RIgt3b?=
 =?us-ascii?q?5SSXviYMzDrp4C52IlMCTCutF7nAcQRe5FSyI2FrBHBojI/Awt7cLV3a?=
 =?us-ascii?q?cKg6lQQkS4osJOP2pN1+YM2Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 16:20:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732029611; x=1732634411; i=markus.elfring@web.de;
	bh=eIq/sPoDsIc11xxU5e3fiUEB3mctegmW6wUArYyZHSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hz6hwNV29+v1SCoC8i+68wF964646VE9O3TC5i44M0XT6bJtOH7W/DQUUar+2RJG
	 IpD0XdGU6NPeKLoa1gFuMkM530UxwKYedirPEnqe9cfQAFXP1teE7kFiN6PX9smth
	 aGUaP/ii/KaPefpdxRiA9pkjeSS9CN5RvOk9NaoKc7BTHRAd1X9waw9GhJMoK664S
	 lHgURB9yMT/Yi9kVZ2vZJ/TfuDF21iW1Uhf84IWk0z3hCnOes/Ex7lDmhD/u48fPG
	 PDd0EPyBLY9TTIEpQjJrb7PyZp3pbpNyxjiCykJcaqNOfCDydVTXTXXPmwPx5PAfL
	 IGm4Sdvd5LNo350g3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1tHs0x1N8i-00Xj7Y; Tue, 19
 Nov 2024 16:20:11 +0100
Message-ID: <2421b61c-a48e-415b-833d-3493d9b7924f@web.de>
Date: Tue, 19 Nov 2024 16:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
 <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rJrANy6VhKBcbwc2xvbY89DDsKeheBi9ch7IPfyhybrw7J55wK7
 vngPHcvBH9QNuEbj1RfX4pj05F6rbR0h6y6ILEIafYovRHrrIHHoZ/PnnKVe7Yv2wLKaQDX
 jCOdHHtEs+LBhPtRtJ2/FxR4j+GcF8HVaBfWfqnczjEiVg/KDIvzEn2+1MmZrpSCyJcpsfF
 e2Lbt/ItfxtNf0/J9AY0Q==
UI-OutboundReport: notjunk:1;M01:P0:cWie4M0CR+4=;JM72uGMepTJr/r3L3cqSWLOUy8K
 86LrryF4uzXL0yLw/x02Dsrd0w1/OYtR/c3t4NC4ZiZpDPcBBtOUzvcRam3X/qIeRIcD2HtX6
 i4EdFe9JxqPN2+oXKLYI5PmFOyBWxlBDW1s5L7/Pea6Co0g1eYmwpO+Z/1rKOleK51UiyxaPf
 fy8JYGwNxCDz/KfFA9yvkcnIB4zD4+MgJZI3oQvmclqM/MMRIVr+77ZTZHNH7EaGcQUli3u0a
 ZhBOq7FmIXjT0beV+x3+zxQXCp6Pvf5loozZwW1HVYMZQoRfIfKAcNiccTP9MPexUKdok97iD
 SiKgDDfx6tNynQa82w5cQLsOzSF8p4lxCFxbaxK0V62PwEFtp7NCO+DI/CUs5u0Ovl/j0ttRG
 f9FkSsAgWZora0hNfzp408/FinzQzsBtxtumqWUwJkiodIKbHFn5OXml77SsgNAf9MI+D+J1W
 m7QuBijNmiUvnKtJ2eJXp3TUxdq+CcGodhLKEIjXnpzuuw6xOpUomXpwVY9xUlQ9qehDkW61f
 9Iiv9BxOCVUrK26cqNrg6PJpKmAzUZDWmr4Scc2Y5ckhHNYfTVhj4I7ZJD04CNVo9xab8jH9l
 coGrUs1q+XwbEOz0ZGShsDTpPDJJayaVwhEeDrVXcRsxz6vC9kztw58wlS7X+gR4o0Vrm9yJX
 vRJ5tKO8oRnzwWA5HpIO959jW53HtsePmefHq2p/6boQNLM/dKXrzCs8K5dKVcbnMdc5bXt+W
 T9Y2jOrmHcYo/Q2LeDNVdzHx9p+kjRXsm1VYwBU50lwkCnCwF8rNg0RN5YgRyM2XlI9sJoP0a
 0xhxaUfvkZru7m5lO405/nL0Q/999HY2l/faf55IkJKp86bQ4Q1sQ/v8eI2YPHzoV1zGy1DX/
 s29yTT9eNK/vIb3ID73+zRVMBBULGoHyz8LELQ/qKXKASJJc0nwqepe/f
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_plan?=
 =?UTF-8?Q?ned=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2090
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/2421b61c-a48e-415b-833d-3493d9b7924f%40web.de>

> Some of those were bugs that have since been fixed =E2=80=A6

The corresponding issues can be marked better, can't they?


> In most of the conversations that you opened and that I closed, you brou=
ght up things that you perceived to be issues. You then were told that thi=
s was actually not actually a bug, or that the feature you requested did n=
ot fit the direction of the project.

The development interests and resources are evolving for a while.


> This was all explained very clearly,

The impressions and understanding challenges varied.


> so I'm not sure what else you were hoping would happen with all of these=
 years-old issues.

Usual software improvements.


> As a reference, out of 336 total GitHub issues, you opened 198 of them.

Such issues were reported through some years.


> The unfortunate reality is that this is not the case - =E2=80=A6

We came along some communication difficulties also because of different de=
velopment interests.


> - you enjoy the project and want to help it succeed, =E2=80=A6

I am trying this also for several years.

Regards,
Markus
