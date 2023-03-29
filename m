Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1B1C74A5B
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j8Vby7NMTMFIeYwfiC2NxLYZ8xNsPGiWAvwuencamjY=;
  b=tMbsz0zSUX6HkGyWOzRq6PInCO5V5ceWfEUOieikg4Xr7lTwMjjLSqXT
   pHhd1ovJ37tFsQ8Dp8m1ze4NfFxVToK+5L46lln2sehUkN92kw611ea+s
   ZcRxR7rSMc5DKE5zjYu2e7DPM2dkaPmPENkV1OfOkSbt3SL5w8HyUxk7V
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99721968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 15:37:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9849E0B4F; Wed, 29 Mar 2023 15:37:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F026E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 15:37:12 +0200 (CEST)
IronPort-SDR: 64243f07_isVQZkMLH4+UrcKzv6O+oXz/AxfxLftPwNzNuRVturXeQL2
 pD2r5FiaZ3qAIAFyPjrJ5f0hVzDS3ZRIFRH73CA==
X-IPAS-Result: =?us-ascii?q?A0GIAABsPiRkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORATGEL4cshzqIaYFqgSw+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiERgKFOQIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB61lgTKBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC0BjQSEMCcPgVVEgTyDQYN9gQaDGYJngimXH?=
 =?us-ascii?q?gqBNHOBIA6BPYEEAgkCEWuBEghrgXxAAg1kCw5xgUoCZEyBISUEDgMZKx1AA?=
 =?us-ascii?q?gELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYbNBECCA8SDyxEDkI3NBMGX?=
 =?us-ascii?q?AEpCw4RA1CBRwSBDXwKBgEmJJ1pgQ6VTpJAng40B4IogVWBWQyfDAYTLoNqA?=
 =?us-ascii?q?RKTCw4GkiMulzwggi6lTIF5JIFcMxokgzZPAxkPjiAZhAyPSD80OwIHCwEBA?=
 =?us-ascii?q?wmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9173mjTxEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:05mBX6H+pC5PQnMApLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99721956"
X-MGA-submission: =?us-ascii?q?MDFUE0nkAESxw8xcN3GdjZM/Fr8rPJ3XcqPL+y?=
 =?us-ascii?q?6gxuqSxYgsir9EYvKnZUTiPRg57tRqizJPuXjdE0oAknwTiZtjexn7ED?=
 =?us-ascii?q?YNGjHWM/GlaAVR1hr2Xq12z240yACUk4Qeb94hZuWWhoEZ+yPMBvCLiA?=
 =?us-ascii?q?Zu8hQp9WyOVT6AwdrwBAlqZA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:37:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680097020; i=markus.elfring@web.de;
	bh=uitMQdcEuLziYi5MTWu1izvpI93iiFxtgonP2kypPMk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=PLO2fA6745Y2/BP54picWIsjH2oNFIZ7z37I2o165maPuURCdl6r2NEKm3wiMGQM7
	 8WMsFS0DPtyZ+nAyMeS39WtZ7+kp5GFW/DYiEBFsg6qwai0xx9pmKBPOY9H6kTQS3+
	 oaRB8GqwbUtmw9sN1L42siQVZ6dsAt3qE6n0mfujFS5zjZEJtpxIDb6wHg4IHG7aXx
	 DXME5m1EA2WGE93KqRsCr5xRXOWVAT0eicVJSXDp0+vRvWESbuAOquo9UZAMTU1QVQ
	 c0THxs2KSjf54UwH3C0Nb5CQ2CFTLW64PO8DAa9N6S7G5T1UicWFT3VCehJRB2At1Y
	 CtA05hB4KuN4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1pZEFC254c-009OQL; Wed, 29
 Mar 2023 15:37:00 +0200
Message-ID: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Date: Wed, 29 Mar 2023 15:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyO7Nh/CEb9UXMgsFSDVpko2Eg7SYs8n0tlLs79yugOt3DIGLvs
 Xo2QEc88mtQj+ENImXjc2qBJkcN2DeVH1iZ0TprusKYoMR2oqdR5d/uEQEahiylrKvFz4iE
 vrSSmrC0lIYYXMbnYHhAgHm9o54ne7hJpOMrdPn/bVDC/GLjl4OVL1QCOXtpBXYy2c/fiJ5
 RyLdJAbhXsvd8PqLpB69A==
UI-OutboundReport: notjunk:1;M01:P0:XlK6+JoBPsQ=;ZN2aXo8qL5ywfvX1b1offvkATJh
 s5pxNpmsaXIm+0VYQ2Gx0OV9/ZZe62d5uNOB+kFM96+4lkxpjHQ5Hpt08VSW8aezXK59vBdmz
 EcfQgSQ3buO7nn3L+rYLBvpIQcHOhPTAq67rECEPgiK82eC45Dv18qABNQ6A7cl2dWzuUMLO5
 u9utYb/DFbM3ER8WUu6qncAHwJKhkWCk2CtZ+YQwZ45lAFkBynz+kFGukC9pBRCHfuRXJCpXp
 +IcCc08DKG1sQlUB+fi4TsHc7H7H/nHHjPIsHgqzc0obajRInhVpok2mp3OO0MBCHRWuxiqQG
 MXWaVZkVQ5XE4wY8WVU1Y8tWGs9ucArUDOqHxI9jHym3pgq/SRb9NDcT1knXp8hkZAXxdyYVc
 1EJtPZ36VRvXSrxHsMYNG7rSgORPMtvNkQQ4EC+E9PoA3IRuRfFrqpS8w3wKa/Bst8sRxAW8/
 TNuIpBt/GcqoTbV5k2hKosiynYMbJwasol7JUbdGTkCxTjeNsV1ThC/X0/J8a1VW8xp9NjBLg
 nn8d5XuQi1VBLg8wAjwGrSimGyx0IbeZKq/j76d/RO8kQfCOfxctXL72ICXQwn2AO2IrdycN+
 DZDO4tNmLUxze6t4lS4TtZKagtZLbtvOfPeNP8+/WyX6hWZzw4wfPhRBeaBhhCenNZfnjJcOw
 dS6DRGoWAZ+y0IcqwVp3wj1pySK2jGgSAlppK4AihkukEG5/JuAPgaaxQ4p7ZXPeEVAc5nH9w
 Ng5STCT7GB8DbKXY8phq3XSNAp2EtVkROdVO1Fw566BYeG2eXy6+0QSpRDJKQ0MO92R3P/iOk
 3oyEZak+S89VRNtm3j70+K49n70rTq/vJPp3arY2iMvg9jbJ7tx+LtMmbXRYQOklkAVVesR6T
 hzuhamj92b3Vye559O8ox2EUY/ZxBEyaB79b8CCh/LMC+kmh7q21J9g1B
Subject: [cocci] [PATCH 0/3] lru_cache: Adjustments for lc_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 983
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/33226beb-4fe2-3da5-5d69-a33e683dec57%40web.de>

Date: Wed, 29 Mar 2023 15:30:23 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed kzalloc()
  Improve two size determinations
  Improve exception handling

 lib/lru_cache.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

=2D-
2.40.0

