Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D5DC4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ORJnrR+pwrd6jZTJbJfAj3byVgzdnZKRzZ6eHl6ro2c=;
  b=azi6DYDYlsYhg+Ace40D65sZ0XYTZobpwjRT0xGEqfiKoKulYMcpVS6i
   cKHTt5bG4gdG2GChjGQDLatJQ3CVTNnkDyXhL2ONS11eVyJKBb6Gihcuh
   EKfvp3gM0b628hlZVh7MZ+EDr2lMaiCWb8dKxk761RD2hKvxoOOXtvwhv
   U=;
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
X-IronPort-AV: E=Sophos;i="6.04,230,1695679200"; 
   d="scan'208";a="138648464"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 08:55:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3CC0AE0CCE; Mon, 27 Nov 2023 08:55:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FF48E004E
	for <cocci@sympa.inria.fr>; Mon, 27 Nov 2023 08:55:11 +0100 (CET)
IronPort-SDR: 65644b5e_EMTlguhv3DoQ8K+Dg0O9nZItH10olj6wJ52TQIVphgM0oqa
 tJwe2HggWnna/AQwfMBcmBO8AmBuKa6CBtslapw==
X-IPAS-Result: =?us-ascii?q?A0ETBQClSmRlhwwR49RagQmBT4I5gVAwBAtIhFORYoQ7h?=
 =?us-ascii?q?zSHSohvgxY+DwEDAQ1BAQIEAQEDBIILgnQChykCHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDgoBBSeFaA2CXAEQgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREmAQQLCxoCJgICVwYBF?=
 =?us-ascii?q?AEBgnyCKgEDDiMHqxqBMoEBggkBAQavVR8sIlaBXwmBGi6IDQGFWYM7eicPg?=
 =?us-ascii?q?VVEgTwLgkcxPoRDg1uCaINummFdIgVCcBsDBwN/DysHBC0bBwYJFBgVIwZRB?=
 =?us-ascii?q?CghCRMSPgSBYoFRCn8/Dw4Rgj8rNjYZSIJbFQw0SnYQKgQUF4ESBGobEh43E?=
 =?us-ascii?q?RIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0UGSQsDAhoFAwMEgTMFDR4CEBoGD?=
 =?us-ascii?q?CkDAxJNAhAUAzsDAwYDCzEDBylVRAxPA2sfGB4JPAsEDB8CGx4NJyUCMkIDC?=
 =?us-ascii?q?QoFEgIWAyQWBDgRCQsrAy8GOwITDAYGCR4EDgMZKx1AAgELbT01CQsbBj4CJ?=
 =?us-ascii?q?6NJgkDGITQHgjGBX4FgDJ8jBhMvg26TNA4Gkk+IGZAnIKg0gXkkgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OOYQSj0dANTsCBwsBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:COZQ1aEb0kD4dM90pLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:VuH5XW4XXq2YzlyGPtss5AkmB9g5SEbh6Cn/fBaJAzcuSJiEcArF
X-Talos-MUID: 9a23:XPInowWMxIM5HHzq/BbqoxZHNpxZ2oe3CU1SlZMcks6mEzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,230,1695679200"; 
   d="scan'208";a="72648160"
X-MGA-submission: =?us-ascii?q?MDG+FqrPzq81soYzwdWENKa8QeWu7+WHjTSxCI?=
 =?us-ascii?q?3JomEDlXqOg0Nr2jfAWoJJEVBGAaX1vjTKlKkvONTEFNDsjpo58Hofyl?=
 =?us-ascii?q?u/Zpqd0yJWlefX2AcYrA2KzAJnb84sPTyTTI6kHXXQEerilBPJdaCS1+?=
 =?us-ascii?q?EX3CPVyzqhkHSb4SQCzw9Cwg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:55:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701071709; x=1701676509; i=markus.elfring@web.de;
	bh=ORJnrR+pwrd6jZTJbJfAj3byVgzdnZKRzZ6eHl6ro2c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=krJhz42STn/sATuAgzZ8rJsS64lhJdwEgCcOuyGqLPD5J5HbI4hqhxSaE7Twvq3U
	 fRRP75Pq9BnFxKS+Ggnssi0gIASWjOx2RlxWAYykOZut80qs8mzRuRPKk6MSSGz/3
	 xNZjO42Ob4/NlgXsk2j/cPgCdHRK9j4YG6MdCPWPfbyxIALcqnLwCqc8H0bFEICJ7
	 SnK/fA45dwSeIOXJzu69gEIEE3uK5P+o28I1s7SxTpGJLFWp9vv5HNdVhs6oxhof2
	 d8lgSWMa81uY/dWz8/YLClw1mZZClLS6RoxBtlLctw/n+CQQ1j1Mv4R8SGppWg4Xb
	 DeAvvhM8MRmfcQZ2Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1qsJt6290r-00K9Xu; Mon, 27
 Nov 2023 08:55:09 +0100
Message-ID: <c29431e3-c06e-4b29-9686-96c9dd8ca8cd@web.de>
Date: Mon, 27 Nov 2023 08:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Thierry Martinez <Thierry.Martinez@inria.fr>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <1d511f1f-4cab-433f-90dc-a6f4e9d3fa7f@web.de>
 <alpine.DEB.2.22.394.2311262136020.3149@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311262136020.3149@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iVxe+dwAgPfGCNO4tViaIM4QJ85ZClGY3hmFvDwCtL1sziwpntW
 0bdfdBFsw7lEPbJaZqlN9INz1e2XW7d92VNV1YMiKxaSN1li8YmrGrGfFdzMya6znittg4z
 rwNMWJe/vQ7pHJsLx67kk7Ii9MznocNghhuJJjE85M99Ksfd/4zjtAxdLvLcWvggjmrUmCt
 kG/CbevbKAaa1HAY3+wdQ==
UI-OutboundReport: notjunk:1;M01:P0:GO8TG3x2wxM=;zHDX0Vx+xAiq/I5lzMCAGc8uW04
 PYLYh07VghKyKgIHQmx7/ePiUBSLTqpO9PkfV/7vk0Bre2s409MRdCJFfr5KJiquZexgs9I4L
 shLizLX+mLu0FSgiJGNDjhbFbIiSOJPdyfk53j6JmRc7hniTJPJ4Dy0CL5IZf0GTd9DHXJOS+
 l2OiC16/5OniI0PaNljhG84jq8GPWAht3ny5AG6tOYUODCJE/EruKRnRfGF+kzez2gf4xANrA
 /hL4vgeQS62ENUPHlNjmrWRjy54ghoKRYkzQQv8j4j/A0VDCDs5mXc06ewjt6l/LFKSyy9K8b
 0IxjHuRB3I9LGf8G1C0a/4qao2rvNXp0LGrJRJC34+T0hUb4tqD93BvXmPyMgm/PVnnyAm2d0
 vMIl1MVvDVS4rMB/Wu9hqQ8rUXJI6xfP1wKqjBoLcPWrQ5CJlx7yEz4JumtoECSsgi5L9DS0a
 XJPOIzvlO/q7e+TTYPTX/6Zb24nWbeWPMxNVBAab5Bic8R3TeglOebwd2/tBoxM0Vf746iGb2
 XptmlMpvLpFHWxU0vjp3hZqfwcHzXxGn6XljlBzzTD9mgANEyU4LzrgxBBUy8th8XNekYENzM
 6UonFLgvB/iYBPQ3VPc0dMnNafoyq/A/eXicmSeAyrPVWqqFAded4B/91OLYEfZHWNRlgi/Bt
 tRQLM2EDaScf2zQZtzdBtV4Rx/xNUI5cuq3AvgyKPz/kcsLgSyrPB4XcfqQlchsHL4jZ52I4R
 L+Rn6E+7sqErnrW3XekGTSgs8tLpc7SSCABGmn6hRt2v6Ku3FDrvI1QmRK9ce+tSVcVQg1IsE
 WtXoZMJWzuiCLdKJvNTVVxgoHgHgawkg+rGijAh3JLiCfEjFrhjp7Y3S10RFUhxOXj8s9Cf/t
 FStpNTy+ZCSrYlFUT6OKrFek38TJiZcqWh8yBfpr30mth1gM+0Y2NBIAPpZf7OkyGGHUqM8uQ
 ZwSH1g==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1338
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/c29431e3-c06e-4b29-9686-96c9dd8ca8cd%40web.de>

>> Would you like to reconsider the representation of shown number attribu=
tes
>> as text strings (instead of integers)?
>>
>> How do you think about to enable the usage of an integral data type her=
e?
>
> I odn't want to change the interface.

Can any other developers convince you better to consider further
software adjustment possibilities?


> If you want numbers, use OCaml.

The properties of the supported programming languages influence
their attractivity for more desirable developments.

Regards,
Markus
