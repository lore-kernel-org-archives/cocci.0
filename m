Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D0C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dvFOImcNLnrl8V4L7jerUtWNld1BzBEzK1IVbzafeuY=;
  b=TA/9+dgbUMF0KdpIUMIvs2s8xq4EH3kXUQrcopdKVwpDEyiJTTlRKU6u
   EQi5WZJMBGYXdsnS59rgrPWvcP4NsFuTWq2kx+r0Hg6ze6uZd7meCM2c/
   lWkr+PqLNnMgeVB1u8kmkbvIWO0spghfsymE4AkvVT9zaGCiIoBUlIdn8
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
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205540104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 10:56:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85DBCE0261; Wed, 29 Jan 2025 10:56:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2F29E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 10:56:34 +0100 (CET)
IronPort-SDR: 6799fb52_spwlCHEPhp0pZQaI4q88RbhCmndJjPvOEM/O7P1tEgRDX1S
 S5zL5ll6H1K5ps1APyIp5uIofVJsRFbjf1DcsJg==
X-IPAS-Result: =?us-ascii?q?A0HmAACT+plngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIhFaPT4F0MIQ7hzuHVYh2gVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSFAAKKdQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAReCZ4IwAQMOIwezbHqBMoEBggwBAQbaWx8sIleBZ?=
 =?us-ascii?q?AmBGi4BhWqCYwGGJoNCeicPgVVEgTwLgng+aYNag1uCaYIzhExnoTpSexwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSkQOAMgCjYxAhQNJRBxBTVBOoINaUk6Ag0CNYIeJFiCK2sEB?=
 =?us-ascii?q?YEtgjuERYRRgkNUgkSCFHprAwMWEAGDJ3gcgiwdQAIBC209NwYDCxsGPZ4kh?=
 =?us-ascii?q?hp9OxyTBrMcNAeCOIFmgWMMn1wGEy+DcZNTDgaSey6HZJBqIqMohWOBaQE3g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIYQtyWhCNTwCBwsBAQMJhUYBAYobLAiBSwEB?=
IronPort-PHdr: A9a23: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
 xRwhgYsOIzFER/z7l1xKleY/EMN
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:Mv7y06xTtS6z35l/norKKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:CB1DM2DoMCACgWP6EztF1UoWCuQiS3Pm4nTqBHf/BX55daLAHA==
X-Talos-MUID: 9a23:21K5JATDBSg16xxoRXTRgi18H+JC2J3+L14xjc0rucqgKR5/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205540083"
X-MGA-submission: =?us-ascii?q?MDFd9CvEVnSObvFPbXx2oUhlS5/y/p6H2h7Z87?=
 =?us-ascii?q?bq7bbTuyDEUS/Aht4QwScbIJ8P4KPEVJqCh/WgpqCRkjB8P1m+Nz7d5l?=
 =?us-ascii?q?k/aNSzKzBaW4WVkKmVYYWWiheyrlyIY1WDmDdU+Vy2NJUA/NWpcdAXWN?=
 =?us-ascii?q?dyjak6cTlX6drQ94+Gkb2VYg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:56:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738144591; x=1738749391; i=markus.elfring@web.de;
	bh=dvFOImcNLnrl8V4L7jerUtWNld1BzBEzK1IVbzafeuY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TJTQRWlVPvQNwJ66lfz3Tnn0gNimFueiM1XZhBHHGDU0BzRiJhikXRAMCc6qn/S6
	 n10b3sK9O/4d/S1F83jasBi5q1k1mxv1zHX/7D4i/Z8sVXWE/coFS5dmN26BfdP0t
	 AMuE535QHJB2EP9eYGMifUQyUne4XeuebXbckXtF0yjLUHFDBGHAd8oXinZAuB6rE
	 9LJgxhrpIK6EELrHEgktwuDGmmCQh9GWj+zs8xNltrtZ1Gt6ydm6UN3wwNldwaBeh
	 66Q9LTPjAnhJYUQ+6eeVy3hDwZSX2iuuMvgNYo2A4kP6we2LbPruj+IihNNsuJOoU
	 lXFFg1EcXRmUUWUvvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzkOR-1tGZws2jk9-00tcKb; Wed, 29
 Jan 2025 10:56:31 +0100
Message-ID: <7372f92d-9703-4b03-b048-b1d6c35895f6@web.de>
Date: Wed, 29 Jan 2025 10:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <fe13604a-2626-4641-908e-87eeaca53288@web.de>
 <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
 <fce88885-8c10-4f22-a19c-3b04430aec3d@web.de>
 <35764b92-edf0-490f-beea-c36207de4cc2@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <35764b92-edf0-490f-beea-c36207de4cc2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BUZID2x87oTK4BwRkKB13QSLLMoTDYrcWjWONukuGBe+If2NX80
 up73xGMY1sgWzu4w3UwMLk7owft9pd87HJ4z1XcfwGXbXMmNQd64ZcPFlDeSqo5UB/mmT2i
 56DvA6CrFsIXg9o6tawxf1jC7iLiQ8OgerNQ+9EVaPFoajz4WZ/7HuZj00ke0w1YjU70kIo
 sArqE1luDm7KK9OkdIrfg==
UI-OutboundReport: notjunk:1;M01:P0:UBLqc1X4lmo=;eRgxwNo3SNGtSsHQCxLA6rD+5fu
 jZD/80GARbStOjjilzonSM0m906epO9e05Y/1qVdAM58cy3TIMTyArEnHx4U288R4pe5dOeRw
 dz/uqUb01i2DBosIbOIXCfUAPq+wyXSTEEtLTcVb2oyU/bePKBFsuNA9ZB8tAYpdeGPhEsvd7
 yl36set+zsWi6uojPwa8VbtlKedBHJuUKW+9QSR4KYXxktL0yNPpc2HXSZkReirC4cWWshGrr
 l3ZARF4qtM/0kfelmMiRfKwn0X0CPAtHeAyMvsp/+A70XQaZ9Z2kuPuXjR512yzCqn8Y/J3oI
 2mxRwXzHXelwzt7irSCSOX5drq5ESbTn7Yjw+sMVOtCALSKbsO6BLa86MjL63SesSz/OerLLI
 IhPu2yUY55TQXKWD5Gceaeub2wsi/mOThsalUF4AQDjNKDGhPcQz4MRneCbbhsWahveoE5TVz
 u0yLj8BoPBUcGsc+v+ES5g1ipzmyCKlPs3yCN+nQxyQRVgYlp5xQ64U+c+8pkpIAIN38h1BCD
 xhm25ITJOOwoSDaBWA/OXlVN8bcgnsHLS9rvHXLuUJbR5+SblI9KbJgpZ6MMSUh7FCDiUYFhR
 Okq1YC/0kGnqBYESswRv/gcslrWlndTneknb8r7zC1DG6JbljRRATUKAySHkeVpfjIzOfvFLt
 uWWfqo6QcGTfD7W79Nsx1sdIetCyWLXWcIghq5byyVzhvUsC9NHQm3pr9rgX8q7Jz/7ra0Ake
 Tf/5r8GbPw8S8B9Gqv2p+PVhETHkhJKbuIFP22qVEL16ohl4tQXS2mwpXmysoKJTc2Qy460Cg
 tT50Ijr0MHgte5Kqk7hiJ1A3iFN5FeSWUX6HImlr/JF7yHwDE7DEUhasBuw3t8zqtep8blSAN
 gkEfNBK/jOxdp5ZGRT/SAhMYntKMx2o70wjel1VjJdW5Ix9jp5MN/7dwzhrBO10kt7Z6MX36S
 DUK3ilII9g2tMlrmaxQJTAm9YuNpL3U/zyMEUf4B3TnXMEqaRniXCs3vxkZPzw9Z3IUhBlsFu
 RPuIv7IQ3vMUL+J8+Rtjrl2dbz0SXnvzSe0XOMTu6VgYRWQ4vkUA4JuTQAZUSwO7As0v+QL0b
 6cXfd+iKSa/F8xSAzNU7Slq68qncaBaSqlI632pH8aiPYu4C23iBkL8lZytn4TM0QVS2FzsaO
 Tt4gmokhaZbRSeZxquMmtyFgPn/XOZgst+af1z9DyAg==
Subject: Re: [cocci] coccinelle: misc: secs_to_jiffies script: Create dummy
 report
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2307
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/7372f92d-9703-4b03-b048-b1d6c35895f6%40web.de>

>> I prefer to avoid a temporary workaround when a more useful solution
>> is actually simple.
>
> Markus, this is not helpful.

I got an other impression


> Either provide a fully working example

I contributed some demonstrations for selected data processing approaches.


> or stop nitpicking useful patches for projects you don't maintain.
I hope that some information can be picked up in constructive ways also fr=
om my patch reviews.

Regards,
Markus
