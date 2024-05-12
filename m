Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FD3C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AdeBHEJ1dfjlS/yctC4KYyH5fOJ+JAdYofJQFN8CPOc=;
  b=dfNCfbk6ia+t1jwZq30StcqTAYmHYlw3khPW4kIaR3PIM5wyRAUVOi2Q
   j6ctk2mw06CFW/fV3Vm9f39AzvoWaCeMiS3i05i35Phv4LIvWDEmKsKDo
   BCR6XvCXtnN9xTrqGbxWqt5eOBL9mF+2V+UiPn8jkriJAabSG40dLrUtO
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165239831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 13:24:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 648E0E0AF1; Sun, 12 May 2024 13:24:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F7CDE004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 13:24:08 +0200 (CEST)
IronPort-SDR: 6640a6d7_4Pwy36FCgeLnyA8cSy5Lx84vWOGeLVswc7DarNK2YnkgliV
 5tsA/DDqGgTgMi/asgx/21UEb0oBbSyaRLoE42Q==
X-IPAS-Result: =?us-ascii?q?A0HiBQA8pkBmhw4P49RaHgEBCxIMQIQTgVQzBAtIhFaRP?=
 =?us-ascii?q?TCEO4c5h0+IcYMWPg8BAwENQQECBAEBAwSCC4JqCgKIPQIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0DYJnARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBIx0BAREnBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfIIwAQMOIweyaYEygQGCDAEBBtpZHywiV4FjCYEaLoguAYV8hEAnD?=
 =?us-ascii?q?4FVRIE8C4JHMT6IHoJpmhyCHoU0iGdUfRwDWTIBVRMXCz4JFgIWAxsUBDAPC?=
 =?us-ascii?q?QsmKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBxEQMEGgQLB3WBdoE1BBNEA4E4i?=
 =?us-ascii?q?XUMgy+BdSmEHQhDbBWDdYF3DmGDWIROZoEnHUACAQttPTUJCxsGIgEdqkGTL?=
 =?us-ascii?q?ZERoSA0B4I2gWCBYQyfRAYTL4NyAZNFDgaSaJhiIKhngXwjgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIRmEFMs2QTU7AgcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:YnzKpK8jwDFttDhubr5uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:/4qvvWwrhgSmAEX2lNysBgUIN8s+diDexkz/AG22B3xPdL3LGE+5rfY=
X-Talos-MUID: 9a23:NBYfoAW5RqLeiVHq/CbIv2kzNuBY2qPtI0UUsM4lsPaWPiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165239830"
X-MGA-submission: =?us-ascii?q?MDGcHBpst05AroJ/Md+WQCZOjUTL2TJ77QWROP?=
 =?us-ascii?q?VpJNDu51iBfZpC/nFDSEiQ36h+nttfkt8O6TkmB+HO1D/Y5NpEN28dEN?=
 =?us-ascii?q?GetNJbYdIj3CRAqGc6KjjTxUynFIZHLM8Q0+Uplz7/wIAhbcC0nEoQ83?=
 =?us-ascii?q?An4BUfzk+DIO0OPiPP/mhu0Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 13:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715513046; x=1716117846; i=markus.elfring@web.de;
	bh=AdeBHEJ1dfjlS/yctC4KYyH5fOJ+JAdYofJQFN8CPOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KVKDxbvpSauwHgd4q1nyYgUb4W+LB0sO4nU1843ARQBQGoqtX4wC7+UVu5Mml5SE
	 WBadRsNHphHJkgyt4kiWgc27iCbwZDfsKxgGE0Kmqtsefk+37RIsKwoC1gJBPaP3l
	 2spP5hzYrIg7Gp5AACID2Iyf1OgcICYwPYXf1nFKSZfxSI+6dQMhCeoahKrNEgJ87
	 fzM36qgdKeUjrMzre5CsOP39bo2/F1Vr4uQo+SDqhY8nTxKh063zXedySLyVKV2aD
	 hTM/I/zru5u1Lq8dR9fefCgMYQ6guo1G9Z0+yr5oJgbOEmpWyVXHC1qH7ZHdTSj8V
	 PqOFQFirSM138Avk+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1rzGsL2lJX-00I0LU; Sun, 12
 May 2024 13:24:06 +0200
Message-ID: <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
Date: Sun, 12 May 2024 13:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fs7f6rGdRbg4OIIuLgVqOnfhUfjpVMXQefdpcMt0X001I2dnv+Z
 BGPtniqySRu6fKqJJGn7ShcfM/1ndy0oDM5qbNBIUUqVsHHpVHgFD7VpTZdSg4PaRrurSS1
 DOQ1PNsulDsY4HRazS4+SiH5X4pra5+aRD2AGWvgHfuERKwlJJA5c5YKLMsb7hKvmtDJnWT
 3p1ei2EOVOcsV8Tq4mAow==
UI-OutboundReport: notjunk:1;M01:P0:CGT+k/ZDFrY=;COC0llrdu+deSC8yr3bOoG4/09N
 124zE7tXvYb+kvrwsQYYsRQubTlWiJoIpYwUukrRyXu3qU3Y6mQMEq3WQpErFTBRn8Y8Cta+r
 wGfnbF8JLBEHA/wV2T1Y0/1kL/mSfXZC01qH5J7ZOravk6ttvuWPRyNoqULZrTSQhTbduFI5P
 2nAFYhjiSVpdmbcucgQbKjiLrkiVFf2FNRpoLi+nWDNT9YMG95icZGdp2u+XaJ0zruymH80zf
 ftNuWHGSfgKNDlFbVdYdtI9r1YmuRim55m+zmqd8jNZr8NYTcrvfEsxiT4gDcfNrZ6qCYIsxW
 UYn4+3KQtOq33ES385EW5EwtIjAb9bvG32qto7feaMVKA65qW5StQKh2+o9vYKhsfCAH4zCNp
 tSXJJEolzVHfMPDsJ193joIVkqp6dtvf8IGxBy4i45NIceuEMPhrGZZQ3J6PpNKbjXT+/bXLi
 zWS6iM8Acy40tNA53WyK4a5x/lvLViiacWzYJs8M+Mm4qNmQaxPCSTaawjrjuXwR9Qowyx2/a
 ECMI1zzDk4xTfWzgRACQChU/zG8OZLxKnZQvbtYhlcBmnI65rZITr8vdg3ATiwvJiXBXTUoMR
 vc9RWaAELRaUF+HpOwTABdyB2+5XHZRveNhxVrWNHhAJ3kWd7D8bG/Jz9kvTb9nS1fEAO3LuY
 ZzKGeNu8ecyDRisPb/KDaW1jXfbdXdUc2CLHom4Eu93aENS0M+EMIoWTfTMlz4lO1WTO+yYNz
 sMrsalbHiey+83li9a9/FQBxewYzkgXyCdrFcO26GY8m/R14bWRQFFw8MqLu47WD3ZL41uvuI
 r7+7oVJbgHFNdwtNq6S1IB3RxGojJU2qk4ZFFqtHtvp2c=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1729
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/ac4b8c84-abb1-496b-9377-4f47c1f7cbb0%40web.de>

> Probably you should start with ... when != my_action(...) to be sure to
> get the first one.

Should any SmPL search item which is specified at the beginning of
an SmPL rule be handled by the Coccinelle software as the first source
code filter also without an extra when constraint?

Can it be checked if such a primary condition is really evaluated
in the desired order?

Regards,
Markus
