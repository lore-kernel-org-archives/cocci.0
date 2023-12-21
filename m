Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC92C35274
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3eBK0y08/X0Mx1J6qNae4zJ/q5S9Fblba5nKQ/VfcN0=;
  b=Gx53m/Z9NYn0V9vQBXEWUQAbdUsf1esV3MYL81CCiIxxMxcXm2H2C9oD
   8pw+yyEf2DdAVLKSyrEX6ccP8wI0Iv1ovh646LwKNbzZKcNREYD8WL4De
   5DA9K/cMgI5jd+XWIXvgTlE0/M/vHY6ahlixlvrC6Ijn0RSSJP0GMCKKY
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143538843"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 13:52:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD879E0CCA; Thu, 21 Dec 2023 13:52:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F1FEE004E
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 13:52:36 +0100 (CET)
IronPort-SDR: 65843515_7k3QMzTplsckRUzhefP3qi8iiYRCjEWkeOtAhCq9W0tI2Rb
 hmhqUupBoIlIgaOWg93eCgKy657DSwn73DEW2YA==
X-IPAS-Result: =?us-ascii?q?A0HBBADtM4Rl/wQP49RagQmBT4I5B3hTMgQLSIRTj0GBd?=
 =?us-ascii?q?TBVg2aHNYdMjAU+DwEDAQ1BAQIEAQEDBIILgmoKAoc0Ah4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAkdCAQQBIx0BAREnBAsLGgImAgJWBgEUAQGCfIIrA?=
 =?us-ascii?q?QMOIweuXYEygQGCCQEBBq9YHywiVoFgCYEaLogbAYRFhV0nD4FVRIE8glIxP?=
 =?us-ascii?q?oRDg1uCaKEkWyIFQXAbAwcDfw8rBwQwGwcGCRQYFSMGUAQoIQkTEkCBXYFSC?=
 =?us-ascii?q?n4/Dw4Rgj4rNjYZSIJYFQw0SnUQKgQUF4EOBGobEh43ERAXDQMIdB0CMjwDB?=
 =?us-ascii?q?QMEMwodCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAaBgwnAwMSSQIQFAM7AwMGA?=
 =?us-ascii?q?woxAzBVRAxPA2kfMgk8DwwaAhseDScjAixCAxEFEAIWAyQWBDYRCQsoAywGO?=
 =?us-ascii?q?AISDAYGCV0mBw8JBCUDCAQDKykDI3YRAwQKAxQHCwdeAxkrHUACAQttPTUJC?=
 =?us-ascii?q?xsGPgInqiOTBLIGNAeCNIFggWEMnysGEy+DbgGTNw4GklIemC8gqEOBeSeBW?=
 =?us-ascii?q?TMaJIM2TwMZD5JLj0dANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlfY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZCko/6l2E3ng4FBh/Rk48QVfYg7pDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:8gf+/m3XB+pMcY5rPc5+f7xfN8kUXnyDyjTpf0KoL192YZ2sSXOvwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3Aa29n5QwvhJWYKtjKBOLVwnT486CaqI/+DG8do5J?=
 =?us-ascii?q?egtXeLQ8zKQ7E3DWZQJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143538821"
X-MGA-submission: =?us-ascii?q?MDE3l3cHFm952UEwGwl3DJ65CMWg4QmdkJP/qa?=
 =?us-ascii?q?YbArmBxxXWjeY7mGNMDuu/XaT/e4Tj3p6WfBvGjbKcptmPekWqrs1HkV?=
 =?us-ascii?q?BFN1A7VHeMlHwifzctGqL6lhlDcRe40Ms/1GDDvH4f/3xnWB+v+dzb+C?=
 =?us-ascii?q?AdTT2eJumWLJRKAy1mqxdzqA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 13:52:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703163135; x=1703767935; i=markus.elfring@web.de;
	bh=3eBK0y08/X0Mx1J6qNae4zJ/q5S9Fblba5nKQ/VfcN0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EzW+MkdNNupqJ0emnj7MPLJcKgVewKGPowKMGVtqvjF0VahIzEp/m/UHGd2yoYfs
	 5N+H8msKMRsajvu3sWqSFnQBHmREs0geGLj30sMMVKgvaTu70cNbVMBUPm7GoU6w1
	 WGJRS7BTxe9AFC1YCPwuu049dHMPXmMUcN+OAYp2pBa/VV6wLzZgeiv2RFtQMcpAq
	 xpx/HrzpZ2QV8pP3gBgqky8gDiKhvX0ENGjNpULYHgQZR7B8QpyyCRaym4PRFZ4dB
	 +qv/dMmb/5UvbUPUhbppHJPISJQq0tbQN+I73c2MvLw5aieOgfFigraH6dky/REdB
	 G3N7pFtJFCq7lhtAUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqTK-1riO1Z0Q8M-00Uhun; Thu, 21
 Dec 2023 13:52:15 +0100
Message-ID: <fe67dbb7-7dc9-40a4-a136-19a659e35fd6@web.de>
Date: Thu, 21 Dec 2023 13:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 cocci@inria.fr
References: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
 <0ecaecf0-6a50-43b1-8458-59d41bc5fd37@web.de>
 <80d307c-e3f7-8f84-78d4-b19113f441f7@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <80d307c-e3f7-8f84-78d4-b19113f441f7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJIhYaaeCVjWKr8LWXVL3oRgIPENaRKFCOqwRPXA8RfHdCM/V5m
 8DRHv2DBdssNV5VEzW7s7JQpbIuyBzYbe5atOEvwu30nV+kjTCb+lcQXC86cMLC1TFXrJiL
 dyyJZq/f8fHgwTLKwy+H0CaHwbiC+iZkz0UUJr/e92EQW1lh//Hu/x29U7543N+/unMbiyy
 SkOPrkDVRfK8UXJXvOj9A==
UI-OutboundReport: notjunk:1;M01:P0:gzANFfFz7wM=;rDoMYH2lABk+srY3AF9SrhkRYW3
 cardy8mp2Y1BRtk5mRylaT0+TifVJzTYq/SJkpgTV/7xeZ3cuLMnJI0NpBpoAgPxvy/MeRT2G
 ud0eVJANUA5seLo01CIwHRudLhn+BiS1NSKx7QN/39rJGOdd3QeaSTH5+1RmxrY2AAA9SVS3T
 /DIQdicNr+Xj5/fYvKdInRSJG99DvwVsgVU25oQHmSJVKEVTPZanVJU018g/bu7oqCDpMAktg
 ptGVKuHWLrWAXF9h0UxVibGPO7kNa77exvFazTi18laxguSl4XNsQ5rTwYzbfFDuEivqCY8BY
 mPokNg3zIS94W9VEPWnhJ4hR+1km0FWzYxAuiN1IQGDz9T0MGEwQnnovPeTUHgP+HearDk1T2
 aLJminyHc3guGlETaFrgS4Q4N/qrMRBOzr2vL2XUWFJhVKiOExy2i1+XoAmR/6DisfuX2rfzH
 DkJ9hU5GhKnyDTYxXpVRR8sb4iG8yhtD08Tgu4w7wgujbezap3UCKlBIMIq+I82jUTQFaUMji
 PWK5hbK1VK6/51UKcO/csPRj7naj0tYL2CEyfkSqTxNh3M/ozyx0vDKO2YFYXYrgX3DKDKoe8
 po4k6kX5cPmGtTwh4KSlidKLFudfH5An+ioGnCNsBD0+SevzRLQ9qVRA8G82LTvry25nXQFh6
 4horFfzH5fNZs8GQsjMvgRwr6zIsNxOTr4YxSgQh+6+QjSqJHktARuLqYvPsq8rb/og3HKz6d
 xJRM3BraLrF6Ax4WJ4YRFA4/5YbraeEYXo41+4Kk93El221wfNBkj6SHp5E2JTkM2sidRX9jK
 h1S5AuCt58f+Uyfw1wBcECz97eaYpTAhIPJdhzm7WDDNqxWfR/uT4LUPyBssIZEoMezjvyTWl
 SbsBJDdcrxUVh80+RBHPudZ343XEjE4JwiDb2RiPA67koMxPBS3D8s2eGrvJ3GThf7HWZFwb5
 FX1uEFMpLovOgzLfRoWuNy74rIU=
Subject: Re: [cocci] Transforming data structure accesses with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1356
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/fe67dbb7-7dc9-40a4-a136-19a659e35fd6%40web.de>

> In general, I don't want to spend my time on perfecting a .cocci script =
as
> further improvements tend to be needed around the areas highlighted
> anyway. It's enough for me that the most mechanical transformation cases
> are covered by spatch and I can handle the troublemakers myself while
> inspecting the results.

How do you think about to support more software evolution in affected area=
s?

Regards,
Markus
