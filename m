Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D268AC27C40
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XRx+h0BiophZtWCWEEVT03c7jIfZ0Q/CRHmflwYwoQo=;
  b=VbeCQNNCmOr//CEo+wqAR+5/6TXJ73I+cJIBeqRFIPskm6H9sGqFxQyq
   IbEHv/GTuCxIFw+VDbvNUezb7T0GX1pcVllm0sIpWKfiy6/k+XhHFrv0H
   kYnnoJozjjP/aVB6XMhU41U+nUSMIU8aSkzIr8myKXAB7mp92o4koHgN1
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137978270"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 22:04:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5360AE0CCA; Wed, 22 Nov 2023 22:04:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63E6BE004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 22:04:43 +0100 (CET)
IronPort-SDR: 655e6cd7_Aezk84we+AWsIYD5vouYWVvbcJhtbao5pLQz3X+vD1SnK/R
 mTmvhy0wY5YAfVagkZHlbUW5UqepzE4Ar4svhjg==
X-IPAS-Result: =?us-ascii?q?A0EYCACPbF5lh07ASNlaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FORMjCEO4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIR/AocpAh4HAQQyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4KAQUnhWgNg?=
 =?us-ascii?q?lwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJw8LGgImA?=
 =?us-ascii?q?gJXBgEUAQGCfIIqAQMOIwevO4EygQGCCQEBBq9VHywiVoFfCYEaLogNAYVZh?=
 =?us-ascii?q?DUnD4FVRIE8C4JHMT6EQ4NbgmiDboU5hi2OfF0iBUJwGwMHA38PKwcELRsHB?=
 =?us-ascii?q?gkUGBUjBlEEKCEJExI+BIFhgVEKgQI/Dw4Rgj4rNjYZSIJbFQw1SnYQKgQUF?=
 =?us-ascii?q?4ESBGobEx43ERIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEg?=
 =?us-ascii?q?TYFDR4CEBoGDCcDAxJNAhAUAzsDAwYDCzEDMFVEDE8Dax82CTwPDB8CGx4NJ?=
 =?us-ascii?q?yUCMkIDCQoFEgIWAyQWBDYRCQsrAy8GOAITDwYGCRsEDgMZKx1AAgELbT01C?=
 =?us-ascii?q?QsbBj4CJ+wqNAeCMYFfgWAMnyMGEy+DbpM0DgaST5hAIKg0gWoEL4FcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZhBKPR0A1OwIHAQoBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:Cv/tTK1R0ZxPmGXJ5ZJYOQqjBGwkLtp133Aq2lEZdPUnSL36qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:HRdQMG/G4yUSxjGfcAWVv3AbFsR8T2Xw8HDRB0iXKntqbOW3WUDFrQ==
X-Talos-MUID: 9a23:YecJ/AiH7CB+EAhqb32iCsMpNOZC+uOqS2E2uJgk/PmJFQBTZjTDg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="72302300"
X-MGA-submission: =?us-ascii?q?MDGxDahh/avmkZmO8U3J/YiLUQujjedohHjEMH?=
 =?us-ascii?q?cBT0PKM0pkzB+Hp+gLYR8JpBu3c7ujXdvq4nMnson3tXrsdOApLDOqAU?=
 =?us-ascii?q?RcG6BEyl3Gpu744sb7PfXHQ7tfu4VJtKAP+4ZH1drvJlaAotwrQO9z4L?=
 =?us-ascii?q?EYEQ+tQxOEWdy99kKjFfvN1A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700687062; x=1701291862; i=markus.elfring@web.de;
	bh=XRx+h0BiophZtWCWEEVT03c7jIfZ0Q/CRHmflwYwoQo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=LyKYGAFfrANhkRb8sTLUkc3jlH/tks0k5AaortvcSVK8uaDTWxC80H+PN30WC9yW
	 znLKkPFmHD+AWMyXGe23F94Tx9b3onRrBwElWySsjdZHEqCFxEUE4wvFiB68x4s8+
	 iXTR/CC8ta/vHTrsQh1AO/kvwb9vkweXrpEWPoSggdi9avpy1+vmvQnvtTx2q1Zbv
	 sxjdZ22wjQcq6LpoMGV48gcDFWjELXyXR/It4Kp7LJofYQYO9xQGWJOUPtXjH8fv7
	 e6KHj625414vR0+pDorJ93U3hGDU8JN6SsXKRPhMXxhVa0gLuzNXdux4pJVfCG8v3
	 IydiJBBjHwiDj+VkCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qd5-1r0hKF1Y2P-005nY7; Wed, 22
 Nov 2023 22:04:22 +0100
Message-ID: <d01a8b90-23cd-4058-b400-bc2c7fee1639@web.de>
Date: Wed, 22 Nov 2023 22:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8s99T7f724Jh8Y7AqIIPixaX39TD3Bh6ela7xFl9+5pRDjaR7X
 GsiQbVB7SwhYNpDHsYadnBHS1s6OmHR2uqekvBQvzxEQIL0Jhhf1ADiytjSMC6NnpL7FBQE
 CPUSHHGHJp+G2EyT6bG+6bgP+DpIlu+8c3UT7Cn1l5FPc+UAHpANP0mmwVzEfv181RZ6Vno
 g0QA6wcmtCHCMRTC73sbA==
UI-OutboundReport: notjunk:1;M01:P0:KE6e5w0Sr9g=;0gdGBhtAd3NebWVdv59EZ++N8zN
 XH6sumFQk7LxE/Tom0B2GXz1XKZRrdFIvUWuZCl+xd4oHy5IeHtECn3nBBeEEkNQj5rN34LmV
 4ipABhfs2zMNxMI8hsOstkkOyyrEOggorYoFhhTgcDsJ+fa8aZln1n1HWXK1oZyGcNm7bEgJm
 5jh8t8q5qsnFRM23o1vhDcwK880TOLHKRLToeJXpZeH1JaN7zDdMqSEORwKO1FadlMmleH5x0
 9+4LfgzZogFA50jz/vog5gz0vUCxLsLx2Wg/gaIVja+e0Zhjuw4zpHkGfPvCd0EeEXkF+7/cH
 VeEk0MIYNMlNYRjNfElpONw6eFt+szlXL2az4rrUwmg+5j2CVOwBEdyDZOJDaOowRON2C8BDp
 9XP0x6SnwiwL958nU34L4jNJbgDQLqj6q/iw8nuIMph6AMkUrvufjtDFp/ogaoFeKwfiHgAYE
 bxn7efHmsTC0SWgEu8UIQydTqRZYO/u/wQlKoq1ElDBiFfD8m9r9WQmcSKouR5xGllMXME/kg
 yK5N1xY6Jg/O7/WX8Hj4FclGJJoN0BuisPvSujBAHjTHez81Nd+mJNEvS2+Ye9scThAIz0O7p
 faZEoeUScaNTj9sGl5PPVhDAWByvsRH++T6UB4m7sRlo5Ha000r6iUfLtPxYY084SyiPbURRA
 0nzpbHNKrCrGyXB9c2jxSyRlHMNV2XZTCOaNDHa8R8nDxmNNMozbQXJujDwmPibxRzQgLMqPB
 ovEQUDgbcfrT+hNZGmagEQewA4NhMNcha640oYgpgBA91Zrw4M6LPfjqvmUuz6Vht+hH8d/k/
 mBC0dSB7aT9fTX84hc6RfvCJ85J6R9dM7F6i0PenFP7tJMEOyK/GMWV9wnYoWAf07Ivghieqs
 NUTDWNg+Rs6LQ3Bb/xWj7aw08SlTa8A2enKe0FHqksbvFv3ick8l+v6ps38v+IpVut+ZkGrky
 BWPx7Q==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1312
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/d01a8b90-23cd-4058-b400-bc2c7fee1639%40web.de>

>>> If you don't want any subsequent ifs, then you can put ... after th } =
and put
>>> when !=3D if (...) S1 else S2
>>
>> How do you think about to count involved if statements?
>
> You can put a position variable on a matched if (if@p) and then use pyth=
on
> code to add the length of p to some variable.

Would you like to explain your development idea a bit more for the usage o=
f =E2=80=9Cthe length=E2=80=9D
from a position variable?

Regards,
Markus
