Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F836CD1288
	for <cocci@archiver.kernel.org>; Fri, 29 Mar 2024 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TEsgrH7TN7tGhcXfBsX44PFL70i5yhacsaYeVuP3mP4=;
  b=SWRuou6uIbHa0nsWRcQvyrN1Bwz8fJs2zcxWC+vCDdO+bhVz7F3U/PIQ
   mrd72q7kNClCIrrjlvw9hGwooKOLucKZDXuWPayEcbt9UL0296BlNPP8h
   mE8mvkXQWwbAjA1WJWApHf2cSXw1rw8HolFAYi25keX8+QCMCLxfxgKcv
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="159045140"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2024 08:15:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24F04E0AF6; Fri, 29 Mar 2024 08:15:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EAD37E0131
	for <cocci@sympa.inria.fr>; Fri, 29 Mar 2024 08:15:32 +0100 (CET)
IronPort-SDR: 66066a94_fZLjkTUASQ91V+8Lo2H9Wc1bQhdvPdLsVk/DeEyO71rktYL
 vYPfM9vZ2L/lGTWhNtZvQ0WVbgaDBVaWUrO5SPA==
X-IPAS-Result: =?us-ascii?q?A0EqAQCtaAZmhk7ASNlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4fANTMgQLSIRWj0WCJYQ7jwaMBj4PAQMBDTsGAQIEAQEDAwGCC4JrCQKIB?=
 =?us-ascii?q?gIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEhG?=
 =?us-ascii?q?QcOECeFbQ2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAkdCAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBAYJ8AYIqA?=
 =?us-ascii?q?QMOIwcNsgiBMoEBggoBAQavXB8sIleBYQMGgRouAYgmAYo0Jw+BVUSBPAuCe?=
 =?us-ascii?q?D6IHoJohU2galR+HAOBBQRaDRsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FV?=
 =?us-ascii?q?ANDBkgLAwIaBQMDBIEuBQsaAhAaBgwoAwMSSQIQFAM4AwMGAwoxLk9BDFADZ?=
 =?us-ascii?q?B8xCTwPDBoCGxQNJCMCLD4DCQoQAhYDHRYEMhEJCyYDKgY5AhIMBgYGXCAWC?=
 =?us-ascii?q?QQjAwgEA1ADIHARAwQaBAsHdoIAgT0EE0QDEIEyihYMgzMpgVAphDgIQ3QVA?=
 =?us-ascii?q?0QdQAIBC209NQkLGwYiAR2lIQGEJ6ZaoR40B4I2gWCBYQyKH5UiBhMvg3IBk?=
 =?us-ascii?q?0MOBpJmmGKNc5sQgXokgVwzGiSDNk8DGQ+OIAwNCYQLgQugXEI1CzACBwsBA?=
 =?us-ascii?q?QMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:bEiQk6m7mbQ3YEZ5xU5XIcNtYELpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:mks1jGDvakPgx1D6Ew5FrmEtFJ8+TiPAnErOElSiNjpZSKLAHA==
X-Talos-MUID: 9a23:kP0ljgTUZYgsWqCIRXTAijFBFMA05p6OUhocwbUinPOcMjFvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,164,1708383600"; 
   d="scan'208";a="83404007"
X-MGA-submission: =?us-ascii?q?MDG5t4soCzfZ4qroXcmJk5Sr/gTyCeHypYb3De?=
 =?us-ascii?q?8FKcEgm11kdBOAnI5zH/KaSsjPz7n7mbRL5vVO3KkT0n9pl5lP6EEJLI?=
 =?us-ascii?q?gG+DDjco0k3+IRaXr7x4S07knz7BV0m60lpj8Fs2KT71hefm/FCq79HP?=
 =?us-ascii?q?5R+MNEi3DvdfzCDeXVuPpuPw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:15:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711696530; x=1712301330; i=markus.elfring@web.de;
	bh=TEsgrH7TN7tGhcXfBsX44PFL70i5yhacsaYeVuP3mP4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=mXqKCMXbG9zJZIYLtS48QrtyZgApy2PYpDcb8u6w3o97A1j7I0v5CoQBnPMNd7M0
	 1b5/nDyg+CBHwuR+CbcuhEg/SzFALJ6+YwUJy0R6GG/ERGnD5bjMADMXqhLxuGoPf
	 QjyJaD/MRiL0KPUI2IKx5imJCXn8AgUwEMBdg1LineCa/aSh7q6AMLs7pqODEAwBT
	 5OgYt7c9FF2SufU/h7TBtUFnylxvqFhmCxnpxcSANWdB6EnmrIvMITCCmfiQbFURi
	 3ZZ8PRgMiX5E17g2UabOOGfxpm/ZF2F9iep4IITaXbmKE6Qr8FMS3XLHjahVHRcQV
	 5xr4/I2MiKDVBETriA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1s3YrT3e6r-00DCT2; Fri, 29
 Mar 2024 08:15:30 +0100
Message-ID: <8f03f7f8-3248-4e21-b725-1ff767f0fc1b@web.de>
Date: Fri, 29 Mar 2024 08:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m+dou/fIvt+IBx2RSqgHLniCjKhdHvudo/eCzU6Qvsgx8anXHoy
 aXDbcBCmSqWeNVHi9A3PJu/2ePZNHKAFa5Wn+3iT3IxcT+OTHvbswKuFG9xAAJPGNN/4/VC
 OaPAOrQyn5XcERt2x0iJy0WT2CP7JYyDthDSeTammySzk50qOpXRrsjjZ6qiX9/VDri2Qvz
 3lrVa4S4D8YDQGYZOqWbw==
UI-OutboundReport: notjunk:1;M01:P0:HyPqlEFqE6w=;t/x9fNNVsih511/HItQqIIlHZWA
 7Ve263FRk1cQIHeio+ptiVJZAdeD2VGN9XqDpGr/PhWUpbkTs2PIH1mr2pVgAFLj/pSGyC8xX
 7rIrie1qaEVwpo7aGRUQHczYfg3j7TlF6XUoZ61xLp/hsxX89DK4e6tsdUyUetOGrnCNNX/1T
 ADj1yBm6Ae85BXfSlA5LNi9S/N/Mta+6k2bEGT1toDP26yq7gWrLAwJD1i0pM/wY34DFrx5at
 g0fZz2wgqw5koDSFXCLuzIRnzePbzwOdsQbq5yo6aIIM1izuXz/w+Tkjtvp8l/13kD1oGNulz
 a5YkLhdE5bUOqSsnW/FAJaZX/cIcyEhWDe1Sqll9x8GgvIYvyURX/gGaqK+pN7gvJbbhBRSAu
 1bAetvg7c98JqPIklHTvmuqx9kPwWkEKVxEqCcTGxpcpU9rrpS+K7QhdqC4xgmqkEm0QFRCiV
 ml7N2AeTrjQ98XoOpPRGByKitr+gqz2mCL8+eg79Ttfjc4bufyRIycGOaD2Chxa1HDlVqKWyK
 4auk+b5z1WCmdHjQed1rt5fRYoKqKciIiVFrDkARqxPsHGB2KleoxDskPVoYt7UL8XkjqTn9h
 i4KlU6QTIN8ySKMZLSYTspO+aAFZXU9wl190cjrG8VnkHobYkOcLpkzuPzKf4gz/fgWlE+hRt
 nMwhkHUCSzTrG3t0Uu7ATRdRpqkVJbjSMzRGc0Af4Oe2AdoWqINb8s9Krbrr8Z8Ta+Us+4ZdM
 VkFApEAXT2EOUe/DPr9k6CcaepLHTZFADF+cUrF2GeMH1Ftn7HuKxAhMoY9adXh7TSpCLSsoz
 tDcIA3nryHmPxJJXjwkm1BU5fL9sY4YR4lMnqgkUvByFQ=
Subject: Re: [cocci] Version 1.2 released
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1632
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/8f03f7f8-3248-4e21-b725-1ff767f0fc1b%40web.de>

> There is a new version, 1.2.

Will it become helpful to extend such information?

How many changes did lead to the release of this software revision?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/969cb12e9e9b7d4f42c2ff15296fd927f1ba63af

Regards,
Markus
