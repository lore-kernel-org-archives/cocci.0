Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C5C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9kYB6UVGgjw3MFIoUJxRuL9W1R/51TuOk/uaLOIHxFM=;
  b=Bw58CdXlBxeWLuLaWv+btpCc0WHUxwJsoxqq4NnjWkF7bkN5Xum+bHqI
   W/ydBrkIqy+2qX7dMggH2TWJSZCzO7ckktVxsOjG4VRaRswYva8dw5/3q
   FxL01znVMmN4au3yC62iLBlYS/3NlUNFVrvjspN+EwaxTl/YMYp1ob8df
   8=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213671899"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 11:24:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D226E0D1D; Wed, 19 Mar 2025 11:24:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C0070E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 11:24:54 +0100 (CET)
IronPort-SDR: 67da9b76_YU1kq462k++zqsXT/pCwYUEJjJQWI5em706yBC168+Wb6L4
 Rj3hrQgRJTdPYoky4mv2F/qd6gulQSqwjl3B7RQ==
X-IPAS-Result: =?us-ascii?q?A0G8AACCmtpngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDfVozBAtICIROj1CBdDCEO48OiHWBVoF+DwEDAQ07BgECBAEBA?=
 =?us-ascii?q?wSEOkYCiyACHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAEBAQIBIwQZA?=
 =?us-ascii?q?QERJwQLCxoCJgICVgYBFAEBgn4Bgi8BAw4jBw0GriV/M4EBggwBAQbaXB8sI?=
 =?us-ascii?q?leBZQMGgRouAYVsgmMBhicJgxSBHycPgVVEgRUnC4J4PoJhBIFeg1uCaYIzh?=
 =?us-ascii?q?EFniU6IVIdWkEdSexwDWSwBVRMXCwcFgSlDAyo0MSOBIgU0PzgpgWNpSToCD?=
 =?us-ascii?q?QI1ghskWIIoagQFgSSCNoQ+hECFUIIRgV0DAyIBgjBvdxyDFjV2P4RhLVCCF?=
 =?us-ascii?q?h1AAgELbT03CQsbBj2jMTuFGzYslhuPUqJyNAeCOIFmgWMMiimVNQYTL5dGD?=
 =?us-ascii?q?gaSfS6YUCKNY5sugWkBN4FcMxokgzZPAxkPjiGDejO0fUI1AgE5AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 MM3hsFjqReqn7vXogc=
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:O7wXTK4JLwNoV2uPAAPXwNXXdLJyesId70hD6qkXc203TiX4rb
 HNoB1173XJYVoqNU3I++rgBEDwexPhHPdOiOF7AV7IZmXbUQWTQ71K54GK+VPdJxE=
X-Talos-CUID: 9a23:sV+38GHVBCr39fnmqmJMyG8WS5oUdUfg523aKVL7JmhzGf6KHAo=
X-Talos-MUID: 9a23:wadktgQtM9l9232ERXTUmz96N95m3Z2qAU0nnM0o69ecHCFvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112012074"
X-MGA-submission: =?us-ascii?q?MDEIi3kRUMHdzaaexmYAa6l6xW2SCuWz4UTDR1?=
 =?us-ascii?q?OklUHy00puqVjePs08mPQ5OdVR4cICHmTXjWNLXc7m3VJXDc7MTJaSKa?=
 =?us-ascii?q?UpUzAEXpKog1nSZqd+E+aDQ0vqDR+WukRTpSg+sGYAfZIfoSi7k9e6Vt?=
 =?us-ascii?q?1VXBvM3Yk+yxjMngCkQYYTZw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:24:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742379888; x=1742984688; i=markus.elfring@web.de;
	bh=9kYB6UVGgjw3MFIoUJxRuL9W1R/51TuOk/uaLOIHxFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QtXf2lHoGOTAwRMUJoS+QsriYN3IxSWq1cbn0M1pF0S+PLhmSQSUW0eMTiOE8kPr
	 +gL7UiSHFSaHOPRYXk5RbDb6TfWe8JkSvb9JkZOkQTNDmIv5zx3R9lZJoQA5DMec3
	 wdPAZhN8Y50R8nAEMbLOImoOHI31aNp9Xsd1GrtgIUKvPuGz8pkzarMX+g50VRcXh
	 wbP2IgvjxUBLXaNObUWCcXSJLk1lpCVJbxi96xcze9dEp73zdExf2na5Jzi0j3Kjr
	 RRKj/6JbxS6OJ8D8fq1u+3l6v6BJZBn4zB4h2XeOmMia23le4o95xxIsFyBmq4ExG
	 r5gxGDni9B4qWWQS5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1tICSi1pS8-00hewH; Wed, 19
 Mar 2025 11:24:48 +0100
Message-ID: <ac237236-9641-483e-9f3b-9bff6bcacef4@web.de>
Date: Wed, 19 Mar 2025 11:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
 <202503182023.D7C4D91@keescook>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202503182023.D7C4D91@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQCDH9JAkTNEayjTDo3Sq6/YOHFA8VXJj6/WlMssNOq2l2HyDmw
 SUWIWe7CxTsYyHxx0B7qdLbUZT/0C7wEy0JTswEbWrhRdN+n1JFVHtZL2mBlgMOQKZrWFMh
 73KPB3a8tTre04LSlO/EpRF8qytw3VbZq69daDRGLepFF3Ro0Q/NfpXMhuvtDun6Y7vviKj
 uztbYBkBCRiKk1HxYcqmw==
UI-OutboundReport: notjunk:1;M01:P0:SIvWLIvbw9o=;Ej96PZ/Nl0l/gYWuabwLoTzPi1y
 IS6ezZCOd0vqU36Qsd13YbLfjobIZ7FP7HIS8/8rjGZctK5jmk6C2sa/i5HYBYgSPXc/qpcDI
 Ow8IhWhNjrdGGGrbzwcGaFlJYiTLXNrKm9Qg0loaiyULKmwJMc5pfm74QJThlzRq1qePKBkTq
 WLqnHd9FihAuoLuxXubkoLlOofvnnFSD6C2T/90sRIqobjKrQnAZXaI9IKCPm9DyV2RIqCQ3m
 GlNam0W2XGj0QWdHf3X/8NsaZ1b26Z8RZNW1CJy6ytZOr4RZF2u+wB7cu9Udl8IzDDU6HUzKS
 mY7KzUyqa9qxUnpA+0vytU883ZY+L/rmc1bVJ9gM6G4wMM/e8iU8a3GX1vil6FuriE5vr4DCB
 ZKnRZopQxGcXBYscE8RboErpWyZkW3TKy6qNLyFSQ6s5s6cCB1gnRU+EB9TXuRTqEwfa/tm/V
 u04T0E13e1uaIaDtBlw3aNH7kJdwWU8c+WCCGBFk0mp5SwjQHDw8mRN21eJ9SAhAAM01vy4OR
 XGmfGLWzKEHYVAMJQF4aVz/XK7LpQq6MpBDpIlWFW41uPGrIHuZWjSDTnlHcJv+NkZGOecciW
 XBqNZ/Vjt0iMvX1xztmKDMpOtGQ7GZSfbFZVgWKuTw5LikP8KFYrTq/Uag6wiTUw+EXilt6RP
 5qt1owBO3GsNapjQtl0rp1TJfdlFmS3JuKgU9T14yvBE7dV94Uk0NPCYkeM7B3BOfzxTZIuUa
 rOFcfdMwr5Swg9SfOrzdqkeOSOrDa3TpX20JrXPhHNBv4NKY5DRZxE3qmYEWXklL15Atw6IZB
 hK1ZFMeg5zYhjOFgmSCnMy4Jt5U1R3b6BPCppGLLD7SfSCNMHaN6Oo2WjYVZjna0+0qB8GUn0
 bi3rPNrkqkSOkhI9gOyFaSCVIQIglWLXlp3CdEHpXdF3UzTq9Elp32vxwr8K7+qqjO6ZcVi5j
 nNG6a6kduZjIaU0EBCJp35NUwRJDWl+lmNzwkE3wPRGrLGwHrlEMaMds2oV0/hg3+x5ZCf5D+
 NUiCxmPmJpT3QFq5xkMIJah2kIbpQ7aNAl5tENeTqG3bypXLePemgZs5p+S4+4Y+QUx/7zU2u
 MMnKO6sN3zjy8OWpcs9PJZC1b7kBkEnMsbyVM4IGjzMvr+/+twUMAzUavDru2fiFErNMTIKhq
 ieQoeVUwlN0WgpGjOyrTgEH1GUxpe1G+sAmJV/myL2AvHm1AEzxE/aRU+jxo1EgQzKiAkuSDO
 BRZViXID14bWlRzHpjKp/zba2xqwYBRQktb9SyKMxqR/ow3Dp1RkazkH+pmFF60Iy09yKb2yF
 P3Mnn0QxRqG1gYuaojP8A4ER3jdYg49gUbKwfbVWbbdPcOfQTdMUcC1BwfYrBa43YPTT993dH
 kSwQDvVWIbbjVcQ3yzCMsi3cmcB9TApPnBwRuYxyNoItJ4uS2Vc/gOXvdVWUflJkI7ElF1VGl
 2OUkBEF22nPhwSuPNi27MpddeFbl9F8sstUeUNKxeYgrPirA0O7hj6uiTWVqABLW40xoGHg==
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2644
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ac237236-9641-483e-9f3b-9bff6bcacef4%40web.de>

> I tried:
>
> @direct depends on !(file in "tools") && !(file in "samples")@
> type TYPE;
> TYPE *P;
> TYPE *MEMBER;
> TYPE INST;
> identifier NAME;
> expression COMP;
> identifier ALLOC =3D~ "^kv?[mz]alloc";
> fresh identifier ALLOC_OBJ =3D ALLOC ## "_obj";
> @@
>
>        \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
> -       =3D ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> +       =3D ALLOC_OBJ(*VAR, GFP);

Which metavariable variant may be relevant for =E2=80=9CVAR=E2=80=9D?


> This parses, but don't match (from crypto/asymmetric_keys/x509_cert_pars=
er.c):
>
> 	cert->pub =3D kzalloc(sizeof(struct public_key), GFP_KERNEL);
>
> But does match (via "P"):
>
> 	cert =3D kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);
>
> /me continues to scratch head
I am curious how the clarification will be continued also for source code =
analyses
with the implementation of the function =E2=80=9Cx509_cert_parse=E2=80=9D.
https://elixir.bootlin.com/linux/v6.14-rc6/source/crypto/asymmetric_keys/x=
509_cert_parser.c#L59-L77

Regards,
Markus
