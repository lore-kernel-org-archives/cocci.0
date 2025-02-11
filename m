Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E46BC0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aPMDQ3U7S4FC6JIQ1XC2SQ5Mexun071A+Zgrn1GL5Lk=;
  b=dfIaE6IB8md2/cRSaApFpQyaCPL6caovmcLpEjUiA0bkoz6sYdx/XPN4
   HzkQev60TNKTJ7V29P4Y++IIILGZNmjj34R97j/YBMt75NcwnIsXh4GoX
   Rnfn8nAQQrVRMUUWGQ8DJl5ZKWiaBnmdijGfZGrkDSGUqLoZwsaRXplLT
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207777723"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 19:04:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 885E5E0D1D; Tue, 11 Feb 2025 19:04:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F6CEE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 19:04:21 +0100 (CET)
IronPort-SDR: 67ab9124_l+TWSo3oqJHhic5k/lS9HNHYHz4S35cJxTMp/8+TPzcXnyB
 R/+oJZOKHF8+TUa9r+9m9rtsEfQZblvIPOspcIA==
X-IPAS-Result: =?us-ascii?q?A0HnDQB1kKtngAwR49RagQmBU4JEgVczBAtIhFaPT4F0M?=
 =?us-ascii?q?IQ7hzuHU4xJDwEDAQ1BAQIEAQEDBIIMgnQCiwkCHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+gjABAw4jB?=
 =?us-ascii?q?7EigTKBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGKYicPgVVEgTyDAz6IHoJpg?=
 =?us-ascii?q?jOER2eJaohqh3+JT1J7HANZLAFVExcLBwWBKUgDKjYxIw+BFAU0QTqCDWlJO?=
 =?us-ascii?q?gINAjWCHiRYgitqBAU8NTyBKYEQglqBaYEpgXkCczRGhRSCEoFjAwMRBRIBg?=
 =?us-ascii?q?yF4HIMUBT42AmYdQAIBC209NwkLGwY9n06IFj3FXTQHgjiBZoFjDJ9cBhMvg?=
 =?us-ascii?q?3CTUw4GknuIGhWEdotXIqkMgX0kgVwzGiSDNk8DGQ+STsVQQjU8AgcLAQEDC?=
 =?us-ascii?q?YVGAQGLCYFLAQE?=
IronPort-PHdr: A9a23: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
 ICnqQ==
IronPort-Data: A9a23:g1jsAKLLDwzi/gQMFE+R6JElxSXFcZb7ZxGr2PjKsXjdYENS0mEOm
 GAXCm6Ob/nea2r1f95wOoq19klXvpGAzIA1TwUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb+s9JIGjhMsf/b8ko25KiaVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuInm0wfhwMhoND6Yz1O97GllE+
 eweEWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GlK2IH9w3K/PFfD277yBVN9enAMNbvZp+uZ/pOuBqc/
 W/p1jGsav0dHIfDmWLeoi3EavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mT6TIH/UgOG+0W2lTUyUtZLK+c2+Ae0n/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWM12FFyYS3Hnop4vQ+P1T4pwXgqSQJscOfoy9zkvZ11kR/FCNpueEJUsjEXMWGgq
 9xphHFg71n2sSLt//vglbwgq2z3zqUltiZvum3qspuNt2uVnrKNaY2y8kT85v1dNoufRVTpl
 CFbwJnEtbpVVMzXy3LlrAAx8FeBuKft3Nr03g4HInXd32j2pSHLkX14u2AndRw3Wir6UWWxO
 BSC0e+u2HOjFCD2PfcsM93Z5zUCzK/mEs+tTf28Uza9SsgZSeNzxwk3PRT49zm1ziAEyPhjU
 b/FK5rEJShAV8xPkmHsL89DiuBD+8zL7TmDLXwN5073ieLGDJNUIJ9ZWGazghcRt/3a8VmPr
 48Da6NnCXx3CYXDX8UeyqZLRXhiEJTxLcueRxV/J77ZcDl1UnosEeHQyr4Hcolo1fYd3OTR8
 333HgcSxFPjjDeVYU+He1JyWoPJBJxflHMcOTBzHFCK33N4X52jwp1CfLQKfJ4m1tdZ89hKc
 9c/df+9X8t/Egb8x2xFbL3WjpBTSxCwtAffYwuneGceerBjdSzo+/jlXFDdywgTPAWKtO8Vg
 b6p5iXES7UtGiVgC8f3bqq07lWT5HIypsN7b3HqEPJyJnr+wdNPEDPjq9MKOOQOFEnz/SSb3
 AOoHhson+nBjIsr+t3vh6rfjYOWP8ZhP0hdRU/30K2XMHTEw2+d3oNwauaEUjTDXmfS+q/5R
 +F0zen5AcIXjmRxrItwPLZ6/50Qv+K1iedh8T1lO3HXY3CAKLBqeCCG1PYSkJx9/OZSvA/uV
 3+f/tVfB66yB/rkN1wsPysgUPWI0KAFuzvV7MltGn7A2g1MwOOlX3lRbj62sw4MCJtuMYgg/
 /Uth95O1Sy7lSgRE4inigJ6yj2yC0IuAoQdi4EiIY70iwAU5ElITr7CBwTXvpyeSdV+HXM7A
 z2ThaD91u1Q7ReZQUUSCEri4Ot5rrYNsSBs01UtCQmomN3Ep/lvxzxX0209YTp0xyV98dBYG
 zZUJWhqA6SRpRF6qdNmTUn1Py1gXTq3olfQzXkNn03nF3iYbHTHdjABCLzc7XIn/HJ5VRkF2
 rOhkULOcyvgJeP11QsMAX9VkeTpF4FNx1eTifKcPpq3GrchamDYmY6oX20DriXnDe4XhEHqo
 epL/v56WZbkNBw/8rEKNI2H6Ys+EBy0BnROYfVEzpM7GWvxfDKT2z/XD2uTfshLBeLB8G7mK
 shIC/9MaS+D13e1nmhGPZIPHr56p+52xdwgfriwG3UKnYHCpRVUsbXR1BPEukkVf/tUn/0QE
 LjhLwC5LjTIhF9/uXP8k81fC2/pPfgGfFLd2c62wsUoFrUCkrpeTmAv4JSJvlG+EghuzzSLt
 iztOo7UyO1Dz9x3vo3OS69sOSS9GenRZs+prj+hgo9rVszdFOvzrCYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJlt6VJOg4PAqB3Ip1/IWK7Y5AcSf/KiWC6AFWr03S4gZmzpSp4vHuPQjOBHd3h6
 J3IegnmeV7g8OvUxdVeqMppsgdREH95hvIqc1kA/8JtzQq3F3MCMf9XJKBu5ku4ScAu/MqQi
 PDxgGoe5eHVWDNZbVPj7d6lUgr36ini/DvmDmRBwq9WQ37e6EC87H9J6SpqpXt7Etcm5P/yM
 skQoxUcITDoqqyEho8vCjiTnuptgP/Xrp7NFYYRjOSqaysj7X42OLCN0eaDueEr0y0AqakTG
 VUIeA==
IronPort-HdrOrdr: A9a23:BLtOCqCzp80k1TzlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:BD4+pGGKIxq6YCwiqmI29hYWF94bKUbv51z+KkOjMWxlWLusHAo=
X-Talos-MUID: 9a23:sEijQASs13gy7SuMRXTonQ1HZepo756yS2Qvro4g583fOANZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207777713"
X-MGA-submission: =?us-ascii?q?MDG3LylkHTIe1XJDEOHPRRSumXHplHHv+Y56Ln?=
 =?us-ascii?q?N57ab2Vilk+DiDa8myWH4fGwP+xuJwxXf0YtswBKH0+HcJhjZZy1jkTb?=
 =?us-ascii?q?GFhaAUtB8koyvhEljwB2/7QLF27OKXox0fzDtKX783NRjfdpDdZ5CJxe?=
 =?us-ascii?q?PMLBsoPb83tMb+oH/9F7b6pw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 19:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739297057; x=1739901857; i=markus.elfring@web.de;
	bh=aPMDQ3U7S4FC6JIQ1XC2SQ5Mexun071A+Zgrn1GL5Lk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QcQCYA0PX5g4ADB2VeHTDe3WhhfFL4mfA/mSiogaap76fmc5fF8gbiUBdc3+qZK8
	 /L773re/w0OL6BFefk7WHz7R8FmcCRI0sooWZAxF3vRl9n9jlMj2ZBqy3ytMCCYt6
	 GKT0T3rwPMLSXZidBak2/1qSPZV3vBSYO7OvZk3nGuAd0ed3bLBZ8g+00UoMMNQSs
	 EWYC0QgkulRTPb/YHy7NLIBsG25EbHeO26EuT55OR+cZvK/BRUYBpzRTSLuLgUkOn
	 67rf6EOZCmwMsTjCKZnQLmstXjQZgUBXBQttIeq0H8xc9nvirIuKV2/xHw5StAvyU
	 IrO5OkX7Lk+xI3xIyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1u0gUP3VK8-00To70; Tue, 11
 Feb 2025 19:04:17 +0100
Message-ID: <3e372072-fde0-43f8-b0d7-70dcb26be0fb@web.de>
Date: Tue, 11 Feb 2025 19:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frederic-Emmanuel Picca <frederic-emmanuel.picca@synchrotron-soleil.fr>,
 cocci@inria.fr
References: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr>
 <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr>
 <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j2JzLLdxl41jVsmjJKGVICgMtNKglGO67zCzAic+6vk9lvLxrjm
 pYrXFIvAdhc9cy1x2Yn+x2ymLs28Wp2C++QyCTY/Kl9CvbAX21KPJ8DmeZ7avu/qaiW5e8F
 YE6b6hF2MKGC4VUluX+WXM7mAwXxxubGMo5WeFwEi8XiEHDdq0dRIcY2N/T8ndpPWCJmHCF
 qbnQoc4z8o74wzmEOHEzQ==
UI-OutboundReport: notjunk:1;M01:P0:blP7zJTTBb8=;ugX8SmIEH7Wm95nOV5zLX/WfbBT
 il1AnEOuWUo/93DeLx3+Rh7igF81ErajCyIi9ldTkc0cperVLzqhnk2HGxhjUenHZo+0eWpGT
 d0+bdSbo155h6yBJPL+V1S4sspmdR6q5AnaiJs+RHxs5qUsZMA3kfHM+Z2CqbQw7rY41bp+/j
 TvdvLAWU60djTat61IKDa4wunqgDCSZkB9gPWLa5NixXQ3Sma1W3hfHK6Y3MY9VYbhtQs1LTD
 J1zSFfTRpimIpYdNg4vxbqVOOZg6JnR8ZDw8i7E3qw7tKCKJMyOGPGOmtWRXHM+8/EG0eXXPK
 S19ABnCeKrHvcCoY9yDomfD/vuvn0g6GL4sofTtEEZJqxYmbtl8osFMghw1JKIFx2OzT82eft
 /2HZ7dLNvAS4yY4GDZWdQKU7JPpLYHvNz+cvIt6SwR3B9nLouoU9c6Zf4V1f51dtNLttMBC3D
 ocAni7xNwdtKdPUESRjmqpQ6SFLHCv1gcOtxib0l48v2ET951xrri1MEFRl8zA6zBEwbKKk5a
 YBcbARdupVykHxGo8Q1IpSqVDUkts3IFOi5EYOnh5Vy7rTTiqiSCvCsyq1TnyFk635gSm3jt9
 0ckNqi6Tjqo9kY00+YKH4dghGQ83Vh90/V3hmPIrkMFe+MPmYuyIWucIPuH6DiXpDwCG6P2Gu
 LdMuBu4vFpN3azdC8SJCChVGbyP6gAjqycmIDE0WyMs9pQ336tgoMq2lXQ9q/HiJCUyj5WE/u
 JJ3rLUXN19JGo2IAvie02aaxpdrI8JWhnleGS013ajY6qGpayvBNguaxhf0kQoEJkiIiS8q6V
 /Zw5v4E8i9H3e0Q5rHwEBUFnNQZm1OQ1O7wRUPdcs6O+cPey8VzzOHE5Lp0hLSeBCjYDlRfus
 QdziSfTg3Kh/7cesLpaV9r4C1ghFV9zKVHQDZHKVSxZSYoRBppgakGNOnJKKNNCSw1Pbjn0Ju
 ym99ZEhckxN60gHAASQhohVvD9cM7uuRR4ghx1L/b4hDL5sVcW01XPIpoasicx5xlQjKl51Uu
 5Dqdfr8OPBv2T6tb8/Gzl2fqDJ1BgsRuTBX5jSgHIdaCQT9odWjYyoCSqIZZOSIaOY0nIbXVn
 rK5THbCN/ViPRbsd0FH3y+Y70d4iXc0/n+YyZf6JkqD4TI4Hw4X6AQPiynpJnSrtiOBp5Uv6p
 4QHC4fl3/2m39Cnmpo9NvpkPxhigMgV6gK+XX0u0TK3+C9BZIe/OTQskM7FnBvrorenxG0AY5
 Rsf56KXDQMcmzk/BMuhnPTww5Fr9IKWCbZcFe9MUwsJVC1gxQ7Oauc3rTWGo47CzTsTSPrJgY
 6ibqgc4Y7KrQ7BQMTqyk7qdwkKkJwhX5icSDe2Oz19+5QB3fYCYhxFigGAhZPP+kSOHFambIq
 tJBrOnywjQzqFkw6own/HoCaFcA3F1xceJBdF2yeDyaKvXlV4H6q7Gs+EOoeQTertbRa/KQVY
 glP0k43chNbt22QZD/QMGcrHNh6Q=
Subject: Re: [cocci] how to write an spatch in order to replace guard vs
 #prama once
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2414
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/3e372072-fde0-43f8-b0d7-70dcb26be0fb%40web.de>

> something like this
>
>
> // replace guard by pragma once
>
> @@
> expression E;
> @@
>
> -#ifndef E
> -#define E
> +#pragma once
>
> ...
>
> -#endif
>
>
> where the #endif is the matching one of the first #ifndef
There are several software development challenges involved so far
for such a source code transformation.
I am unsure under which circumstances the corresponding support can grow
also for preprocessor directives.

Regards,
Markus
