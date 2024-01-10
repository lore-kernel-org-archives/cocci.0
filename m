Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97600C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lSnuZ3wdaK0bvUSaE4uDlhXcA/XlQpN/jqaLQJSMadg=;
  b=U9PdOip0xBZI2ZxjtKt4lasVGMf1ZP3PzcWwGSN7YDJIlikHPmzpNiAB
   nqwnfV/kLSGL86lIdz8jnSbUJqfPspGShSYtfXKhWqzC70AZs6bW5wFOI
   tnK0LqvKNRKqZLk5K494L1RGE1Y77ip7Nm3zpKyzW+BoB1Tr6zNUVvb8W
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
   d="scan'208";a="145845632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 11:58:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DA1FE0CCF; Wed, 10 Jan 2024 11:58:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 803E9E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 11:58:31 +0100 (CET)
IronPort-SDR: 659e7856_Smd4ephk7JT627ZZnRzcmGuUBoxHDSNdkGAUCj+m9Y/sSxD
 vaDauA5cI5MMosT0Oi1KMZCbI7CTCMpndxW7l5A==
X-IPAS-Result: =?us-ascii?q?A0HIAABPd55le07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4I5fFYyBAtIhFORNi0DhDuPAYRrhASDFj4PAQMBDTsGAQIEAQEDA?=
 =?us-ascii?q?wGCC4J0Aoc9Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEkGAYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAg06QgECAgEjHQEBESYBDwsODAImAgJWBgESA?=
 =?us-ascii?q?gEBgnwBgioBAw4jBw0GtiqBMoEBggoBAQaBRQIMAkOtQB8sIlaBYAMGgRoui?=
 =?us-ascii?q?BsBhWeDQXonD4FVRIEVJwuCeD6CYQOBX4NbgmiFXJAiUn8dA4EFBFwPGw8eN?=
 =?us-ascii?q?xEQBQ4NAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGD?=
 =?us-ascii?q?CYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8YGgk8DwwaAhseDScjAixCAxEFE?=
 =?us-ascii?q?AIWAyQWBDQRCQsmAyoGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHC?=
 =?us-ascii?q?wd7gRcDGSsdQAIBC209NQYDCxsGPQKVKgGBR2xaKD0CIAIkxwU0B4I0gWCBY?=
 =?us-ascii?q?QyKGJUTBhMvlyYOBpJULodQkE8gi1SBdpp8gXojgVwzGiSDNk8DGQ+OIDiDc?=
 =?us-ascii?q?4ELg1aKKAE9QDUCOQIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ch1TTKvdH28xg42vWO5u2LwN7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:x273qm91OuQLwgy0yJeVv3cdQeAcbUTw92XZJFbgCjt2ab2bR1DFrQ==
X-Talos-MUID: 9a23:GVJzdwgFQjaF7C+mleua18MpNfdjuYSQC10xqIg5gZmVDTRTBj2hg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76364176"
X-MGA-submission: =?us-ascii?q?MDEyug4j+n49jels+5TCZXf1UtSQEvnENOC79e?=
 =?us-ascii?q?umyIkM7yzuAlNNIK/P+8+mvMkvU4qRAXIWYo42z/526AZ5rK7V6wdroF?=
 =?us-ascii?q?rdJy8nFAFT4CjY1YOQPoRE+bq9mlyfsX0Lz+odCTTTUBYIHqVNNJ2yby?=
 =?us-ascii?q?RVl8GtoUsLOPFRFMam9jSSnQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 11:58:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704884304; x=1705489104; i=markus.elfring@web.de;
	bh=tY5224BW7/3IjkY5UwNCaDae9HcTzJg5/+WPa3JcuU4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SDpSBKZAnOLO3DFkJSvDRCP293a6xEV68IB5KjSUmeLQn5G4RGABZ7Pd5CyWKf4I
	 Q2sE5dWpeDpbOqiDad3drrZks7wKlPPPiCr6DgxUJ1tEusfbAqjNHWk5cfMLkoCc4
	 URHjcWQ4vtPw7lAGih6Vnzv7VG1lY53DpYE4COO8srVccjcJLs8HXvxY+jp57zre3
	 45F612Ya5EPcj6WejT+ac55rk78BY+achTNU7vrJ0TxxVuzhqj34Bq8QiJnwehq9t
	 1XQpn90idWpEEKbpmvCDLfDKrKVzZ2Qatr8snAvQ6OXtATlynlIzFp5t3ZbqFEHlJ
	 sfBoaPM8vTSGBxjnHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1rbCKE26Pu-00LvHW; Wed, 10
 Jan 2024 11:58:24 +0100
Message-ID: <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
Date: Wed, 10 Jan 2024 11:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "cocci@inria.fr" <cocci@inria.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KCTONhzZ1zvlF5SZjQrJ7BayTBtq1VFeyAJQcMCYzcZztdwB970
 tEgvF8y4qMkcyeF40hwN74l8dTUTfEuqSbmmuIziS5yNHZbcp6Fw7IWEGTXtO3+M3+lw0DA
 DmLy5NDffGEuZW00nKLPaCCVV63M3VxI9TKeohJLxoXysSNiz2p58g4OTXbXmRZJIXzRJ+2
 IXj5ko0xyxr8zm9N/277A==
UI-OutboundReport: notjunk:1;M01:P0:8VsTKgjF7kw=;gQzASWqNdbCpILehGdiYjzn+qi4
 Br75jSeb/C5j0J96bJCnxCHa5kEwVCBf/zernQWtcDavb6tASaSu8+X5ACzeCO3MrknR+5upl
 wxCh8AciATerCMiC9WbikoycuNIpYW2Lg0U2Kq/mUQbpxIAWBD1U8I84p4Pnw7x7JemDS2tbj
 NS4Pa7zZ+Sp4ogozFvgNj8RZyEz9VAAQ32Y5uT1qsxfIaUAMK2CxiNT7lyFOKccZTny86yAv7
 1p3jzyENhzS4nqKzPznntbcjur6R65yu0WVYh46jAmHJsA02FDxjGLfciqd51zE0diCYORJA/
 ZD7hj3pJVDlavAG7LtMBuoiGcpgHKmXxRduvYbAsOYWedeGG3nKyzv+x5yiri+Bf3xIaos+aK
 7VfbEyMHB0/nLhibxGvQrZaLp65/BU1W/Rt9owh+WvQ7nflWwIYIYFeNHwL+c52oaxql2Cu47
 yUldPpDTBzK14O8ze5lIJNk941HpeqlFfhAPqVnwTOhcxSCstmJuGZyoWK2j+n0iwrBaemS+9
 qLRY9FEe6C9ADF7cVhzn9s+0RbNFAF4wekeyJorapvQlQytgeJtoVBtRx5MPtlSg+Bi7spPNt
 MBm/KC1sxlPUQQYq5hl7aZUhCW2WdHw7zVQvLgDXdND9bhlogJNnFLsfjV1CDVz89MTlPjEsg
 LjHWoqFRKVLTXSitUcAWCk6u1cZXP3Md71eUHTueQjTY21+lzwacl970ZfyaEIsa75rQ16823
 cSaD11Fh4n3VysK9nDfsGXNJPw/aLJZY4xOVtBV+4wkZ2stwUpNuyoS7Q+GRfjMJu2Oge/shX
 VRiwrs8YgydN+mJv4GMSglRkzFkTwdKTEStolt0+swgKtkmNOkxmb+WE7wJY0imnBLTZCJUA4
 QqlziK/M4gU48REOqJt5YG9EUdefuK3VRjfQoW5Ya7fT+KLVzv+8Ycr1gJmv/3VVAq7zM6lAP
 WVWJjmrSYW+NP9vEXdm6pqgj0Lc=
Subject: Re: [cocci] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1443
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/82054a0a-72e5-45b2-8808-e411a9587406%40web.de>

>> The kfree() function was called in two cases by
>> the create_gpadl_header() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>>
>> Thus use another label.
>
> Interestingly, there's a third case in this function where
> "goto nomem" is done, and in this case, msgbody is NULL.
> Does Coccinelle not complain about that case as well?
>
> As I'm sure you know, the code is correct as is, because kfree()
> checks for a NULL argument.  So this is really an exercise in
> making Coccinelle happy.  To me, the additional label is
> incremental complexity for someone to deal with when
> reading the code at some time in the future.  So I'd vote for
> leaving the code as is.  But it's not a big deal either way.  I
> can see you've been cleaning up a lot of Coccinelle-reported
> issues across the kernel, most of which result in code
> simplifications.  If leaving this unchanged causes you problems,
> then I won't object (though perhaps that 3rd "goto nomem"
> should be dealt with as well for consistency).

How do you think about the clarification approach
=E2=80=9CReconsidering kfree() calls for null pointers (with SmPL)=E2=80=
=9D?
https://lore.kernel.org/cocci/6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00096.html

Regards,
Markus
