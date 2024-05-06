Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B6C10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QmiDE7GWAr81jYNSu3q9OiB1iiddkOe5AzwrakWwyEU=;
  b=Y7sgJ4wavhaeMDzFTLtkLz9InW6MD4Hw0iAjD3wTVoEfmSCpydJAUMgY
   I9YzGhmjjKiWSwhb7CBQmeiNKOPsuHSFiLZnTl+U5p6r2p6EQRmEc+MnX
   K6xrhMtR6uiltdkF/reORpffMPfZ6LyHEFrV8Ci0nLHi/B9T77KIZwQCo
   w=;
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
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164680001"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 14:40:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F419E0138; Mon,  6 May 2024 14:40:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A992E0133
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 14:40:24 +0200 (CEST)
IronPort-SDR: 6638cfb7_tNqIUbmS46DMd4nn38RFTsv+QyxY11rBs3fuGNrEPknZrFb
 XE/DnKQ2xAb3FT0LAlTNmcGjUOUq6mfU6xeNkug==
X-IPAS-Result: =?us-ascii?q?A0GQBABNzjhmhwwR49RaHgEBCxIMQIQTgVMzBAtIhFaPR?=
 =?us-ascii?q?oF1MIQ7hzmHT4hxgxY+DwEDAQ1BAQIEAQEDBIILgmoKAoguAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcBE?=
 =?us-ascii?q?IEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjHQEBEScECwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ8gjABAw4jB7MPgTKBAYIMAQEGgmfXch8sIleBYgmBGi6ILgGFf?=
 =?us-ascii?q?IRAJw+BVUSBPIJSMT6EQ4NbgmmPSIpejQtUfRwDWSETAVUTFws+CRYCFgMbF?=
 =?us-ascii?q?AQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDCAQDEDQDIG8RAwQaBAsHdYF8gTUEE?=
 =?us-ascii?q?0QDgTiJegyDMYF3KYQhCENsFYN0gXgOYoNcgxkdQAIBC209NQkLGwYiAR2lS?=
 =?us-ascii?q?YIrxhE0B4I2gWCBYQyfRAYTL5c4DgaSaJhiIKhngXwjgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmEFJw/QTU7AgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:RvfTBqGRQAOJM5KEpLqE/ceALOsnbusQ8zAXPiFKOH9om6Oj9/
 xG8M536faWslcssRMb9+xoUZPoKRnhHPVOjrX5U43PYCDW/FeNaKtm7Yfk3nnJFiDkn9Q36Z
 td
X-Talos-CUID: 9a23:bZP52G4lz4adWAWVrNss7XcNE80FWGXh8GrvCgy0I35VUL7NRgrF
X-Talos-MUID: 9a23:Vlo6ogT1dH+z9gbhRXTPry09OJ1H7ZjxK0xXiNYel8mhbmtvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="86471292"
X-MGA-submission: =?us-ascii?q?MDGZ8XWjHs1j0Z+sGsDS3BEGrIThtAwOljCtP9?=
 =?us-ascii?q?H/VJexDBSsCzhlj+5em92pl8DAhiLsb7EzJGOPd0V0v73H8aZvt1dSYX?=
 =?us-ascii?q?cvxAxUwX0cGAKRaddu07rvpe5QQh6cUQCAW3djZAulRovSIYGSJtzzxI?=
 =?us-ascii?q?H9r/SSM0CUvrhhY/v+zwHKWA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 14:40:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714999222; x=1715604022; i=markus.elfring@web.de;
	bh=QmiDE7GWAr81jYNSu3q9OiB1iiddkOe5AzwrakWwyEU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vjz6AId57GSzSHHEhgmUUYDFMR+sTtX3O+OU9Vh9mNnhl7tzUxh2TZlRUAicKiVq
	 tEhQ1CKSfNmvfURj0BCkYn1tUkiBb/fSNuctRFH4MUkcDh8q7iW80qU8vwSvY24Jz
	 teM0CLKXGhOiAtCYvPGPzuVA5lZnriBpJ02k1sgMYTXX08mKBUdz7K40Y4HkM3/DX
	 frhqwnIMVCyFvpAHKrtOW3UkfBM+HZoz5DC6W1T46z+S34rgymBJWS7uJqS9UjCn2
	 Rl2kM1syRnzEOgmJp+jDjlQzChvLYZfdiPD2Xhju66fZh2JMvVH5pCbJ6d/QoFkAB
	 dvEROJO7KzKtkEPl+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1sT8uI2IEG-00ktTZ; Mon, 06
 May 2024 14:40:22 +0200
Message-ID: <16c734fb-aaf4-4a01-8a13-129037a5182d@web.de>
Date: Mon, 6 May 2024 14:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <688dd1ab-acf6-4e0f-ab2f-aa682549760d@web.de>
 <255638d4-292-c384-4d10-152a9583599@inria.fr>
Content-Language: en-GB
In-Reply-To: <255638d4-292-c384-4d10-152a9583599@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E6UwWqG0GVD6Oy6w9s0zAPmwEaMboliRTw+qrif6HmoODlq66Za
 3obEZOmGQf3/8D0upv7ezw4Pe4duqQmXTE+GHf5oZDMkpn+niRlkVxdwaIga3EJg9ub5hTO
 PZAQjSuzkBuDqgNSSROeXt707E7xIczJfeNtQFdQ2C/k/zH5khQnWffMfjgrnOl0gWEYUHi
 q9w/ptBCJgaSdEf5zxF4g==
UI-OutboundReport: notjunk:1;M01:P0:Up3APYXruvc=;B6rpGn9SQrXQYPtzzvWt0p9HB//
 8b1tBVijzGPJ6O/OBuTN20ChzCEMH7lizZovgMDAF01TfksUJdxxU0V7DwchQhits34/9kIHp
 ONBtjvvq3ocxM47cnebp2ZszXrBz3xCoqPZp9hJkvsvPW6UhBxWFhGrULK71X1sAIucplaUcW
 e3ivnN/WT5DAcyp6+c7lqAnieu0dmPhSNwE4MprJsM55roHNL/xPNIwVnSXMP2PtPUBPe9KrL
 9+qLZyOSgwhTI8WP3nhsmnDyOxkJKopcNntmIajT+WlA2d/kL2NW2IMaGWKY6GNSC6wYThSVc
 B5wLVTHyoyHfPrRWoqVsJMom4EaYTlNuuJ+ldVSk+1J94Bz9gkkZKjNvZlvapA55zo03pEOjm
 R1LACE1QvmjpkTEZBNKOtpjJTFc24W8HZUhV+ffUIfgpQY0ZW3DsS0WZISjuWuIYG4uSlGyi9
 Wch5nQZDThhuh/KqTsAyBCZJ/J9i2uieKeIiRQPX/zXHMHLMhkLjbDjD+zAYZj3SjWuIee6Hc
 ZU2he09U+VjlEhVhc8BHABwpH5DdI7gXrzpFC7TcsKmaJogb72XeEe6Erprez3fj+TJTtfv3Q
 ql2nIaUu1ldh5OH867sZrReZTapYFCRi0mI9y9kGqM2uj0TWYph+6dHbNFF3UbDQQ9b9/M3xl
 /Pi9ao+lkz9M8MvPty5++2RATE3qdci/zBCiGYLqEKH4H3BFR3lBKCwChMOx765xO3DacGxek
 eVl+LMtFWhy3FHqAnhS4hMJTkufkjgtP/ap6ZBkhhwwmxceoCPugy7NRKdmw9osXT8CNuMbZx
 eHZlLTyCw0KoeW/ZDcNWsuwJGuxKrZn7YMMgj9iPlaikQ=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1706
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/16c734fb-aaf4-4a01-8a13-129037a5182d%40web.de>

>> Example:
>> How would you like to determine that an if statement was specified thre=
e times
>> within an function implementation while the corresponding compound stat=
ement
>> should contain a variable assignment and a goto statement (at the end)?
>
> If you really are concerned about three identical if statements plced an=
ywhere,
It can be usual to repeat if statements which would be similar also becaus=
e of
known design patterns like error detection and exception handling.


> you can record their positions and then count them.

The Coccinelle software counts source code parts already for the supported=
 =E2=80=9CDot variants=E2=80=9D,
doesn't it?

How do you think about extensions for SmPL quantifiers?


> But it doesn't seem like a genuinely useful thing to do.

The beginning of another source code analysis can help to achieve a better=
 understanding
for desirable transformations.

Regards,
Markus

