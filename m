Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D821C761A6
	for <cocci@archiver.kernel.org>; Thu,  6 Apr 2023 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=43rztnEeDzdN1kfEWlxnw/R5r3XD7FJExQPPpOkPgv0=;
  b=L7dBDebASmEgcnSCdjprTVGzpyyKEJ2Df1XidNteAeWEqthjZsHWVNPx
   naCL3oNAm7p8UU7qieJHRMpV/YXDwarAHtckDycplzWWfnk3gH/itEiDb
   2d8sDL1FYmWEFJWrAWfrCNFGwDooV4Zg0F3HjzhGDKsO9PjTRpxXKXlAX
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="101231785"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2023 18:13:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08B72E03AC; Thu,  6 Apr 2023 18:13:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CFD88E0157
	for <cocci@sympa.inria.fr>; Thu,  6 Apr 2023 18:13:00 +0200 (CEST)
IronPort-SDR: 642eef8c_C6x0SsNbri83VsqEvGDsYfaE3VvBgRZalGXwyun+c6gqBIn
 2PuszOkSHgEeL1j5zIWpfq4dEeotWYUXmIq75Dw==
X-IPAS-Result: =?us-ascii?q?A0EpAABD7i5khk7ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiMYQvhy6HPohrgVYUgSw+DwEDAQ1BAQIEAQEDBDiER?=
 =?us-ascii?q?wKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEYCRkHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kc+AwMjHQEBESYBDx8GAhEVAgJXBgEMCAEBgnqCKAEDMQetOoEygQGCCAEBB?=
 =?us-ascii?q?oJjmSgfLCJUgV4JgRQtAY0JhDAnD4FVRIE8DIM1g32BBoMcgmeaJwqBNHaBI?=
 =?us-ascii?q?A6BPYEEAgkCEWuBEAhqgXlAAg1kCw5vgUpjTIF7BAIUGyUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA0+BRgSBCoEBBgEmJJ5SAYENxis0B4IqgVaBWQyfDQYTL4NqARKTDA4Gk?=
 =?us-ascii?q?iUul0Uggi6lUYFjOoFcMxokgzZPAxkPjiAZhAyPCQE+PzQ9AgcLAQEDCYVGA?=
 =?us-ascii?q?QGFfQEB?=
IronPort-PHdr: A9a23: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
 9igoiAYsz8=
IronPort-Data: A9a23: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
 t0AgKvOxBgRhQh5TCg=
IronPort-HdrOrdr: A9a23:6C473KiTmvCghjlOO8Pt2tT7T3BQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW21dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,323,1673910000"; 
   d="scan'208";a="52387399"
X-MGA-submission: =?us-ascii?q?MDGLf+hbDZqG+jrgjKrq0pwZYKgOAU05gaTG1Y?=
 =?us-ascii?q?3eyriaHB/WLLh+pSyykXtLBeHuQesd9+XpPipI8I6k7L11cTcq/P+EZm?=
 =?us-ascii?q?6MFdNeWf6GMGv6fOu4x1C7ggI8kbHS2kGiQvUNwJqoq5xiXRxJ4xi9KH?=
 =?us-ascii?q?LGmomtTni4+xa70LHnI9MQoA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680797564; i=markus.elfring@web.de;
	bh=izk4aswtb3LSJRv1HyvsoVfsM84BtOoRspn/NDkX6sA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=FjUzt6c737B+J2z0CwmE3cLD2gV1bmPZ/o4IxzmxXnlFkcvN5okT6Eg0HJuBjzCEo
	 BgM60xtkiFK1TGbIBjpeF7TfjK+FXFAHSstRoZzjUOyphccTbp11k5ing1oPYKSmyn
	 dystuYNq1cXnW0EIHM1hCRo9fylDdUV5XNO2bAdu0n06KngtuH+c1bJVaNs9R8sHaM
	 wVC459MLEUvJeuB5Elha38iJrHEdMf9mLzGwEMdSGlc/gl0JjBm/e4BYbsJMe/DuGo
	 fRBts6QtbEa3bThMrDaAQWk81NGVUEuoGxca9XLLEUFZjH03R7T0MlxyVo2FS6MFK/
	 3lBaXg4xSuSkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1qK4Di2FQc-00hteC; Thu, 06
 Apr 2023 18:12:44 +0200
Message-ID: <01af2ec9-4758-1fe6-0d74-b30b95c3e9a5@web.de>
Date: Thu, 6 Apr 2023 18:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Matan Barak <matanb@mellanox.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Yishai Hadas <yishaih@mellanox.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DhD2hgFz15BLCxp3I3FGE7+D7QH9dhfqN8DbsPxGNtsAySB0cHy
 cjJ5AKVvkMYepfB9gKTZszwduEy2MOIGZ+FE5AwblmDie802qpQZMYex3p222brRCg4j0Yl
 7+vakmF++aB2QRT0vJ96k5bLt2mFcc6iniTf+dlQR0lhmbfAPmpIrq7VyGjAUi8g1VzD593
 vDmAhKCdII67iQihHqSeg==
UI-OutboundReport: notjunk:1;M01:P0:szVZ2DPqJDo=;Cl8wuPep9W6iCbOga1cGG79Wys4
 +KSbu9ZdYILkLkCDFzjCL2Dzo2S6lCHd74AoV7VLOT8mmd6M7tertU9TQObPkNubWZL7CU8Q9
 f+idlVp3Js2KwbIMJnISei75GuZ2adugjBQ5R7FwEK2KQKA8aaDTPhI4zkibCDD5x+IbWki8A
 oDQBh+uzvizGHVbIBD9N9gor+EX+slCvRe6b6n/VW/4UtalN62MbVB5BnwKUSkk4MYPYOb8AK
 UPWtqc1yOTUhk1wAKTW4YToHky0SySgsnmGodBUtAO714XOCgZU5MW1avhtLbWhx6VZaZC9TH
 Dmpf8E3IIGFSMHO3rkL7/0pmKfk59CxcHOaKVYRwFHUkjG28nCyDCaCCM2yM8XTckZyCWBGcO
 xjEW/PkNPmx1pkbxDJAKq2cLowMpIQHSP5Kifg4XUD4SefYqvjgFLyTZqR7LqDbA2nPYXZaNv
 AFSw+H6gkA+ybZE8/Y+9kU70gVZ+0M89HYB5nSqhzh8mhvr9TyHmSxEHjsmj51yW8aDlJZcmj
 /62XP/A+9hy/Y/pD2CP5qOWcbNtlTu1ZhVR1KJ9PbG18fN08+3Y+E+MBagTOhlWJu8r5+J1a/
 w61weAMLEvyF5YahJZzueg9HNr9o4B2APMrlTvtaxHZ5tKmiiWTekbCDKlB9t6poEbypke3dV
 zQ+EnHi4XLxEGkdtQXWCvHbyPKIrGdRI9R/sfVcGtxcgN+QJV84qRXVIGsAA66z/Ri7ecRG70
 0L8hmWpBZY/O1hvpxW6H88rqBN5J9uIFIlrZrgcb0/sgDplPQceNjXGo7cWmZyq8rHU48z4yb
 zyfo6gFy5w+kg3QlzQhusUB99CRBrJTfUhAt1Og8D1NjAMtxnwksa9RCphNxRsGrNVq0fWGHm
 NED8fJB5yMhytN3LFyGuDEJmJiwVp/j66QxCN+BUgkfIKY8k6QRohN3PF
Subject: [cocci] [PATCH 0/2] IB/uverbs: Adjustments for create_qp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1006
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/01af2ec9-4758-1fe6-0d74-b30b95c3e9a5%40web.de>

Date: Thu, 6 Apr 2023 17:50:05 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve exception handling
  Delete a duplicate check

 drivers/infiniband/core/uverbs_cmd.c | 64 +++++++++++++++++++---------
 1 file changed, 43 insertions(+), 21 deletions(-)

=2D-
2.40.0

