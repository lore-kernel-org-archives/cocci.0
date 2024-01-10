Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD424C4707C
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WJLANyZp27oOjkLtJ3W+7MOt8eyrI+brpvf7Q5Jr6ts=;
  b=OgMWIlmcPhH4lqB488UzJJn88PHHVZQmbX6ywNmco0yB68IqsiDipKZw
   VcjI2er3XE0VcxdqXlao3JoGvpEMn++qdz/Ye35125r4PPOAeH2hYe8rU
   I3aOQPUb48ijE0nST4Tg7bJ2hHEZtXXHb+5/1N11h90Lvl/6jfdl7LBik
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
   d="scan'208";a="145865859"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 13:24:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB60CE0CCA; Wed, 10 Jan 2024 13:24:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA6E9E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 13:24:46 +0100 (CET)
IronPort-SDR: 659e8c8e_WLAErO4FnxqXlPoxxPBZKK7i8VRYfmaRAPd2Z8yZzyxyzR7
 ZDKbC1+ordCFm2E9XbcQCAYS44k9fh3y4F5SUsQ==
X-IPAS-Result: =?us-ascii?q?A0HUAABKi55lewwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYI4fFYyBAtIhFORNjCEO48BiG+BaoEsPg8BAwENOwYBAgQBAQMDA?=
 =?us-ascii?q?TiERwKHPQIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABASQYBg4FCyeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAg06QgECAgEjHQEBESYBBAsLFAYCERUCAlYGA?=
 =?us-ascii?q?RICAQGCfAGCKgEDDiMHDQa1aIEygQGCCgEBBoFFAgwCQ06sch8sIlaBYAMGg?=
 =?us-ascii?q?RouAYgaAYVng0F6Jw+BVUSBPAuCeD6CYQOBGIEGgxyCaIIag0KKHIYGUn8dA?=
 =?us-ascii?q?4EFBFwPGw8eNxEQBQ4NAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEg?=
 =?us-ascii?q?TAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwLBAwaAhseD?=
 =?us-ascii?q?ScjAixCAxEFEAIWAyQWBDQRCQsmAyoGOAISDAYGCV0mBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?3QRAwQKAxQHCwd7gRcDGSsdQAIBC209NQYDCxsGPQKVKgGCOoEOKgKCE5M6s?=
 =?us-ascii?q?X40B4I0gWCBYQyKGJUTBhMvg24TkyUOBpJULodQkE8ggjGJI4F2mnyBeSSBX?=
 =?us-ascii?q?DMaJIM2TwMZD44ghCuBC4NWimZANQI5AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 xZamdvF
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zY8vcaGt0/iEClFTpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:bPw48WM8p/hE/+5DH25Nqx4eHf4fMSfcl1PALBHnJWtkR+jA
X-Talos-MUID: 9a23:QoKFMwT+Igf/EovfRXTwinJbOs1BwJ+gK24nwYgAkPmnHhNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76374511"
X-MGA-submission: =?us-ascii?q?MDGCaflH93cM6JrR+LIgFzopchm/Nd24gmVZBD?=
 =?us-ascii?q?VQz4CCvUlf6huGkiPPM4KV1NiiyWFyEeqt0qV6BE6toCiwb8QdVEPZCD?=
 =?us-ascii?q?RKM9XCYPd/LATPznI8pmZ6deqKFxliVF8oSkHk152+9sWBtEYMTECYf4?=
 =?us-ascii?q?2ZoomVyfaYC3c3pSdStmocrQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:24:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704889484; x=1705494284; i=markus.elfring@web.de;
	bh=bXp9XOuj6G+aa6cVL5p/nkG2HouNiljoh8dMsE9hawc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=CIw97ZXIc9n7csZuHa9z4MMezFc727wM79+WbJaWTxJEjJ5GQ8p2j90Rc8g+adWW
	 gZfPzaB1tSy5wVXgIZf3O11XSXQ0qvWyd7RaSEP+CmiizYqLgXA9dUy4b5E+KZJ/8
	 1bDe2Gwzf5U03Grb/ZiHwtY6zvmI+QzGe1ngjy3sO8OlUsUW8ZUxvB9MinNR2tNGk
	 QPzf37nt2lJHab1UQk8U1uz71gyF690f3DJ5rXv6oaHmzyv33ue9C9LOV3UOKb1DA
	 9pZhfgJtWLAV4yGLXUpdUXBT99OQVCXPweo8sG0rvpv6dhBE4ai8ao3U+nz0h0rDP
	 aiVsCYi0vHkf0hMW+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1rGwzs1r9U-006mUy; Wed, 10
 Jan 2024 13:24:44 +0100
Message-ID: <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
Date: Wed, 10 Jan 2024 13:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
In-Reply-To: <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EFc8wEm4ecn7ET0ZeDrJeCmtaQ5q+qZHT1q9bxX2hqXmf59juQz
 frV7MfqpX+Bzk+dQoiJQ7bji0glMW281Q3d61kktmMMpjqNwr1eohcdiOt+1L25fdpi39ip
 GKjxeAMKwnicNKOCmCnDbMr0RR0ag3fIC50Vq5fNN/dCsr9wLnHKJDZzOxnAYYq99kJl7nK
 lD9TisiwPinlJS/RRU2OA==
UI-OutboundReport: notjunk:1;M01:P0:kyXWa+brFZU=;uE/SlU8sSswPYj8UlkyLq93xLiN
 meQAsWIocCtqAM8u2LzFrosS8O29zsmjByZt4Vdge7z+Vom3rJE+fHrgWsfje8aT4Or9HZVER
 NWatVPVjlYoe89VcNBtm46Z6OmjI/oPlrsCmcQjqbyFEUec0fjfBQGyMhwsqUxhjT39rkIumq
 JIr97/NHFXpGQE9ODo9HQxaPiM3G04hajufhhnLevIw04VJcAykER6v2VgpiC+AL6mmWRf2Be
 KBe4UiGzSGTY1fhbuvrRl1jPnu1Sh7/19JzfOZk/A4BAvuvchNBtpJvq/HGbizJ+CP+IgWapt
 3d/fVpmRS9WG0vLYPTnS68ULA5vXIRc1yksCezPCj3zd9SSwpUV7HhyHe+LT0rF58LPvimhBn
 HgrSbbvQhpW6JdCnStPsvmgfgHLJbIn8CnP2lMLHR9v04fNNIkhklIVFPW2XNlPKruC909cfZ
 r+/I744A/oFJGOsQ4GtpsMe1CQkrXoe2tNKXHAVoh86jraggNR/B1h8s6ly+KogsmH/Ph9dOO
 shwHU2WGxTgHRWGQIh7uEVCEIjFue6gv97g0wCqqqgfjw8kfqYSjR5874UTg/lPpwy1Vm9reH
 u4wMycbD4GBF0lH9WLTb94DwvE5Ti08GB1fcUkg+elxn6cyACP1wKNJDjXD0KJavAIH9O6pJR
 wDbLCp7aKntT+VwTOqcdGLFuoJDpC379kQ1vWNxG+VaYn6c6fiKptxhbGpdjoxqplvrb4K7m2
 2MtDTR8f89pHwfxftrq/stZD+y2t9qIBGCNV7gC4pcjJyihwnU+bqR+KdVhLdW4bWQyhwoBAP
 iBBYfASNbWMh1ccejUyq5rtVpIoKaz+HpdtXnX2xWHZFI2Hv4IvIQvS7NAmCM1XKZ4BkZT/gK
 tR7wQxvKjUTdkM9U6JY6Ggws/jovMlTWqsyZ6zzfNFAfODJpoGBIn8GsDeZAsdaZ+FCqu7ISg
 6rAaLQ==
Subject: Re: [cocci] [PATCH 0/4] overlayfs: Adjustments for ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1449
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/05d334af-1a0f-4498-b57d-36a783288f07%40web.de>

> Date: Thu, 30 Mar 2023 10:38:23 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Return directly for two checks
>   Improve two size determinations
>   Improve exception handling
>   Move some assignments for the variable =E2=80=9Cerr=E2=80=9D
>
>  fs/overlayfs/super.c | 72 ++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 33 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html

Regards,
Markus
