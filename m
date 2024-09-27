Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37399CEBF9C
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GJIBLcJgO/dDa84DS2kuSua56jdlRWay9CNUJs6SwHI=;
  b=sNK0pIOzyg146T4FS9iqKcq9am6GfPOy6Z1KCX4aJ2I8u6JeAqnUmuWo
   B5yQFEn8B+fAOyWdkTZsSrWY9DkPP/nv6lcejiJAXRcOxE4ZQ9fBCR/yo
   K1JjSJP1VTK0PafpkUOcVWRtlBye6IM7fSKxDvAE7uBSflj5tEp5mWM7m
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185520437"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 14:25:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40C61E0141; Fri, 27 Sep 2024 14:25:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 80450E0141
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 14:24:57 +0200 (CEST)
IronPort-SDR: 66f6a418_2QLR1DXkQHjV8D6jdj0MRhXj1aLsv5A3YubBRqPFaxtIWuO
 48pVQzRYBTEnho+XM17jrOWQZJsvQ/SqzxEUjBw==
X-IPAS-Result: =?us-ascii?q?A0E3AABBo/Zmhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiFUMwQLSIRWiB2HMIF1MIQ7hzqHVIh2gVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEggyCdAKKBwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQE6Bw47hXUNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdEAQEBAgEjHQEBEScECwsaAiYCAksLBgEUAQGCfYIwAQMOIwewQYEygQGCD?=
 =?us-ascii?q?AEBBtpaHywiV4FjCYEaLgGISgGFVkuEPCcPgVVEgTwLgng+hEODW4Jpkg2HZ?=
 =?us-ascii?q?IQKJYhfcJEsUnscA1khEwFVExcLCQWJOAqDHIFuJoQWCIErE4NfgWcJYIdnY?=
 =?us-ascii?q?oENgT6BWQFGgnNKg0+BeAU4SYJRa048Ag0CN4IoJGqCXIEnBAWDUnYdQAIBC?=
 =?us-ascii?q?209NQkLGwY9rj+GSsVmNAeCN4FkgWMMn1IGEy+XPg4GknOGIJJWIqh7NYEyO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiEZhBS9fUE1OwIHAQoBAQMJAYFVg3ABAYZBgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:u9WDgqsJPd9aoBCiGIl22vau7skDqNV00zEX/kB9WHVpm7+j5q
 STdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/hzAV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:9lim1GA7y7VA7Ub6E3hm0V4FK+BiTnnylFH7ZAi5OD5KRJTAHA==
X-Talos-MUID: 9a23:/noUkwpyrCjmMxfpvHgezzZ7K59y+v3pMk8is8UKieO7GjRNfDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="97592626"
X-MGA-submission: =?us-ascii?q?MDHQCDmTWf5mBA1RvK/4xep62wVnOyHb8+RKvO?=
 =?us-ascii?q?dpJLjMkJZgY/0KHEAhdLp1pcm+4m4+KKtc8pt7Qxqry+10D+msFjhxza?=
 =?us-ascii?q?fyrDqcas2XsOVLiZ2nQ0v/c/drj7/7OZPEs6PIh+KI9Rl4jQR7JvMhTX?=
 =?us-ascii?q?Jmj8YNMKC/QZrcql7n8zGrkw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 14:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727439895; x=1728044695; i=markus.elfring@web.de;
	bh=GJIBLcJgO/dDa84DS2kuSua56jdlRWay9CNUJs6SwHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L7OViz4YaoixH5WwiV6Udf5dbrxsL66mTjlqmbPNmMIYCdHGGi/gC6zFJ168Uxyt
	 HbVRgHULbdFRmhr9VAeVfkyBqhCOwVDFIG2MZcx4itxp3WfhB2oelqsRaMEqTWXHS
	 Lp++zqdBUHgyformeVliTTqltP8LA4AxcY0FqOdj+C2hZFRPATngitHz+fpiiY36A
	 1vyu9rhhKzbslvC+u/A7Xl3TXY/rh9kdSan8w8rNVN168PKJR1p4yclVLZPe9T7FZ
	 1QtAOYcLO7hwJwy7y/uhdL8NTIkvffBwvpYomwtsMCDtTH0aFSUnzrGoTnA1Gmldg
	 rvNbhXv4TQS9kILcug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1sq3QE38jZ-006R4C; Fri, 27
 Sep 2024 14:24:55 +0200
Message-ID: <feffd7ea-f095-4562-9a82-3a1ec72ba5ae@web.de>
Date: Fri, 27 Sep 2024 14:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
 <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
 <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
 <f2835a9f-425-211e-2d91-e6ff92903dd2@inria.fr>
 <3771e8f1-e6a6-47fe-a348-3ab248d765a6@web.de>
Content-Language: en-GB
In-Reply-To: <3771e8f1-e6a6-47fe-a348-3ab248d765a6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aJUZaKGky74zKSA4WGAPVfyE+n+s1GOb2RtPcHf4VKIjjsfTnVl
 mKyo2Ozkxuad/mP+9IsuEkHxZFzrQXbfYkHTLjMGJjz1H4pwN3NUUTqShnV9djKRIuMoytl
 tKPOPnWsXHjvjkSGestXTJLrKOqyVEcxcwRBQPPsembKOfXyfzQkGGUa3mXafb0AZIwR/Gs
 s5KHV1fOEcbBwlt8EHalA==
UI-OutboundReport: notjunk:1;M01:P0:1jNATDuzjBQ=;HmnrUf4wC1HNVamW3U+B3f3jTSv
 OhIJUQrjzv72JKrGZwcutCS1+x5Ymjl04uMgCRdoGEYOBXTiNG2n/Q47A1U0GW7ItefliDEkG
 SVyCewohMMub7d3u7VAcXY37nACS5tudShxwmYVOAC0pkqHcnGmTV8cXxkQDnKjFXcQnvMxP9
 e96Rms2OPsFeqi2nzBvPHMm8A2OVwV5ea27XEo+0Wm19kcGddMYJmimcewahC0QJ2c8qj4z8y
 AFzMEBEtrmk50TXOQup3PEvccww4M7qYksg4/cPQKLZjgoYuTuIW2nEDS8lmjjj52SP8Zc0sj
 A7wDULWpnkA/WfyjIf1IclReA7sg5EONs79M+UuU+whybVKj1RmWdCsbuBdvWtu4zNXiUMEwe
 uFKB158Ce/0D9CgCyLjc7qPBueeExfunB+0+Qsxt0FmZSJDF8drsnkqFWxxWRRkCkIuatELnv
 1qqUefURfT2z/M2+7ca4/hUZ84KYAiBqnjKz+gI4O1GyKsYmrU0c41Su2LRIq4Uw04ONblWkk
 YP3z0zVr9jVcbB5pBxZLQRL3gL7q1m+FwUbJwqtmZUm0MlVLIJ+3tYEcZC5hhCiDUDRUSdb6k
 8f3PsmmWnk4jp9T5iDO+9B8hQly13+S+0N5wuFIlZstkX7lcW1opGOX2iYDmYm0jpI4xe1RPr
 /GKO6v1i0xls+6Ifwp3d0aLSd/bi/nJS78Njf3bFNgoRUsU/S88/a5ZkHgn+Mk/WCxPUScCbY
 54rlIlZl8cow25DV8sr45Dnoqg1O3hSLJeiFDsSGiI0Re8359O9dLfvkJ8AeMBnAcG67bi4p6
 vK7PapP0wohxJMU3+GReGX1w==
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1894
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/feffd7ea-f095-4562-9a82-3a1ec72ba5ae%40web.de>

> I miss the presentation of a known source code place.
>
>
>> or a real example of C code that you are not able to match?

Would you like to compare such a questionable test result with
other helpful data?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
timeout 45 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Projekte/Coccinel=
le/janitor/show_kfree_candidates_for_reduction2.cocci > =E2=80=A6/Projekte=
/Bau/Linux/scripts/Coccinelle/show_kfree_candidates_for_reduction2-no_loop=
s-20240927.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_kf=
ree_candidates_for_reduction2-no_loops-errors-20240927.txt

real    6m39,686s
user    23m18,287s
sys     0m23,439s
=E2=80=A6
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyse=
s> lsdiff =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_kfree_candi=
dates_for_reduction2-no_loops-20240927.diff | wc -l
325


Will such information trigger any further software development considerati=
ons?

Regards,
Markus
