Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DD8C4707C
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G1Hud5/Mz+1TxVChRVaFZEFD3aH8A+Wza/U6sVZxr1I=;
  b=Fw7r8p1QIExhk/uzhxT0Vv1Ud1NYDtvk6/h39QzsK5tqWvAZV9hjbkEm
   QV+Gl2W52mBqV7v8y8I140P0d7mJuET8o/yPtU5MTVC0MEcQgs0X6pV+6
   FAsXpvv4y4esRWnIUDu9/bSvMcgjD/yJKYCpk/LAWwjs3ME+OHEujJejx
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145890433"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 14:46:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2460AE0CCE; Wed, 10 Jan 2024 14:46:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E75DE004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 14:46:31 +0100 (CET)
IronPort-SDR: 659e9fb7_pE7/cq/IduGTVUkgFNAMqTGuiJnk2PoVrDfMMRYD4WzQaT4
 kR2utjfg/wwr7rMVoZSsBWoj20CjsOjHn7JJ0Dw==
X-IPAS-Result: =?us-ascii?q?A0FHAAA0np5lew4P49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YI4gVIyBAtIhFORNjCEO4c1h0yEa4QEgVYUgSw+DwEDAQ1BAQIEAQEDBIR/A?=
 =?us-ascii?q?oc9Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJ?=
 =?us-ascii?q?BgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdA?=
 =?us-ascii?q?QERGwsBBAsLGgImAgJWBgEUAQGCfIIrAQMOIwe1XYEygQGCCgEBBq9YHywiV?=
 =?us-ascii?q?oFgCYEaLgGIGgGFZ4NBeicPgVVEgTwLgng+hAWEGYJohVyQIlJ/HQOBBQRcD?=
 =?us-ascii?q?xsPHjcREBMNAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCE?=
 =?us-ascii?q?BoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwLBAwaAhseDScjAixCA?=
 =?us-ascii?q?xEFEAIWAyQWBDQRCQsmAyoGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKA?=
 =?us-ascii?q?xQHCwd7gRcDGSsdQAIBC209NQYDCxsGPQKXXqgBoQs0B4I0gWCBYQyfKwYTL?=
 =?us-ascii?q?4NuAZM3DgaSVC6HUJBPIKhGgWUBN4FcMxokgzZPAxkPjiCEK49HQDU7AgcLA?=
 =?us-ascii?q?QEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 3M1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:aFSLGayDR4dQJjza8jsPKrPwIb1zdoMgy1knxilNoH1uA6ulfq
 WV9sjzuiWE6wr5NEtBpTniAsi9qBHnhPxICOAqVN/IYOCMghrMEGgN1/qH/9QiIUHDHyxmuJ
 uIv5IQNDQ4NzZHsfo=
X-Talos-CUID: 9a23:P5cMoG8Imrh/mXMGMheVv2c9NuMdMUfy8FDrPEmxNTxPUL2uFnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AwBoqvA0nI4anpWHtJzwhk0mPTzUjz670U1Fci7I?=
 =?us-ascii?q?64di0DiwzHSul0GnoTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76387241"
X-MGA-submission: =?us-ascii?q?MDG9HIilEupqHG5hAQOwqrrgoAHAgDMYcFejZs?=
 =?us-ascii?q?GpEkykxFVLTiwoGovnjFHXafIa0cWMeg4ddGfG4BTcAjOIqhsmRFLxze?=
 =?us-ascii?q?RJwE7lCRM97R7Yh+C6v7tLiKyurmnQ1L9jkeiQellAvJ/hlmA7di0oz5?=
 =?us-ascii?q?ekcrkDa2E78IqRVWDlArMPwA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 14:46:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704894387; x=1705499187; i=markus.elfring@web.de;
	bh=G1Hud5/Mz+1TxVChRVaFZEFD3aH8A+Wza/U6sVZxr1I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BWehdJKP2p3b62h4fUiVJaqmt7mpvE6lO0te5Cs2W8jEzNpvTlkqQYXiDuZo/VFV
	 RwNU4/Pe5zByN3k9BsIFguaL0+/AGcin+MZvjd9vVzhbJ7GZAAGWOvbbKlmb2fKcc
	 M7XiP0CfVmpvnuN3sVntLA77siseL5zMQRObfjhMsT6v1pQjVdKiNXen/nMyzIaV9
	 lvdDiLWgZBT9K50uAdFBKydpdVbNmXLukZjveTN1Fo25gb6G5cXvOqa6g5HtAdBSr
	 svqScTt6zuAoZ+cCo8fGeh8IvZBR+G1Xm5cNrygFair13q2n462zn6JadNH2Fuwg1
	 j40i5hBQTGVKDEq+Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1rbuwB1dqW-00L0J1; Wed, 10
 Jan 2024 14:46:27 +0100
Message-ID: <79ef2b86-2215-4e8e-b08c-5519a4fa734f@web.de>
Date: Wed, 10 Jan 2024 14:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Christian Heusel <christian@heusel.eu>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <vltzbtbcuzrfgjoeg5oovdyoe34fnhte25uhb3gln56pzvmqzb@5u7u7cwgzzen>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <vltzbtbcuzrfgjoeg5oovdyoe34fnhte25uhb3gln56pzvmqzb@5u7u7cwgzzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Kl+pq7sDIhZJ0GFjYmlg09if7eT2zCf4sXATX0lyQRCyZdV3Wuo
 57ptJH5RJT7ZTASUXQNIDk+FSWnT6rK/L9OFE50KiqRkGnw2ZOWn0yL94blYtkbuDbFZOGC
 SBkm4P1qUvuIfizYmvkitcqo1JVkmOFV416cwdYil4nx8D+vjmaetUtM0WeSAAEfhq+DUXy
 v8NplAm64Z15atQTLZTUQ==
UI-OutboundReport: notjunk:1;M01:P0:6aOeVazPvdw=;qh54YjMHnV5fYUilF3X2k1g/ysR
 sC6ZbAA8C/MurU6RaeMmT8QkbiR7EW4kkJTFI0m8PyZ7L3Zd5l4e+kuG5IuM/3Z7lvDtNEDpP
 Caxdwt16FHfhakbYNbiAvf+fc61lK41jums6Y2J0bgmEJu06PfZ81HuqBNEFHENfl9O7YC2jm
 rNmPvhc7RLm4GmsMfb0EHBjW2iU7aJ4IOXDwkwLuuUnXqxMVzj71UQfP+onKuJP0w6Zff1dIL
 hQI42pwjd7Sq/UZOT037CqEZdrkT6/acPtHrnuSpChQBfFLwkuMV6h8hPLYadI8E4l+XIkjg2
 5ZGakaPHIfVuAfU2Wda6F9CTfCjTL4nHpQFZIWfPMKMIqV4QBhlXIIcYenBZPLK2OCJ3hPym3
 6OW6aHKFLbkamszKUlQcU8eNH02i3RJgNZEo7e7n3jhWJAog0jU1mqcWtcVGJLqnKBfgN3W3v
 XfGLE0nAAQCYf2dYzUR5kk1D7jAmryXnUVNaPoZkR8gFqcsHWG8azO8XLKaHdOaZaQRA0klJC
 uz0xk7UFI4AYWo9436GesNuJ8SJAHrH/JT/bBaMhDplJJgevBhyTy2kDS6tHGbZiU2ssY0skF
 mSpD48g+C5xhV8CuinmamUCNMhW1/egTOE49R9ihKNoKuG1nHHA99LIlXvVVOP9vT9SI0sTZK
 Q2Eeu/2zgMcruyRunNn+u/CcGXcFrg6YIZYRkfk6Wp8rObvnpz+LnPVDynxA5hl7OYr/Jef5w
 RQBmideScsv2CZ/f29qqnejdBNARda8ozsgVkhFc60tOn88dSxNmfrWM0ypUT3//Ddp7y1rp4
 SKzKHZDUdUpOXNkUgxAYws9f47plAb+6Ipk841oM16jx2ZAJaU9r6C1jBG8xLTwTA3oO3JRAB
 54IBCLZzxsff+Co0nWnrg0HOzVSLjLOrjbkkupsnt3PgZ1Hax+ZHnc0gMg+wmQTGDR73fqajO
 /LYURQDqM5hmnF13GaX7t73VTNE=
Subject: Re: [cocci] [0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1454
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/79ef2b86-2215-4e8e-b08c-5519a4fa734f%40web.de>

> I am just generally following along here, but to give some context it
> seems like Markus is banned from posting to various kernel mailing
> lists[0][1][2].

This was the case for a while.
Were such communication filters reconsidered anyhow recently?

Regards,
Markus
