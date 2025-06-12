Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683BEC71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=APZOXjECcKxUksmd/sNY9sgNAxEMEPXyb6RUNIXv86Q=;
  b=Q6u20YKK5QNCxIlF2I1vcGV84VS4i+amA2hW20E5zg0bpsGn3hZv2TGH
   Oci7ywIyn0sgj9tCEGYBcriixTGkH3ihsQPZxkjBjz+x74Ls0lIknwE3a
   z0ACm+SIqnYdO6OSdQQCvEkJk2FaaEmm4cDj0KdZsfphcq+slHRRITimm
   A=;
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
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226930860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 18:09:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9277AE0AF1; Thu, 12 Jun 2025 18:09:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9BDDAE0157
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 18:08:57 +0200 (CEST)
IronPort-SDR: 684afb99_zchoxOhYz1HIAdCfuzhH3SaU6Hlj5eIpIoKH+FQiGQufY08
 7ipY663zgb7P2W1Dq2O/Wl1IJ51jw5OsZ7gZsAw==
X-IPAS-Result: =?us-ascii?q?A0EMAAAu+kpogAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAQGCQoEAWjMEC0kDhFKPUIZfmAaBVYF9Ag8BA?=
 =?us-ascii?q?wENSgQBAgQBAQMEhDpGAotnAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBOwcOCjGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDTpEAgEDIx0BAREmAQ8LDgwCJgICVgYBFAEBgn4BgiEBBhABAzIHDbAfe?=
 =?us-ascii?q?oEygQGCDAEBBtpeHywiWIFlAwaBGy4BhWyCYwGGJwmEMycPgVVEgTyDAz5pg?=
 =?us-ascii?q?WEXBBiBRoNbgmmCEReBFoQkhCuER0uCX4Rzi2tSeBwDWSwBVRMXCwcFgSBDA?=
 =?us-ascii?q?yo0MSNLBS0dgg2FGR+Bc4FZAwMWDwGEAhyDQoEjhEkrT4MigX9MGUGDYR4Gc?=
 =?us-ascii?q?g8GR0ACAQttPTcJCxsGPZh/hSqBTUYollKvXjQHgjiBZoFkDIotlTsGEy+EB?=
 =?us-ascii?q?I0NhjoOBpMCLodlkHEijWWbMYFvBC+BXDMaJIM2TwMZD44hDBYcg3WEYLJGQ?=
 =?us-ascii?q?TUCAQEMLAIHAQoBAQMJhUYBAYhhggaBSwEB?=
IronPort-PHdr: A9a23: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
 PLmpZdEWVZzGv5IUyyN+fQdLZ0xUj52ydam
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:p6Wj0qwY0Dp3Rpo9aWsOKrPwAb1zdoMgy1knxilNoH1uA7Wlfq
 WV9sjzuiWE6gr5NEtQ+uxoW5PhfZq/z+8Q3WB5B97LNzUO01HYS72Kg7GSpQHIKmnR8qpz2a
 98b7NzErTLfD1HpPe/zg39PdhI+ra6GWOT6ds2DU0BceinUc9dBs5CazqmLg==
X-Talos-CUID: 9a23:4/uG42DcBCy5IsD6E3FozVcxQ+E4SCLy6lyJIEiIKmAqVJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A7X7ZSQ2rIKpgUhpc1WeVRD89oTUj8qegVkNXnLk?=
 =?us-ascii?q?6m/KBBwt7KTuMlSqJa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226930846"
X-MGA-submission: =?us-ascii?q?MDEJAREomhhuueYKH0rj+jDDSGy4rjeGSaH9ao?=
 =?us-ascii?q?U+kIENpb4IaXXgoLWMadV6U6qJBSdm51xSkRTnaE3moO1rFmcKeYQCrY?=
 =?us-ascii?q?/o1fIuV1eQ/GMA4Id9FFx8E9kFf64FEHFeKso7z2Oh3sjeBTlMwH6vq5?=
 =?us-ascii?q?ndRlMpe4u0kKE0gGL+VV/8FQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 18:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749744532; x=1750349332; i=markus.elfring@web.de;
	bh=APZOXjECcKxUksmd/sNY9sgNAxEMEPXyb6RUNIXv86Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dw2otF2zTfCBY0S/lRappzkh7U77HXO2T42PdaJ34PFKOki8nlFcDcGT+ZL8deeW
	 GtZm0y1v1JuW9xPueJ1K/oqwL03KdCzCmxImQFV+Ko3iUNZMABxA2VZNQUMIQulBo
	 USREmCgVIC/HuCeEt3aZG8QoXjNYHPRVFbV0WVvkZTQgzJ0R6F2mLNCatQtnKojhi
	 AZazCjyKdk4JbmliT/IrIlu7mzVVpOrAQuj1fdN0dpgmv4tZfmGZrzCPxEhxjxCw0
	 FeftqPEFLFfvuXnR6Lhc/q8ai7Xa4gNX2tVsNpAYPmbcBzfKAHRg09/fhyxFS8jzt
	 zXltv1vGcdg0qa9BiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXZh-1uYEfw3amB-001XEi; Thu, 12
 Jun 2025 18:08:51 +0200
Message-ID: <42bc5a8c-1b3d-46cf-a8d8-1b54ebf5ecbb@web.de>
Date: Thu, 12 Jun 2025 18:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
References: <20250610174521.12294-1-eahariha@linux.microsoft.com>
 <00e40c21-4797-41df-b082-318f474f76ae@linux.microsoft.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <00e40c21-4797-41df-b082-318f474f76ae@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4yP38GzTqLlnhOK25hukdskfLeFwr8aAoul3NnAQ3m30MyraQF
 H+n3IxdhZU4b5qPYNFMOK7hxI3RJ5KLJ1IDTnU67OlbbTSmRl0wIcOOwniZgXVhOMg7I+/+
 xvY/7eJk1hZdHXkETQEbfRRlxGls4qIf0pVJwkm+wSUCILz3OvxLgbD7p6mrmXVXAe/HpOf
 KYnWj4eXn+9TKsh0EsRyg==
UI-OutboundReport: notjunk:1;M01:P0:wfm5OIaZZaM=;W91Zq/84ssN3wnkY8d0m9NaTwBD
 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
 G+Kkiki
Subject: Re: [cocci] [PATCH v?] coccinelle: misc: secs_to_jiffies: Implement
 context and report modes
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2782
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/42bc5a8c-1b3d-46cf-a8d8-1b54ebf5ecbb%40web.de>

>> ---
>> scripts/coccinelle/misc/secs_to_jiffies.cocci | 49 +++++++++++++++++--
=E2=80=A6

Did you overlook the addition of patch version descriptions?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.15#n310

Will any information from previous patch review approaches trigger more de=
sirable effects
also for such an SmPL script variant?


>> -@depends on patch@ constant C; @@
>> +@pconst depends on patch@ constant C; @@
>> =20
>>  - msecs_to_jiffies(C * 1000)
>>  + secs_to_jiffies(C)
>> =20
>> -@depends on patch@ constant C; @@
>> +@pconstms depends on patch@ constant C; @@
>> =20
>>  - msecs_to_jiffies(C * MSEC_PER_SEC)
>>  + secs_to_jiffies(C)
>> =20
>> -@depends on patch@ expression E; @@
>> +@pexpr depends on patch@ expression E; @@
>> =20
>>  - msecs_to_jiffies(E * 1000)
>>  + secs_to_jiffies(E)
>> =20
>> -@depends on patch@ expression E; @@
>> +@pexprms depends on patch@ expression E; @@
>> =20
>>  - msecs_to_jiffies(E * MSEC_PER_SEC)
>>  + secs_to_jiffies(E)

Please reduce duplicate code for such SmPL rules.


>> +@r depends on report && !patch@
=E2=80=A6

Please reconsider the condition selection once more.
SmPL code can probably be shared between the operation modes =E2=80=9Corq=
=E2=80=9D and =E2=80=9Creport=E2=80=9D.
Would you get further development ideas from previous contributions?

Regards,
Markus
