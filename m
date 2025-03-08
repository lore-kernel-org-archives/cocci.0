Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF1C282EC
	for <cocci@archiver.kernel.org>; Sat,  8 Mar 2025 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VeKmCYAft87hWIqVoclhm7gdJjEZaRwmbQrRYc4qoPc=;
  b=ZkIdR+0V3Az5zsP6fv/CJGf1ZoK3PsMxCanUzF/gUc9MxgUe8xBoJDY1
   qKBaGI2KUb25O0TL7ZcyKvoICAkL7plWuJ6GOo8sMC0bhY/jlXnqaEyHN
   3pXBZeQLVSr+GSWQOhqlgjKtAzpVfE9I5J2qAlOQuF5LpvfsK5anemzo0
   E=;
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
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="211875214"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2025 10:45:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A62DE0D1E; Sat,  8 Mar 2025 10:45:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E4617E0261
	for <cocci@sympa.inria.fr>; Sat,  8 Mar 2025 10:45:26 +0100 (CET)
IronPort-SDR: 67cc11b6_DGz6hKchUUhxFiNHM/VkBddKZQ3m09s/HQ2tlRvaAHZtDYX
 dze9t5mn9ld8DtSDRx/WZVigzahMA17rwSKRa0w==
X-IPAS-Result: =?us-ascii?q?A0HZGQDkEMxng07ASNlagQmBVYJCgVczBAtIhFaPT4F0L?=
 =?us-ascii?q?QOEO4c7h1OIdYFXgX0PAQMBDUEBAgQBAQMEhQACixoCHgcBBDYEDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBARCCboIwA?=
 =?us-ascii?q?QMOIwevP4EygQGCDAEBBtpcHywiV4FlCYEaL4VrgmMBhiaEPCcPgVVEgTyDA?=
 =?us-ascii?q?z6EQ4NbgmmCHBdFgniBA2eaAY8gUnscA1ksAVUTFwsHBYEpEDMDKjQxI4EjB?=
 =?us-ascii?q?TRBOoILaUk6Ag0CNYIeJFiCK2oEBYEkgjeEPYQ/gkGDEYIRcWwDAxYPAYMfd?=
 =?us-ascii?q?xyDTHY8hGkuMh1AAgELbT03BgMLGwY9oleEDQEtgQsSgR9SNzfGIjQHgjiBZ?=
 =?us-ascii?q?oFjDJ9eBhMvl0YOBpJ9mH4iqRGCAQ4SgVwzGiSDNk8DGQ+OOoQUxzJCNTwCB?=
 =?us-ascii?q?wsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:vkULQK2rhJZ2DZoosvbD5eR1kn2cJEfYwER7XKvMYLTBsI5bpzYAy
 WBNXWjUbPnfMWDzct0kYIjioB5Qv5/VmodjHAtk3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8h1aYDkpOs/je8Eg37Kyr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWyXl7edsJ204BKw30eBNDm52r
 uFJERlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAUrB5G9aaEv+Muo8wMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmQB8AjJ/vFsi4TV5Ch436r2AdTfQNKLVPtrl2ub5
 Wbo1V2sV3n2M/TElWrdqSLz7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDENDTTR+TjHC9nzE3XeBfHNVh9VC04/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQw6dV5rlrCr9+pQSOOBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmhm
 VhmTwBk393/aPLnMY3lpzgrZBry/PD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxJTHt79UVs3QynDRKAnoIF1Pz6nVWNE7qQE/d6TNCxzzpi/9FWytyGovfRYybK7ohxeyM
 BKI6Gu9G6O/zFPxMf8vONLuYyjb5annE9P+HuvZBueikbAhHDJrCBpGPBbKt0i0yBZEufhmZ
 f+zL532ZV5EUvsP8dZDb7xEuVPd7ntnnTuLLX06pjz7uYejiIm9Fe9YbArQNrlnt8tpYmz9q
 r5iCidD8D0HOMWWX8Ud2dd7wYkifChhV6Pl4ddabPCCKQdAEWQsQa2Zi7A4doAv2+wfmu7U9
 zvvEgVV2Xjut03hcA+qU3FEbK+wfJBdqXlgAzcgE2z10FceYKGuzpwlSb0JQZcd+tdO98VEF
 8s+R53YA9BkaCj2xDAGXJys8K1gbEuKgCyNDQqEYR8+XcVSeC3UyPDZfy/E1ioHPgyov+QQ/
 pyi0QL6R8IYZgJAVcz5VtOm/2mTj1M8xt1gbhDtGcZBXWnR661oFnDBteA2KMQyNhnz/DuW+
 AKICxM+p+OWgYsK3PTWpKKD9aGFLvBfGxdEImzl8rqGDynW0W69y4tmUuzTXzT8VnvxyZqyd
 9du0PDwH/0Wrmlk67MmPe5Q8ps/wN/zq5tx7AduRizLZmv2LIJQGCCN2M0Xu5BdwrNchxCNZ
 XuO3dtnIpSMBtLuFQ8ABQgib9nb78oupBvp0a0XLnn5tQhNx5jWdWVJPhKJtj5RE6stDqMh3
 tUamZA37y6Rt0MUF+io3w5o81aCFHgia5kcl4o7BdbrgzU7y1sZbp37DDT30a61aN5NExcLJ
 DOQtaufhIZn51HjdkArHiPnxttthpUpuTFLwmQdJl+PpMH3u/8v0DBV8hU1Vg5zzB5X985WJ
 U5QKFxTGaWC2xxKlfpzdTmgNC8ZDSLI53Gr7UUCkVPoanWBV0vPHTUbAvmM9kVIyFBsVGFX0
 5/AwVm0TAuwWt/62xYzfktXq/bDa9hV3S+akeCFG/W1JbULUQDHsISPO1VR8wDGBPkvjnLpv
 eNppeZ8SZPqPB4q/pEUNdOo6qQyejulekp5XvBTzIEYFzr9eRaz+wS0BWKfR8dvH8HOoGiEU
 5FAB8QXTBmv9je8nhZCD442HrJEtvoI5t0DR7DVGVA7o4av9jpHjL+A9wzVpnMafNF1oMNsd
 qLTb22jF0KTt1t1mkjMjtVOYVTgRd8IYDz9geOHy8QSNpc5qOo3W1oD4ri1mHS0MQVc4BOfu
 j3YVZLW1+BPzYdNnZPmN7dqXSGYGIjWb/ua1SyOqPFMUI//CtjPvAYrtVXXBQRaEr8PUdBRl
 77WktrI8G7anbQxCUb1poKgEvRX2MCMQ+ZnCML7A31Ely+kWsW3wR8i+Xi9GKNZguFm+cira
 AupWvSeLedPdY9m+0RUTCxCHzI2Kaf9NP7grBzgicW8MEEW1AifIe638XPsU3pgSRYJHJ/DE
 S7xheel44FJjYZLBSJcPcpcPb1DHAbBV5clJvrLjhvJPlnw1xnG8vHnmAE74D7GNmicHYyoq
 djZTxz5b1KptLuO0NhdtJdoswYKCGpmx9M9ZV8Z58U8ngXS4LTq9gjBGc5u5lBofi3OOFXQY
 TbQcC09BC+7UTksndAQJjj8dl/3OwDMEo6Ryv8VE4e8dCq8Qo+NaFek3jk1+G94I1MP08n+Q
 ezzORTM0tyZ3ZxjA+oejhB+bSGL2duCrk81FYvBfwAezvrQ7XjmFJCsIeaVaRH6Lg==
IronPort-HdrOrdr: A9a23:JF+2GK8/pxcw89mAu6Buk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:RYs78mGZm1C6/f70qmI5/WAGGOsJfET841zWGUC3MT10GYS8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ATr2QmQ9gNXm7uZJ9T4DR/TCQf+Nh7La1OU4Hq5s?=
 =?us-ascii?q?Hqve6PAFzeDOzpg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="111024333"
X-MGA-submission: =?us-ascii?q?MDHHmAuV0l2Cr6a4/RVeeHrhFGU8YFCgCNdUeh?=
 =?us-ascii?q?V6orPaWJCLnffX8qlQjJxDRfGg+c7Hduwk5GBV/kL41h6SGTogcT2FnQ?=
 =?us-ascii?q?xDvijQBZhw+M2uIUuEZis2FQpmswAqlkzZmGMMYiaLw69UZZWRe+P0D9?=
 =?us-ascii?q?1toFXLdE+9F7tS4BGnYY4F6A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:45:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741427121; x=1742031921; i=markus.elfring@web.de;
	bh=VeKmCYAft87hWIqVoclhm7gdJjEZaRwmbQrRYc4qoPc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M+mcRJ9yYNjPzm6icWpLM9W5Ar6bScpaVA2SyKAUOCFHz3zazmrhddE9pMooxW+d
	 duJ2BT731LY2/JfsG5K+mwJ/yLnvlgOMSwsYtRCpyJAJNKHlzbSNKKTOdsOOYAL8o
	 N4hg0Wzi1aPf2N0vpFoYkPeMmnyk7hv0lJTBQUAL5YvkXQvgVCTVXh2zw4wPwnBp1
	 YI+IxXzZgOu/YGa/kONJRBwndhow8qY5QmnlE9KVL7nI3Z/kJrdYuzUFpnb+ZMc8j
	 elppofFp5a4AGy9ZSzdFVOEQw2oEebUX0bOPhb5O4sNFLDbggVNvYvx6brpBA2pDJ
	 zf5qakuglgwq+JDgXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.79]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1txDrS1O3T-00C0zK; Sat, 08
 Mar 2025 10:45:21 +0100
Message-ID: <f1caf085-043e-4b30-ac0d-56a111e36a78@web.de>
Date: Sat, 8 Mar 2025 10:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, cocci@inria.fr
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tue1WJ2acRxEfmsbEmsNs7hhY5ntcX+LQIftH5HV7VFxb1z8tuC
 U5XAspQwwcEjDsVA4k0/LiGBDx9kMdiCPcX707e3wv7fmHklQEN1wKgDIyFWmIIms6T9ytV
 nuTp0khHqXP/9pQAF13pBw8WnJEA+uhOvW8F6UtVIEdKSom3KMBv93GC1opmsqnOtWRzL1G
 6qcLMU6szL64BkeoANW4g==
UI-OutboundReport: notjunk:1;M01:P0:ifo53dWZ5mM=;cFPgrwSaeWOKX9SFbFH62FAawkb
 IDMosXPThCiM99u39YAhcZmARq1fTMLiJe9+4bzTD4UxvZRxLliQFHeAKLgbzyF2DA1MsptCz
 o3w/VthYyjBmrLD25zUyyXdyCPJEAmEEdZ8/zgrMhCRJyfYiRt8Jtxqs3dA0K5V9RQKnZD2nU
 hV7qVYSzu0QWlPOWbiGE6UqdkPNvuM5G+kCYa7Lt5ZrLbTgEN0i15MpHgGGiwHQPbnAQFubpM
 xjSKkIm85BF/hJvTX3UmWSzzixecVsNG+PeKYVq0yY798qtqyIYraQO7sifhDaR7Ypujz874T
 r+yiX3+QhFH3eecQoYMjWfzon+mr0McOFpFppqsYJ/Coc46uxbzb4yWutVXXEDGb3pWA4jVP4
 3s1eLaJ3y3PsqfF6IA0b65npcq/JcmndL+Jv0eskiCQzpFALDW7z/1B6pTjVZ8lOvPISBsvX9
 7gFenVMmuhA/rJ5kl+AAJ13drqfLfyRQ/nTb2C7n3TfRyGmcYbUdVO5mmzbgPUGaICCNvJDp4
 dxAzvYGpGHU4Zxs3L33Lz8gsiWmlX0UYIjOgXoRICwbW4uJHbuGevU7oSH08PA9sdd81gUddT
 +rxCTPDZk81Jl50O3qYMT6mnN+uVTzP8RPhsQcwtT3cO+uK3CLEcxqoOpUp87JYfX2f07UW3h
 lF61GV+7Cz05yywg9ifDHYGK56kY+8w2AlxktVP2/EQF1TMTT7nk9VHFg6Q5/wW8sUqh0NEoZ
 tmWiy5VuKLAXIYLovizEQVjiGn3tNJqiC8xK3EKt8UZTo/xdsVlmpWGZIK6srl+HFtH5NSdMy
 G3qOIkFK8zVQcg8z3+dtUqjmkPVxY/OKqICVitUFL2hB1sr5Nbsr4BDTv4RJVEhQHw7GsEskb
 XImyoLjOcnUOlVfwsNaCe+KLe9vbmEhlWje+mgQ0Egna29jEXAefEDKuzosSh0o1YDdvmbgQg
 kNg/3Rzw5TJUOagWGA78IvoeivWejppXbh0X5VVlRIKOAOViSmdflOGvx55NHRQMOoBy6KilV
 c6omZ95JlgGSIPuMvhWMmgXTxOS8Gyv5eMtudTejd3Qtq6uJkp0dePOFxCfNgRo3agLzkEJDf
 xF+Moi0xgvcMHuVL4GpflrG7Bp273H+J5K7YuC7RmkNHWCycfAFSjXIZ1AdotYAWojQ83m+0g
 hpIKKDldCmcQv3Enwd1d261vZKFgn5yjFrdSlmByTRn4EeiY2UlNsyDZL2w3VK237h3pKpRoW
 lIuunbqD3sBFNSlKhjt6RTWrj3c1KjUFqUd5slqUzNY8SpdDSJ1W0btpWXDwKvePoLMU2cChl
 JNkFz01W08EbKNfArTxLCvlZqqrKrgKBX/d4hgtcj1+3q04BGkCNsrHAYUgWVcUAucod2Qz2Y
 8Gmnj8JslZyU8bOhq52+2TWQqw9qOyWMLzIJwD+yEXmBEhD7dawQHlpWsT3xS9BUZlWQ/r//M
 ie76B57ykIXNSQprUvojFaMPVH9w=
Subject: Re: [cocci] Evolution of transformation processes?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2578
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f1caf085-043e-4b30-ac0d-56a111e36a78%40web.de>

> In particular, about my project:
>
> We have a repository with code that is originally designed to be shared
> among multiple drivers. This code uses constructs like "ice_free", or
> typecasts required for C++, but which the Linux kernel does not. We need
> the code we ultimately contribute to the kernel to follow the kernel
> guidelines.
>
> The semantic patches are applied automatically as part of the build
> process, and not something we commit. This process was done in order to
> try and align what we distribute in our out-of-tree releases with what
> we end up submitting to the kernel community.

Thanks for such background information.


> This usage is likely different from many projects where the patches are
> used to find and commit fixed code. In our case, committing the result
> (and thus being able to manually tweak it) are not viable because that
> would break other downstream consumers of this code internally.

* How much do you still need to recheck results from automated data proces=
sing?

* Would you like to achieve reasonably low system failure rates?

* May you represent any parts of organisations which can influence
  the growth of development resources in more significant ways?


Regards,
Markus
