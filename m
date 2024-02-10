Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A06C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 10:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hho55E+hDp5dkAA4vbG++LEKJ3ZFqkoYPEezCn2rs/E=;
  b=OicE1CCS52mHxQcw+aTHHxR7PLVsDZ4/tvdw7taitYbJgoZrPpTtXgyX
   KiHePbpoi4QbRPIjYSc42DF3rvUSvhUusr0irrCcaqJ4i4p1LfE6LmItz
   UVccdi9HChv9JG43kqB3vrxuKn7X+eASulIgtOVpyAZVgsHSG6lVHSxFq
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151305007"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 11:40:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 175A5E00B7; Sat, 10 Feb 2024 11:40:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F823E008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 11:40:47 +0100 (CET)
IronPort-SDR: 65c752af_gBoIxqYpiHRLlzuHIKhAGdIlAPCLv0uSHtz0epeb+ZpPBA6
 7T6iXtwiKswoa04cMoHI2LbGDAzuor9T+Cc8DgQ==
X-IPAS-Result: =?us-ascii?q?A0HeAADLUcdlhwQP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4gVIyBAtIhFOPRIF1hGuHN4dOiHCDFj4PAQMBDUEBAgQBAQMEhHUKAodXA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgMDIx0BAREnD?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ8gisBAzEHs2SBMoEBggoBAQavWh8sIlaBYQmBGi4Bi?=
 =?us-ascii?q?CUBhW+EOycPgVVEgTwLgkcxPoRDg1uCaJ4zVIECHQOBBQRaDRsQHjcREBMNA?=
 =?us-ascii?q?whuHQIRIjoDBQMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8CwQMGgIbGw0kIwIsPgMREAIWAx0WB?=
 =?us-ascii?q?DQRCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4ggmBP?=
 =?us-ascii?q?QQTRAMQgTSFPoRvAxkrHUACAQttPTUJCxsGIgEdAqQ/onmiTTQHgjSBYIFhD?=
 =?us-ascii?q?J84BhMvg3IBkzsOBpJemFcgqFeBeSSBXDMaJIM2TwMZD44gGYQUj0dCNTsCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUbmzox1dQRDY7YJZDfWEc=
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:SUAbi64ftsCTLixfFQPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3A8PFQjGgT4pFt6qPCNx0Cj2djhDJufiPb81jbfHS?=
 =?us-ascii?q?CV001WIaNdHq+x5huqp87?=
X-Talos-MUID: 9a23:0Kqa5wSRKgjk9DT9RXTFizd8Csg5wZi0ER5dwLQ3p5GPOw5ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151304999"
X-MGA-submission: =?us-ascii?q?MDGY03UR0W/qhiWhmVg8Aw2+nEduIQTIwVukyb?=
 =?us-ascii?q?z1ZeAltiO10kAetIKbHNV1wctLFkWlJ0TyEdXfqfhsxaTdYNJcVHC2Ai?=
 =?us-ascii?q?Iv0AmFsrlwjJZLfvDGCgDeZpCWeLhyx8aE1N74QfHp06rz8fTKw9oTt+?=
 =?us-ascii?q?G3+M0bgK0dN4IqPDZgGP4wXA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 11:40:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707561646; x=1708166446; i=markus.elfring@web.de;
	bh=hho55E+hDp5dkAA4vbG++LEKJ3ZFqkoYPEezCn2rs/E=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=GTvqLAjYzsfJGvkiQvmFckwC8jXEtukFW9A5GOtslBTz4+asAlZKgZfXfyPC4JsV
	 q65BDbudDMtuVEwi8O7BYpDh+ybJ4HS+yAZj2shZh/uWrUYGZVeWMSjeM0RdwyLr+
	 y/oguLlp6GDTzTxBsyx851ulXuNpV6rUsPT5VTlR5PzkJyK7s3o/VFCScZlwj6FAf
	 ZfeoB5BMhjrTHxUaV0QKRIglKpJTVUL7LCSKTlb0yV9DpD/DLBq25PzFacz13jvUc
	 GXtzIudh5JHg4fZ3x1M8avKqigMIOxawSPdlv/MwzzARhruPN9aXCpWjayzL5+Heo
	 jJYQRU5scdD32ZlNHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuKH-1rHvQB2aJp-00LJ76; Sat, 10
 Feb 2024 11:40:46 +0100
Message-ID: <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
Date: Sat, 10 Feb 2024 11:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
 <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
 <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
 <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MmARvGngW926mK37nojW5px87AUziicteEtC9nd6Bi7RifIg5QG
 oVWIQb85AAOuesDgOB7cGATfYpSCph2h3JVXvH0686jW6ctiobHOY196OGnJW507vvsPMbr
 8gPg4z2VJCnie29UYVutZcukOVegy4ppg6vz0/0bMGrrW5luhrEGhA3QwJZI22ewkjhOx29
 JzIssSyxdYd7GM6XRof3w==
UI-OutboundReport: notjunk:1;M01:P0:boW/JKiV/0M=;v+ThoSpN/lo1auEwxBNIoNe/whe
 YehCV3sS/d3Fvazy4cjzqgMx6A9WbWLlZTWI6ob2nNq4xOBHTsMUXbgbR3eugq3IGIO1XIjR8
 JJGhY+mwII+N2yzTd8RNgSbSX4X3b7UCFqFDTvIkWEvEhewlXu8Nk6IMA3xverSTfuQzljWVu
 S59DmVsPtQ/nZphBlG94QvoshPJS4l5XeBIVrPYcECs0Zco466DlwXc2g+zMvb6bHJ0RrXkwu
 CBPBi3AzFP7B49qUtH42pU9fqltNbQ9kpQySLzeLOiIMXuJLdB0eNVNPcUdRd4Y8wnTsZ7Ftr
 qudVzfh6ZrA97Tr/L3RC+0uUdwQNacM687M0/9YvBlGzyPcYkU0gjE93IsnpSd0YFVNYBowlv
 lMS8pi0N6QgA9rPxXLsd+oUGIjNmo4DLpXsiLibE75EoTwAQRDDajOd60S14u/sAVjMGZeIBV
 HoVopFwGRL66tXxvvuRwCCUC+L9N7MT9JMzjZQgqVrrDDw4/bpk0I+MT8KcKPOUpRPbjWRkOU
 HObn79gH/zbVavCaqZZczw4ByjdiTuUoMbPDJ+EIOmOihsinK35gJFVADZsksLjr19FzKNj7k
 3fe7CA8//iH6tSGz7ts6BhnO1qxPkS+E4yJQYm4fV44Y8pt6tVKc6CLCmGymXenXCLbu3pZd+
 mu4S5+PXwC8WQYO2OTUH36paWNIBz4jfgLp8OjJIYJSwjva7qbvDZB53zhkp4sUN8RG/tNasS
 pHxY1OtWExBa8nGUSN0/6Y0mIh/6y7qj2sNPxEDUGQw6vj/XRqitINdkVDrSqSEAjf+fOfT5T
 Swg+oTFYLANCSextTmxFI3/CvXWusatoUMgixAIcOeZgk=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1536
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/501ef7d8-223c-4647-a302-7aeee083af14%40web.de>

>> * Can a position metavariable be reused in the same SmPL rule?
>
> Yes.

Such a variable was assigned (or do you prefer the wording =E2=80=9Cwas bo=
und=E2=80=9D?)
somewhere in a SmPL rule.
How would later SmPL code refer to the previous variable name without repe=
ating
a companion metavariable identifier?

Regards,
Markus
