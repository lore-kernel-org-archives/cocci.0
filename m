Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39B7C04A95
	for <cocci@archiver.kernel.org>; Fri, 23 Sep 2022 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=J5gAKEnfZkwg9Bs+lA59OsL1HOcJzBZsMQgKLou39uo=;
  b=Bs06xINopbRBgfOr1ILmRMk9CzDCpEbvRd1UzwWTTMNkor9skJGC9DUO
   /j4OFtDvP3P4bHs5rt7X4aPOcW7PfxB4MOs0tMUp7vntCbq0HX7YOAOcv
   w3W3YmdEcUP96CRnB4Ew38d7Egy3S3UWwHJ+9J4Mm12oVXzoZ++Lb2jHU
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54287643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2022 19:47:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DBE1E02D5; Fri, 23 Sep 2022 19:47:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D295E0090
	for <cocci@sympa.inria.fr>; Fri, 23 Sep 2022 19:47:19 +0200 (CEST)
IronPort-SDR: 632df125_QXoS5ggMRkYkuTxLUIQGnVSBbODy4U4y+SJjal4NHaOOG6O
 sFnNND4LERSSp9ilLY2/CXIrhcPWS2yw4UYgWLQ==
X-IPAS-Result: =?us-ascii?q?A0AJBACG8C1jgAwR49RaHgEBCxIMQINzgVcuBAtFhE6QZ?=
 =?us-ascii?q?i4DhCaHF4clhFqFaYFoCwEDAQ0/AQIEAQGFBQKEbAIdBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEaCRcHDg4HIoVoDYI1KQGDZAECA?=
 =?us-ascii?q?gEjHQEBESYBDwsaAiYCAlcGDQgBAYJ5gm0BAw0jB6w2gTKBAYIIAQEGhE4fL?=
 =?us-ascii?q?CJSgVwJgREsjy96JxCBVUSBPIMDPoQGPoNWgmaUe4QiJgQOAxkrHUECAQtCN?=
 =?us-ascii?q?BgDFAMFJAcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICTTYIBAgEKyMPB?=
 =?us-ascii?q?QIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCCCYXBxMYGxkBBTInEAkhHAoEG?=
 =?us-ascii?q?g0FBhMDIG8FCjoPKDFrKx0bCoEMKigVAwQEAwIGEwMDIgIQKjEUBCkTEi0HK?=
 =?us-ascii?q?3MJAgMiZwUDAwQoLAMJIR8HKCY8B1g6AQQDAxAiPQYDCQMCJBNIdQI3ExUFA?=
 =?us-ascii?q?w0ZJggFIxcdBAg8AgUGVxMCChIDmgGDKEo+HJJmrw80B4IXgUSBSQyeTgYTL?=
 =?us-ascii?q?oN2jFCGIQ4GkgkthwkTj0GnaYF4I4FbMxokgzZOAxkPjiCEJYotPzQ7AgYBC?=
 =?us-ascii?q?gEBAwmFRwEBhRgBAQ?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUam+8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GPxod6tg5zlqo7yIGGVvSpMD7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,339,1654552800"; 
   d="scan'208";a="54287613"
X-MGA-submission: =?us-ascii?q?MDE7U23VxYjp+j5t49toZITfj0m1M2mlSvOpOy?=
 =?us-ascii?q?CETdS/nCGbGIMBYp+iUF0m7DAp23Vw8hpgZYw6xBuRO9Fq09M+aC+Cjm?=
 =?us-ascii?q?kHw2apncisgbZqA/x3IAObraXMlVl402TjV5DSrk+U8LUH0taEMvpBsx?=
 =?us-ascii?q?VQGoCSSW9/b4XQ2MAOzive0g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 19:47:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1663955224; bh=gmiSjONkxVsAqhtDWaMmDpN5GoNjgazx1a7XZW95cm0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vEmTayTDNU+ZkDF9fWf8ayxLx1ny1Exje0dKIYYJpdxpOGKkAbFnpwo1xkZsqzebE
	 mixbjArt1l+PIBH3+bMRj4AK/QUXJUnnHHT7mPuYNie0QB1tae8/DwtXKdXJRdc2iI
	 t2Iff1Eaumqlc7JcAchFg/ILOlYneeO/ykVkZP0JCbGMyvuUuVVZUiU7XVjL0UbJfd
	 xU+xu+XVMOiI8L3eL1w/vyall+n+UdbjaXlkiUPg40yRgKCTXVrh/Zq4pVMerKJEUO
	 zhw3peoWt4GAqgZHM8pv600GjBJB98CANQq2x4iNalrVXK8vEp0X06RgrIbYSiUdUb
	 NGIHoUXSdAVVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1oPwP92s9v-00CnJ7; Fri, 23
 Sep 2022 19:47:04 +0200
Message-ID: <2a8b2d3c-26cf-3aab-34b3-1ba402740111@web.de>
Date: Fri, 23 Sep 2022 19:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
 <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
 <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr>
 <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
 <54938aa-3629-2bc2-edc-cc1b3246866@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54938aa-3629-2bc2-edc-cc1b3246866@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cjylT5k1HTnxderWP8N8Kuw3yX63DZCEi5cARNv7z11vpX+CxTX
 PUB/KesmJo5iB2E9GC4EQbMNEuWqMsMNfnsHGL0V9pgJ8HiGV7+Nmv8aacro3z+CV0Kerl7
 FQZKX6pGdIdqHDCYWXOcdIvi3GX7sKu45U42egICswMqq1G3tkMT4t+CabzGAQqh6IsTH9H
 l995Mgrs725+03djy4DEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fvMP9ThdZ4I=:FxfQy8RF2811hcbYuOUTDw
 Un0Rx23UGieRXdFm2DwIQSAE5gg3Ti2EZGl0Banb43ECvba6L599qzM+01ATex0qV8fWWJqCt
 8EDEa3ELcwRTdZK13ZaOn+Er/xkFbbugYpfyP9o/LzoNcYZaibHI8iQ6pOTKDV18XLRuKWg7j
 +kWT9aAqqJzegPBx7UkrFINL+0+po1gw0rf0GkBQhakdPhP0bZZCIH0sRUHQrdCgYCcCWSJRp
 xjJvErXe4AVbGkkrrEhTNu6ihfDKzO2PWJgFnP/M+KJNWpXgUwLAcei8AbySKbScBeDlHcEdy
 EfYtVW4B8d6FxWuDK7JBvu0v7aL2RF7Z57wJhwoyYABX5pXQRjrQ4fFgftsyDbhprNRNK8KLs
 WXIIOgmOW07jgegP3iULPwCYFTvzDrew0blutP8m+Wa4FvA69WaeG0g0acEz6N1UZDl6v9bZB
 PQlf9lfgCp3soY7hK8JHr8sPx9XvPRjz1dE7ekHNfTsrlfLAVmdeed52lbXiLJIyFKLvLxyty
 Qa1dv3dT8BY3Pgsefk5K55UPR3qq7pc6uHVkIvpESgYhMZ2E8mzGdraEBEMfHSmAxtI0X4TBO
 QLyPk7u8SO4igs3nq+X5WZRYdqLfXU13BYz+863vLnhFU45F2G9tAOaJdSWUVyUmlcta3tgz5
 WTEgkF2wY82vHHeV9tV9yjA5E7LcwmiiHsGPbHDfDW9iLACLlKSD4iYv+X/IZLSSfXkU84ZEd
 5rZN1AAEHozhM9umuMtny457mpGWXyijOixGeE75vv1G7Ufw43khB4R1W+nLwqRS80jwi3UO5
 haSOL1GBYE3Ar2pG9sgrbf1MlTEAEeq8P4uju6jl/jBxWHuCtnBu0K92VnH0F1W6NQSDDH8EV
 y4uNBAgjIXzmnMbM3/IcFMYg4Bq4qgxtoqVQGNMxNOsUXME8SpCP4f+AKhPg2YOLZlZF6csW8
 ZSMmWwNGdJxJ9nQpVJhWDf3KcP17jiDcIklscKIT/+aXchP8aZeX6BCX7aILYS1sdxwFIzdi1
 7jUhYHatoseA7hfuwutOS8iSR8eIVS6lLz1Q4MhCPRo8PshMW6+2Pd76yDgpoD7SCHnM/nNNM
 /qW9VFqOun+yKQD5RvUIfiFE7hEhGk3nMWtHdyO5ywIlQI2TjVBvBc0ftb7FlHGjV5UFlm03n
 wKl2piTZvrLPq33XOw/Hm5jXqg
Subject: Re: [cocci] [v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 578
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/2a8b2d3c-26cf-3aab-34b3-1ba402740111%40web.de>

>> # How do you think about the handling of multiple members within data s=
tructures?
> There should be no problem with this.


Would it be relevant to use the SmPL construct =E2=80=9C<+... =E2=80=A6 ..=
.+>=E2=80=9D?



>> # How much does it matter here that curly brackets are used for a propo=
sed SmPL constraint?
> I have no idea what "How much does it matter" mean.  {} are used because
> that's how struct types are declared.


Please take another look at mentioned implementation details for
the clarification of such communication difficulties.

A)
position p !=3D {r2.p};

B)
position p !=3D find_member.p;



>> I got another development concern for the presented algorithm.
>> Why is a data initialisation function call searched in the first SmPL r=
ule at all?
> Because he wants to find the fields for which mutex_init is already call=
ed
> and to not report messages for them.  That is the whole point of the
> semantic patch.


How do you think about an opposite source code search order?

Would you like to search for function calls which require initialised
data structures before any additional source code analysis?

Regards,
Markus
