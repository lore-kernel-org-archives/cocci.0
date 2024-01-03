Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6E1C3DA6E
	for <cocci@archiver.kernel.org>; Wed,  3 Jan 2024 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y4gNnc8vuyVdH9rwVu8O+efHd1KGAb1bxzesdM1b7do=;
  b=a/ZqqCxbJal7L0dGBYbbrWEwYuXzXP0+INY8p1+/OPBAsPITuZQ8Z/P9
   H/NBJemKwz5nC1hfPDOmaE2ZK/5ipNBME5oCZT6mm4sKCvql+A+GHcLkU
   xV6RMeErfxcJIQPhWqsyCbfGrfKR6IyGUmoj6hwdg6lQarY/J8agDl/zr
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,328,1695679200"; 
   d="scan'208";a="144733077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jan 2024 17:25:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C268FE0CCA; Wed,  3 Jan 2024 17:25:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5125E004E
	for <cocci@sympa.inria.fr>; Wed,  3 Jan 2024 17:25:38 +0100 (CET)
IronPort-SDR: 65958a81_BjlE0dncKRbakhKZ0ekukRysEW/unCgNznSnz9+eTpZWJSh
 5vUhSrMnWDCS1V/PtqgWJMu8BbJZOQ7sViqoiJA==
X-IPAS-Result: =?us-ascii?q?A0ERAAC2iZVle07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE9AwEBAQELAYI4fANTMgQLSIRTkTYtA4Q7jwGEa4QEgVaBQ?=
 =?us-ascii?q?D4PAQMBDTQNAQIEAQEDBIILgnQChzYCHgcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAhQzQgECAgEjBBkBAREmAQQLCxoCHwcCAlYGARQBAYJ8A?=
 =?us-ascii?q?YIqAQMOIwcNsBt/M4EBggoBAQavWB8sIlaBYAMGgRouAYgaAYVng0F6Jw+BV?=
 =?us-ascii?q?USBFScLgQmBbz6EQ4NbgmiCL4NGg2+LOViBDiADgQcEahsQHjcREAUODQMIb?=
 =?us-ascii?q?h0CMTwDBQMEMgoSDAshBVUDQgZJCwMCGgUDAwSBMAUNGgIQGgYMJwMDEkkCE?=
 =?us-ascii?q?BQDOwMDBgMKMQMwVUIMUANlHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0E?=
 =?us-ascii?q?QkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHUAMZKx1AA?=
 =?us-ascii?q?gELbT01BgMLGwY9ApRTAYIwBlQoPyAmlG2yGDQHgjSBYIFhDIoYlRMGEy+XJ?=
 =?us-ascii?q?g4GklQuh1CQTyCNSpp8gWoCMYFJDAczGiSDNk8DGQ+OIAwWFoNzN45SAT1AN?=
 =?us-ascii?q?QI5AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 pOm6X5NiVoLhD8dIKvNOOxWw1IWiq/c5keV
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1byI/quTUJMu1xqC6fyuTPFu7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:y3OXxmBCVKGF8LX6Ew95+FVKAcd8S1uenH3iA1CVL2swF6LAHA==
X-Talos-MUID: 9a23:sC27ZAV166EEK7rq/GSrpyNbbO102YSFDGciyrkMnM2ZDjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,328,1695679200"; 
   d="scan'208";a="75728715"
X-MGA-submission: =?us-ascii?q?MDHOPQga4DEXWnp0/REl5FDEBp6BcUITO0QYmr?=
 =?us-ascii?q?MxzCFV+PDU1r42QGv70NKXDBOwkq+X/hMIeSU0y7qdBQS5sK5oh+bWso?=
 =?us-ascii?q?h4TTctrHeVzIvR3ysuWxUkPZiNLNdWYsEv0cfgx4EDm+9ySF93en2Ac2?=
 =?us-ascii?q?O9aP2UNObF+dIDQYJ3X9LN6Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 17:25:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704299096; x=1704903896; i=markus.elfring@web.de;
	bh=ClXQs64Aybn4pQe7H31+xNfShyDpOwOZKsYydbx2rjA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fLAJKfpkrLG9s4UgDUFDP3oIUuxwbdEVTCLm2Bu68Zlw8xL5zmIcHVdq+QQbjvxy
	 XikMA3IxCAA/zqX2Iz7S1Q+xeCtBI6mOFbAdUyHP448rUvYpe/2kRGoInjlmrZSAF
	 rUwUgiePTeUzFqgskwsWyxLcnqRsYXQIUckwuDEzECs54FCuOazgBkpUnR2BjObG4
	 Ka0ACPJ1IYlFEv8GdcgswYPjhIvNxb7ZagHZHdSeHz7j48YtEQDi18aluMkKShKhj
	 UgQd3dYsu8AWbhUJWvSPR7kcZy2bBAFgDAsNPPQ6OmeNWQU/IwtcmoHjemz3Ja1ee
	 A37NTp8A3elNUfQvZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1r2qi60Q5e-00sm8S; Wed, 03
 Jan 2024 17:24:56 +0100
Message-ID: <c5f1a7bf-b444-4934-a205-3c2b3a045ff7@web.de>
Date: Wed, 3 Jan 2024 17:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
 <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m52ma2VKpDCFMhQhjPfaQSHvNMcIEZqritcXHHLGW3bJuSnNW0V
 KbJHlIwID4pTZjo+NtHfxXqxjnURS5twcbiC+E47w5mbyvuJcDICd7vCJEdZsfpk00OTXFi
 47y6MIvagOxoo+NLlzdISCDsKTge0EspM5uLcZ+CSkkODIBWdn1Xj15cUhGB8nKsYe+ILFS
 agPjAnMNbDP5zDe4ksrpw==
UI-OutboundReport: notjunk:1;M01:P0:UuoOhNjX3vY=;TThZ/Kyymlf05+h0ctlxFzQW+Sv
 Yv6cYl0qVJGnivhBtF/e0aquTh8g0tpw7Y+jy1KSBJ/eEKowyV0mqYukZ40qOcyUok9tfOTqm
 +vrnNbeilm3FqYN26pAHaZ2cR09uIMESQYdT3DcCTgGiwkuZK0mTqriuFdkkpSv+yZbT4Fhfc
 u4KXhsAN9cPhCF9TD+8s39YyaNViGuQoK3L9o83z8c9n3kEoHAV9hGeGYHuSrB+Vf7dx8wWyp
 pzjW3Xwe2Va/WgmnTyVBG+5PP6ElrLzccYBvAVRnKtu008jiM0vcT99slwHS//aBgXpEnvMXm
 //E6Zw6jA+FPZ/SzgFjcjOQtY7niBlWsh46+BBDJPygJBPzYrV9GJm1vkcmtet3eQufh4r6Sx
 IjeU+LrJcJrUB2Ac0iJOrS/osioP0+vkt0k3IrC5eLeelBzug44RZfofSomc6s344XSYdk4SH
 M4oEbCxq1maXc9KAUja1o9+nDKwICGz1Sn8aAzp/KoYwn+ejRApYjTlydCJFdOmKOOwmxohaU
 Zzvpc38fuZvrp4yBO5prB7VmXon5JzAtaucdtfI9cKqAm8KTdF+c3J04okGrrxK/tt4to/9ka
 g57Qi1w4cLwZcxj83PAORfZ5KQDf+XeTC6jLBivZzfOCtF039UzgbC/IFEw1OdtlkvJXXt/ca
 u/n96kdC/nhxVM0m/3rlTJkhVd3GkvhSaHUYNhSKIYEsQVwcZ80GdHcE4i0FOq0aVLpRNtRaW
 S3laOZJB794Qb9MCCeFZ1eTIfF9C/bbHfNiTM6/agd+TBCJjWeGMCuKcKHIq160dcmYwUobP3
 nS3HUi7R+ztTG1DN+OGRnNxWJVJ/H0NbS5CCRpHyg5OiatRBcv20ewji7jZufkKAjZHZWXr5p
 POAY7Kxw4Cuz6MKfvgKUQg70//dZSufZKF3iRgu6ryfxwtX5RaWrZqXm7XUkkxL9HJzR+Lzg7
 Wahs/w==
Subject: Re: [cocci] [PATCH 1/3] drm: property: One function call less in
 drm_property_create() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1429
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/c5f1a7bf-b444-4934-a205-3c2b3a045ff7%40web.de>

>> The kfree() function was called in one case by the
>> drm_property_create() function during error handling
>> even if the passed data structure member contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>>
>> Thus use another label.
=E2=80=A6
>> +++ b/drivers/gpu/drm/drm_property.c
>> @@ -117,7 +117,7 @@ struct drm_property *drm_property_create(struct drm=
_device *dev,
>>  		property->values =3D kcalloc(num_values, sizeof(uint64_t),
>>  					   GFP_KERNEL);
>>  		if (!property->values)
>> -			goto fail;
>> +			goto free_property;
>>  	}
>>
>>  	ret =3D drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PRO=
PERTY);
>> @@ -135,6 +135,7 @@ struct drm_property *drm_property_create(struct drm=
_device *dev,
>>  	return property;
>>  fail:
>>  	kfree(property->values);
>> +free_property:
>>  	kfree(property);
>>  	return NULL;
>>  }
=E2=80=A6
> This change is pointless at best, kfree(NULL) works fine.

* Would you interpret such a special function call as redundant?

* Do you find advices applicable from another information source
  also for this function implementation?
  https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+=
goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resou=
rces


> Out of curiosity, what exactly did Coccinelle report?

Some SmPL scripts from my own selection tend to point questionable impleme=
ntation details out.

Regards,
Markus
