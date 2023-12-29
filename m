Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A85EC46CD4
	for <cocci@archiver.kernel.org>; Fri, 29 Dec 2023 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TLIBnCVR41anr31BNytRhjf9vcw4oSOtATyNR7teNzA=;
  b=gRmgLpCUFBadrEvXJZ47we9pnRNbnr60HLswu43SOCDrOAQaQTIL/ey7
   ADwdEoklLFQgqIll9r95hLEGZD8CHAPCJV5Tqx35JDQHhPfX4y4Tkba9C
   Nim7Pvm5VdKx9g8VMF6D60P76AH5xidei/q7o/a1Abv0nqZzC2iYp27e+
   U=;
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
X-IronPort-AV: E=Sophos;i="6.04,314,1695679200"; 
   d="scan'208";a="144278733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Dec 2023 09:57:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02BA5E0AF1; Fri, 29 Dec 2023 09:57:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A3FD2E004E
	for <cocci@sympa.inria.fr>; Fri, 29 Dec 2023 09:56:59 +0100 (CET)
IronPort-SDR: 658e89dc_E4x0yrfH217DLun21jUTHVUdQ+JVczMufzqyjJq0LnUs2cz
 KmisoupUcoJjiAuz7Z1mYzh7YriisoD7hn06ofA==
X-IPAS-Result: =?us-ascii?q?A0HiAwCKiI5l/w4P49RaHgEBCxIMQIFEC4I5B3hTMgQLS?=
 =?us-ascii?q?IRTj0GBdS0DhDuHNYdMiG+BVoFAPg8BAwENQQECBAEBAwSEfwKHNgIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEASMdAQERJgEPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgnyCKwEDDiMHrk+BMoEBggoBAQavWB8sIlaBYAmBGi6IGwGFZ4NBeicPg?=
 =?us-ascii?q?VVEgRUngwM+hEODW4Jog2adM1siBUFwHQMHA38PKwcEMBsHBgkUGBUjBlAEK?=
 =?us-ascii?q?CEJExJAgV+BUgp+Pw8OEYI+KzY2GUiCWBUMNEp1ECoEFBeBDgRqGxIeNxEQB?=
 =?us-ascii?q?RINAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0aAhAaBgwnA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVRAxQA2kfMgk8DwwaAhseDScjAixCAwkKBRACF?=
 =?us-ascii?q?gMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHV?=
 =?us-ascii?q?AMZKx1AAgELbT01CQsbBj4CJ6YfBnwngTCBNpJRHZMdnnI0B4I0gWCBYQyfK?=
 =?us-ascii?q?wYTL5cmDgaSVC6HQJBfIKhGgWoEMoFZMxokgzZPAxkPjiA4g3OPR0A1OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:+JwgMqAbaGaadxVW/0zmw5YqxClBgxIJ4kV8jS/XYbTApDIi1T1Wn
 DFLX2qFOa6OamLzKtFyYd6/8UoDsJGAy4VlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHZDdJ5xYuajhPsvjZ+Us21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52TJQX/m4N9pN2szHJVH0cxwInxH+
 ONNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGvmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yWjKWII9wnNzUYxy0Tf9Fdy6JfhCevIJ/WuHt4JzlqK9
 22TqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgRSEf9vvSzzEKzMz5CF
 3EpFuMVhfBa3CSWohPVBnVUeVbV4EBOaMkaCOAg9gCGx4zd5gvTVCBOTSdMZJZi/IU6TCAjn
 A3B1d74Jy1dgJvMQ1Kk95CQsWyTPwoRJjQ8fiMqd1YOzOTih4ARtSjxaOhfPpS7tfDPIgGo8
 Qu29HA/o54xkf80076K+AGbojC0+bnMYA0HxiTWeWOHtTFGRZOXSLGpzXP57v9wCpmTYXfcn
 XoDmumYtPsvC7PUngOzYew9JpObzNfbDy/5nnhUAIgHyzSh31WBbLJgymhyC2kxO/lVZAKzR
 lHYvD1gwaN6PVyoXPdRWJ2wAcF79prQP43ped6MZ+Uff6UrUhGM+RxvQkui32rNtkwIuoNnM
 Le5dfecN1orOZ5F/hGXGdhEiaQKwxogz1z9XZr4lhSr8YSPbU6vFIsqDgG8UfAb3oil/iPu7
 NdtB+mbwU5+Ucr/QBXt36w9EFQoFUU/VLfK85F5V+jbOQd3OnATO9mIy5MbRoFVtaB0lODJw
 3KDZnFl2GfP3UPgFwHbRU1gOZXOXIl+p00VJSYDH0il8Fl9bJeN7JUwTYoWf74m+LZdzNpxd
 f0ketqBMNtLWD/o6zQQVrijjY1AJTCApxOCADqhWxc7J6Vffg3u/sT2WyfS7wwMM3aHjtQ/q
 LieyQ/re5oPaAB8BsLwavj07VeOkVUCueB1BW3kH8JyfRjyzY1UNCDBtP87DMUSIxHlxDHB9
 QK3Aw8dlNbdsb0O79jFqqCVnbiHS9IkMBJhIFDayrKqOQ3x3Gmpm9ZAWdnVWwHtbjr//aH6a
 NhFy/35DuY8o29LlIhBCJdu87M14or+hr1dzzk8Jk7xUXaQNupCLEWFjO51jY8c4p9CuACzZ
 FCDxckCB5WNJ/HeMQAwICgLU7298M86yxjo0OQNAUTl5SVI0qKNfmdMMjKt1iFMDrtHH7k04
 OUmucQpulWzoUdxAOmnkxJ7ymWoBV4DWpUBqZs1LtLKiA0q61caer3aKHb8z6+uYuV2EHsBA
 2Grlo/dobVD1G/uTmEWF0WR7dFChJ8Lhg9G/GUCK3uNhNDBoP09hz9VzhgaUSVXyU9h/99oG
 202KXBwG7qCzw1oiOdHQWqoPQNLXz+d207pzmo2hH/rdFapWkPNPV8CF760pm5ByF1lfx9f4
 L2840TmW2yzfMjOgw0DaXQ8oPnnFdFM5gnOnf68JPu8Hr44XCHEh5G/bm9ZujrlBsIM3Hf8n
 9dIx9opS6PHNn83mZYZWrmqjeFaDFjOIWFZWvhu8Z8YBWyWKnn4xTGKLFv3Yc9XYeDD9UijE
 cF1O8ZTTFKE2T2TqiwAT7s5S1OucCXFOPJZEl8qGYIHj1dbhj9urY6W6SX0wmMmKzmrfQDRN
 auJHw9u0ETJ7ZeXp4MJhNZJMCy0bLHooSXiifut/rxh+40r6YlRnIJb7ldwl2qYOk1r8np4e
 e8Fi7D+l4Rf9Gino2cg/mivyel5xRMfmdlkKDyOjuk=
IronPort-HdrOrdr: A9a23:TsfW9KxzwWKu30rcDv3dKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:5t9pbGE9nnFByt5lqmJO+3wQEOMPdUb3yVbIfGSSDkV0QbCKHAo=
X-Talos-MUID: 9a23:QYa8vAbFc82E7uBTmzPU3zJaG8tR0rnzIWRWislWp9vVOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,314,1695679200"; 
   d="scan'208";a="144278730"
X-MGA-submission: =?us-ascii?q?MDE4NpkjW4rKNeBU7n+1+yddlaq7YM2IRhDhpY?=
 =?us-ascii?q?c1NUFnY7jyWrYQ/ImWVmG4ELH9cMk9c6R8O42NwaVQ+Fri5mjFHp8c6h?=
 =?us-ascii?q?SI9hA/H/v30zLWeSQ4CI6ozAckbjDzsOlvha4PkyIkfKoCR3dPlJFNen?=
 =?us-ascii?q?K9FTHc1mRwn1Adkt2tfQkgMA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 09:56:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703840183; x=1704444983; i=markus.elfring@web.de;
	bh=TLIBnCVR41anr31BNytRhjf9vcw4oSOtATyNR7teNzA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Aw12T9BTOms3c731LbdPhLBu7QQ7WYYcMSe2es/lXoYMLdm++riAyrgre1jcn8UP
	 L7TJ1Pnh6ndqUhlrzK8XdOAKm2tTJ46d6pVzEpP7igdZtGZHnHoMh6xxgrXtHKwxv
	 K7PlYnZAWdciF8jqULSKGI/5ObrdyQwzBNc3HjiMU7JMVxpF5++ktZ28YwuC+TNVl
	 QhXm3mLN7h2W6NJFP1Ll+GkRIsoVOuv+4BMUtOi+Mn7wLM0y8zB13dNDlXSRMkVEs
	 kh4w2HUL4jihQacQ2R0qKSFRCZBayRVZYdkAoLRh6kEmVMK7b6nr7M3SL2TVulMtp
	 D7Ng0RHiJYsKnTd8Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1rUBH511se-00Foq7; Fri, 29
 Dec 2023 09:56:23 +0100
Message-ID: <d224c77f-048a-4fb4-b582-492fd428e270@web.de>
Date: Fri, 29 Dec 2023 09:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Oliver Graute <oliver.graute@kococonnector.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <9365c845-baa1-44d1-add9-ec8ca4d365eb@web.de>
 <ZY54UDosMHwj6D3Y@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY54UDosMHwj6D3Y@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K3N/JgCX21RpM3f27fdRKwJDDoLXRmG2i5YFyXwrN/krCUMYcE8
 0a5Sm2ZiF2RAnDHWOVUfRNQocEqoUuEdGbCpW0AwENZ0siJiN2CZb1WhSRGstr71sZTop03
 YVBB/G4J+DC6PDg7Y6EZ/NfJptbJCWz11dmhHXIAUgd/JnfFF6YS0h4cZsXkH2XcVF0m7Q3
 npARVFm6PJrP/sPvwEfZw==
UI-OutboundReport: notjunk:1;M01:P0:abzbliDP3o4=;nsgH/UvmEiwsgW3As5IIowSgbT3
 2dziVncnGh89DkBPVaZaZWtbkwNZHy0do+5q49KULlmBPD36s0DxDXTr0an4CHWpsRroF8K2A
 fw8uiAJMMUzbxxFw713oFHoyIOWRCsq08TnGzuL6lQee+KuV3aeHYJehHUPB9eJLxfqbp7qKL
 16+4cDQ+JDQ/TENMnl/CQIYA/E+TWM2WxtDXDQzO0qli0FK3U+Xbp34F3Hqnr3fWWEivv+J2W
 b1mYJ/JOwaE6zwcORbqMrDp3dQH/DhroaIYzOenrZ6bOgxBGhiyzQXxtLZZpbBBKYEDlnsRbk
 P2DpgkDfd0/R4rm6VjYlhoVOC5CVlzC3s5zxeThJX1x5WN+VvJc7n2eUU1TBT0d74WVryfTfM
 cWAlgHJsXtshVbVIdNaC2qtIc2x91PvwtqmBSfgsrmbn/c84VmiIcggyjGGyDl4nQv3sVqxE7
 ootKcDr3tLbTQC3ezv5a6S+dlUwUFQ9RLTm+AT4xXxxv2afDr2PqIn3J8hmLJqVXqtYSrVKG/
 r0AM2p58lEzFJPkfXFEzhA9oBeKOcz95oz45VcnEPvVKeGmW4pfRmzVpDa0+dfrJztGF5lqxk
 F06e21MB03swuaIPjvkZkn/Ln7GlBmUhJMRUywuh9xrXPWnk4G+EogfOWr/0jk4NgiIizvpAp
 EsHc01nvBcgZZ94ooSqGJHaKThnYCCDLE5MzsMi4zTCGFnLtmuj8R2HE58zjY/JOAwm7k3vsM
 Sw0F/4dN3ev3KYugyJpB/3pS/SjyKZxvcGMXQ4HcRwbhcgUJSwGoLxyQA6G8l4TIj42IkSUkT
 Cz6t3jUb6oSZkgcdkWaKqgi7zKQ0hTSGGASKgI/EVP8ECKKKsKIKZ3rrdlo3PTxGBqKW78d98
 DWTlpiig38SFkivZCzJIRChdZ/pVwLBB3ZOYFdmMDJxo28cNe6WarHg90aT0nnY6JRVBXhKT5
 Nejg0PDxdxx+BxqKTbo1dR9jM6U=
Subject: Re: [cocci] Input: usbtouchscreen - Return directly after a failed
 kmalloc() in nexio_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1425
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/d224c77f-048a-4fb4-b582-492fd428e270%40web.de>

>> The kfree() function was called in one case by
>> the nexio_init() function during error handling
>> even if the passed variable contained a null pointer.
>
> Which is perfectly valid thing to do, like free(), kfree() accepts NULL =
argument.

I find such a function call with this special parameter not so useful.


>> Thus return directly after a call of the function =E2=80=9Ckmalloc=E2=
=80=9D failed
>> at the beginning.
>
> This is simply a matter of preference, the original author preferred
> that style, I see no objective reason to change it.

Would you ever like to avoid redundant data processing a bit more?

Regards,
Markus
