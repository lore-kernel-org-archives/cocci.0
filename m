Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2912C00140
	for <cocci@archiver.kernel.org>; Sun, 21 Aug 2022 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=A1jIK4KzAZi+3CrWQE/+sDGcBPp0WW112GOO5mQp7M0=;
  b=l+efEvSWtNhWqL7FDgIgJ8UGeZJMRORWHwG9kARkSep+wx0FIXqWe/Dz
   V/iOr/btfolHYlXtZC0ERVTFj4fPQSSjVC9kLGFBh03OoxpMMsT5cX2Js
   gtcz288DZ81mqpWmVgNq8uggCCJ6+pxQ9M8yvRaar5A8vo+nSNH2SIRCJ
   M=;
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
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49372645"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2022 11:46:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4088E0AC3; Sun, 21 Aug 2022 11:46:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 992F0E0385
	for <cocci@sympa.inria.fr>; Sun, 21 Aug 2022 11:46:43 +0200 (CEST)
IronPort-SDR: CHfew6Vu3LbA7oj8icBVyPKZs4fuTzqxE74tzblDvmKpRr3UsvlCEzvq4n1DRBMbaxHaPs97Gx
 R8KKVgmXl1MSQZzf43jCLQJ5FabOsEPQj2Aw6yii6Fgoq4ZJFWStL0q+6diNnPxKPQATMuvT2O
 S0JKY2nI+cLC6DfqbEZmktk8TtbsT8kco8VnlWHlYyPqs+cw1e/aqyzrzCqjxt+r75uUTXaFeA
 MoToHH3iBkIcdUbw4vqqj6qOLvsQ18lS47mcyugWqGKv2VBBIAPM+6XCSUAa/N5Kfr+AKw3gtt
 bUkXR7YDUiDxdFl1WKZHy2pB
X-IPAS-Result: =?us-ascii?q?A0AUAgDI/QFjhk7ASNlaHQEBAQEJARIBBQUBQIFPgiSBW?=
 =?us-ascii?q?C4EC0WETo5ngiiEJYcShyCMKAsBAwENPwECBAEBhQcChGECHQcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwLCQcICgcOEAU2Bl4GZ?=
 =?us-ascii?q?ASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnmCb?=
 =?us-ascii?q?QEDDSUHqHyBMYEBgggBAQaETh8sIlKBXAmBESyLMYMqeicQgVVEgTyDAz6IG?=
 =?us-ascii?q?oJlmW4mBA4DGiseQgIBC0MFCAkXEhAQAgQRGgsGAxY+CQIEDgNACA0DEQQDD?=
 =?us-ascii?q?xgJEggQBAYDMQwlCwMFDwwBBgMGBQMBAxsDFAMFGAwHAxkPIw0NBBgHDAMDB?=
 =?us-ascii?q?SUDAgIbBwICAwIGFQYCAk45CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCBgQEB?=
 =?us-ascii?q?AQVAhAIAggnFwcTGBsZAQUyJxAJIRwKBBoKBgUGEwMgbwUKOw8oMzU5Kx0bC?=
 =?us-ascii?q?oESKikVAwQEAwIGEwMDIgIQLjEDFQYpExItByt1CQIDImkFAwMEKCwDCR8fB?=
 =?us-ascii?q?wkiJj0FBVs6AQQDAxAiPQYDCQMCKTsCngsZgQqiD559NAeCFoE/gUUMnj4GE?=
 =?us-ascii?q?y6DZJMBDgaRe5cHIKc/gXiBfjMaJIM2TgECAQINAQICAwECAQIJAQECjh0Zh?=
 =?us-ascii?q?AyKLT80OwIGCwEBAwmFRwEBhRMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:9FOx+600H0yTi624ffbD5bt3kn2cJEfYwER7XKvMYLTBsI5bpzEPm
 2RLDW/Vbq6DYDbzeNx/PI+z8hkCusDSmtJmTAZq3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywIbVvqYy2YLjW1PX4
 IuryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt4xt4
 8dNu4KtcwBzI4/FvM1CV0lpOD4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBpaAoWycXp
 KZed2BlghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrGfyVu4ACgWlYasZmFvjuN
 4lITgVUS07+ckNmK00yUL4VtbL97pX4W2QF9AzM/PRfD3Lo5Ah4z7HpNPLHe9mAX8wTn0CCp
 2uA8X6RKhodP9ee4SGU92qlwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGbiR/lNK
 0IK5xAp97UQ/WiCEd2tbjan9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVscgOteODKp+drHGZ7h
 wThc8fBVGA+6eX9pWe1rO/MxQ5eLxT5OkcuSEc5oeYt5t7+vMcsgxiJQtsL/E+JYj/dSWCYL
 9Oi9nBWa1AvYSgjifzTEbfv3WvEm3QxZlRpjjg7p0r8hu+DWKarZpaz9X/Q5utaIYCSQzGp5
 SZawpDEtLpUUMzcxURhpdnh+pn2t55p1xWD0TZS82UJrGXFF4OLINwBvmokTKuXGp9VJ2+1C
 KMshe+hzMYOYCXzNPEfj3OZUopzhanmCdn/UP3IJtNBCqWdhyfXlByCkXW4hji3+GB1yf9XE
 c7CLa6EUChGYYw6k2Leb7pMidcDm3FlrUuOFMCT50r8itK2OiXKIYrpxXPVMojVGovf/V2Jm
 zueXuPWoyhivBrWOXWLrdZPcw1SfBDWx/ne8qRqSwJKGSI+cElJNhMb6epJl1VNk/sHm+HW0
 Gu6X0MEmlPziWeZexqHYDZvZeq3D5p4qHs6Ow0qPEqpgiRyP9zwsf1HL5ZnL6M68OFDzOJvS
 6dXccu3AsNJFmbN9QMbYMSvt4dlbhmq2VmDMnP9MjgydpJtXSLT/drgcle9/SUCFHTlqsY05
 bGtj1uJTZ0GTgVkLcDXdPP2kwLv5ydAwroqUhKRcNdJeUjq/Ix7EADLj6c6c5MWNBHO5jqGz
 ALIUx0Wkun6pdNn+tf+g63Z/ZyiFPFzHxYBEmTWseS2OC3d8jbxyINMSr/RLzXaSX+y56ioI
 +lYlqmuPPoClVdMkox9D7cykfNgvYSy/ecCw1Q2BmjPYnSqFqhkfCuM0/5PgasRlLVXjg27B
 xCU8d5ANLTVY87oTAwLKAw+YrjR3P0YgGCLv/EyPVm8+yJ9uraKCB0AMx6JgS1bDb10LIJ8n
 bZ/4pFLsVTnh0p4KMuCgwBV63+IcC4KXZIngZdGUoXlvQwmlwNZapvGBy6qu5yCZr2g6KXxz
 uN4WUYDu1hd+qYGW380CGSLwudXw5gD0PyPIJnuOHzR8ucpRNdutPGSzdjzZhtYxFNL3oqf/
 0B1YlZtK/zmEyhA3aB+sqPFJ+2FLAKU8Ar9xjPlUYEfo1aADgTwEYH2BQpBEI31PY6Rkvi3M
 Yx0EFrYbAs=
IronPort-HdrOrdr: A9a23:FQaxzqvVAeEhBiHXKSjww2eI7skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="21767256"
X-MGA-submission: =?us-ascii?q?MDFcNmgJoAY2wGHk+Waqo4yihM/5WUpz97rjCX?=
 =?us-ascii?q?IRFL7BKILNAAfh1RXdWPr2iXagKSHLssE6KiddUWc+g41imC66QWjlxx?=
 =?us-ascii?q?ydnmW4aITNSRgmd5ggy707aRekPGpVw7cnMb0nxA2SFONVJdMaCTJxfb?=
 =?us-ascii?q?T4sLOTgIJB+dTlWMugh5QAlg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 11:46:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1661075201;
	bh=A1jIK4KzAZi+3CrWQE/+sDGcBPp0WW112GOO5mQp7M0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VAWJjVFZIocOppQLPtaIxMGqTbx6mhtIj57ZHWQulYpX3AxhVaPQ/zEeqGlJmUWKz
	 LftRj5HFIHMERcgP6RtbnONY1Z7safoMG3vJc2PdPo4HVLkajIgg9L+YOdJVQVvCcH
	 U7xtbhIxnoiiiHYNW+xCYZdllWqmY4y2L6AymlMc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.59.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1ojyFX219e-00Kfn4; Sun, 21
 Aug 2022 11:46:41 +0200
Message-ID: <8049e567-0aca-ada9-54f2-557dc1083ee3@web.de>
Date: Sun, 21 Aug 2022 11:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Jakob Koschel <jkl820.git@gmail.com>
Cc: cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
 <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com>
 <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de>
 <alpine.DEB.2.22.394.2208211108400.3263@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2208211108400.3263@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Uc5S2BcTZQB6o7Kj4fdaXM/9I+YLtZXxodvD+LJkU5p2DU+rzCE
 s7WvCM2KyKtjZyBQEf9duCbmT3URF/3ktd3v/kVQH29BxuH12iRKWBW8bAOLg94FoLBxEVn
 5r/friMZY4XsfMrFeWPOnIwJSXDy9t4KfgtZITf35jXCe9xXxHrl9SojJxMV9VgNgqPhXRU
 BgRPJBlMeepdgaBmywVFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCz0qQylQ9k=:orTFy8ehApSxOzpIpCgtoK
 DDsZEj4dKHG93mWjKeaNGtF46kg3o+VlO94m8Ft+NNnr0FbenWHaLZKAefzbllaZoiwnqUs0b
 O/pJ6k8KY3zJnTYhtOFAqNslJ9/o56IgWZArslxK0rLfGT2OjBbAjxyz3ztn+ZmcDr6QE+Ofh
 3D1I6U6WNTC01OloeG6f8lHBiuw63lk+8W6EjvBjMEmCAgHU9K+o5Dfl8Vy/kVdiAcTGfAu36
 frSM/qTy6kaYnVS8B8uUVCKxPCpl65VboR4Bv5ECwtgS9vYoF4xKntyfLyqm0Gjumm1UyfOB/
 06VV7xA7OfLJEWIrArLiGSy+yXygUV5JIOBk9MILS8ltOw5KrSnSihswFodcqAweLXD1nw6/1
 1NfYmU2Zf5YSINElFBg15den1wp7Z/jJd/iavZZk33iu6R6nR35C+anU/6kr3fGfEuO1FR9v1
 8fwn9JNauMAtjuJaIqEonu7Jaytbq1sll7RZBl121Uby/qBwkhFCg3niZpgDf9Qf/BdzPXmIu
 /gjMlEjrnp9qaQkfC9Ydiwm61R2GEzFhqC+NxuYBMbRP3Imub4TuGGT6uJ6d6sewS0Fyf1sr3
 oTWWWnRWlBp0I5THgCeRd7yUTFEGQqu2IvV744eUAf3IApytGxbaj1BIXcEmx0sn3+bqg9L9N
 z1QF+zPDJQgFX5f7lmMXEsSry9jtbHb+mVdEcoems5U2JtmEaTeq3xi0JQsm9TnbLzD5BOzPV
 8Lgj4ANOsPzj6wy7PLg0BjbsGUgs9Xcu3qJrKRURjG8kmJ2usxCOYFqqQwRLuX/3wpoOCc7na
 I2zlUYeE0XRUkHjkop2WR+dNRxV81FuoHRIHcoe9l2BtuC3BwFwjX+H6GOek0rOtDT7lPbdnq
 ZLL12u2RSyVvWHDZ4BhNcVW19f5fMg31PbSWn96XW2wdp7GYm0N6HZ+ohp1oQK20uVNKmGEV0
 uUXtac+xFry3p7CEaUIJgL+MJS4FYzlo2bbzNOps3i4w5uATPbG4BgGaZuO+trsm5LgEtvOXi
 Uo3Rjs2ScKhvy7dZntziEv8D62Mz8Ijj0aPekYBFb8HarUfy1C70LLcQq0sQr80demAlSnUht
 7MhhZuMQ1O55YxySulaHX5Yuy3kQsLrAX8z10grA+96uzjfiZREIk+/qA==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 528
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/8049e567-0aca-ada9-54f2-557dc1083ee3%40web.de>

> Despite the bizarre way in which Markus asks the question,


I find such a view also interesting.



> the ; at the end of the comment could be a serious problem.


Thanks for your wording variant about the usage of semicolons.



> Could you repost your semantic patch and test code?


I imagine that a semantic match (with the application of SmPL asterisks)
could be also helpful for the desired understanding of the discussed
transformation approach.

Regards,
Markus
