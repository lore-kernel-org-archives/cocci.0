Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1FFC6FD1D
	for <cocci@archiver.kernel.org>; Tue, 21 Mar 2023 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lR5MhhYEF4oTtHVmBXsYYWlJHOGzNYomFCafc/pOpRk=;
  b=OdYm+/LrF9Z5dAA20WRNjYHo4701F8sDHMyD/AnS570zM2Ka3jrUcpkN
   Xz7+ja2CKJWCaqgNiyy9AUm1xEIwWCI45qJhTDlytcVZ0vHljuhvaOBqk
   FwngzhRr0DK9Lcj5O8t+ibDr/qcSMyl8p8gFzY19NpNYIqeuN+Saf+kis
   8=;
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
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="98338096"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2023 17:07:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EC34E01A8; Tue, 21 Mar 2023 17:07:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 71A91E0131
	for <cocci@sympa.inria.fr>; Tue, 21 Mar 2023 17:07:10 +0100 (CET)
IronPort-SDR: 6419d62d_KGMCCWNs8me7i7b1j2Svin+sLAuPcDOnxZ/d2nlgi/RZDXJ
 Xej6JgwMdkYNhMtm9t9AQpAVeScZukbVCzYakDQ==
X-IPAS-Result: =?us-ascii?q?A0FaAgCg1RlkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTjwqBdy4DhC+HLIc6iGmBaoEsPg8BAwENQQECBAEBAwQ4h?=
 =?us-ascii?q?EYChTYCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB7NVgTKBAYIIA?=
 =?us-ascii?q?QEGgmOZJx8sIlOBXgmBFCyNBIQwJw+BVUSBPINBg32BBoMZgmeBDIEdlmYKg?=
 =?us-ascii?q?TR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZQsOb4FLAmRNLyUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxDDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA0+BRwSBC3wKBgEmJJ0KAYEOlU0Rki+eDjQHgiiBVYFZDJ8MBhMug2oTk?=
 =?us-ascii?q?wsOBpIjl2oggi6lTIF5I4FcMxokgzZPAxkPjiAZHoNuj0dANDsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDJC2CKgEB?=
IronPort-PHdr: A9a23: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
 EZeYuRWfuknsjvhsQ5fGw==
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:nrFQk6hNj1WW5an4eECGXIkhw3BQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="98338072"
X-MGA-submission: =?us-ascii?q?MDEiCH1iAoElek1n/d18Tl4blmQSMi9B3R+FKo?=
 =?us-ascii?q?WVKep5GzWMPeszI8ATzmxXWMP3BeGDm9ZGu5vb4ZWM/G3FN6oii1bwht?=
 =?us-ascii?q?cWfJ5Xxnve9cx109K9q+K56JVDaURLDnzgtBeS1pjsZS0ip5P97ypK5n?=
 =?us-ascii?q?AX1K4nkJsEyOgUu0xHBWrrkg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:07:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679414829; i=markus.elfring@web.de;
	bh=lR5MhhYEF4oTtHVmBXsYYWlJHOGzNYomFCafc/pOpRk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=S0KFYIKTqSidO7JTe1jt8HEMI9781TXwr0MWdwD07mGYDLKCmoAopLV8N3G1H2RSV
	 Z6XwdnzLZc7iI1Asf07mq1qkLK4Mxv5NQ1l47DaFl3x/d4HN5LBHMK3/Jp5sMCQHuW
	 JMvS5QFcs6SdAfC8vprEy6V6PgxHF/VZPggtjUJRGg/Xz0gT6pG0xMVXtrjGlxYWCm
	 nUcv5H3PsQE1Wi64tN2ZhaWQbaKvJwZ+fWOYaOYWFpUK4AiqWCWgYgnKH9879cg2Tk
	 3skwG+L1W3qYRC8IWqPcXh7CLExhKAHsw9t/eLYK1YdE00Q7HAuKh664j0DaYgRNFv
	 cUddw2GXXKapA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n08-1qbIuB0iDW-015kG4; Tue, 21
 Mar 2023 17:07:09 +0100
Message-ID: <46330de1-742d-f95d-e355-a214330698e7@web.de>
Date: Tue, 21 Mar 2023 17:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P9qEj38avJKSZHCKd03LCNiji35+bquMviwpZmhP2QSQhZV93xh
 QqguLLhVsSxPoPXZLk2ucwu+/Dlp0Xsz3/F+LV+9QtOepry98SSIYX+efRkYpZjyMeLcI7z
 skz3rtYZskyiCRRZYiimhPfXNx7ihFkSryByWNGOvhrdXTWcjA9BZGtx8XdwbvYnkUHJIZ3
 u0Dtsg82P5yy7+Z93Gmpg==
UI-OutboundReport: notjunk:1;M01:P0:cmfrdSf0g0s=;73kuuaMk9A2JxIfcaeL0b9S26nm
 Ll0Nq8mH/uLWzLRh6nInDKqrUJH/GJ8vTiuBYSutujIGbfeQigFG4WGUJ5B8pVAOnuEl5Cgzg
 LuM8kyeFHDiIqXwuri8VA6rIxtbXmZNq/Xx9tekqIsCgeduG9Y2V9wMRsGyCLfKP45k7whyTd
 ZkGgQ6iv5JQTX8SmR7UX34I23j4TroJvZ6rfwgFiIugtA1EQDnV+lOr0nRVrKSu5rfBO0QkVm
 O00X2x9gUgbwNM9/ue7G1d/b5giNi8YTTbLPgM4AstrI1yWdYmDuZ4zUMfobupLDXpY9pOq4l
 hG7tN4l9ojWzA3/j5uOmRimX983+YaovdzZK4ImoQaV4UpMnKxwtLrKELfxh4iYY9cfQdCHBc
 23m05XajT1mA0sSb+mP3IWlLLfi310se5XY23Aldfxk3Tje1lvsDQeN0BAJWo3Dt+/F6LB5bz
 Ezw2l4XAwNWH1xMOH++15Ykrgrw1KWxbd4xPdQQpbIlg2K6ow/5AgMfsssCbaG5mpp8rlGMec
 BLuv+jqllGAPTBEUbX7KAH+alUJCwkF/ExAu34bCc+G+yYDbRGtRp5KHiu4lIxtTR+IQbHQN1
 efyQb8SbO+/zpJ9NwGbra09U1fzfWRzl02Yz4mcDByQ3i+/633UeGdQRBXuy0dnx3Cr7bVdr5
 PCua+FBDwJDpmqoGt1OM4ZDUAc7BExKG0RZTzTwEQd81J/BFl23URkj1UfMraXFHrlqCU44Jq
 Hs//3NUywfhxH4HCKR0M3tW7rOwS9gn5newmwcketfY0eNl+vT8OxP6Z8uoWbuuzROxdGy2KS
 a9JhryqxG7CUEtnz5WGQJhWiW9eB3HAnEVgeeaMf1YVdbA6mbprSw4ZXwHABUOXVvlpp6636Q
 IZj8w5gJdQIOXBWqG9WzACnyBVHviA87kHbWcD37Nod3fGWoVsT0PExasnWzmP48R9gFdTNeP
 yC6UwA==
Subject: [cocci] [PATCH 0/3] scsi: message: fusion: Adjustments for four
 function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 907
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/46330de1-742d-f95d-e355-a214330698e7%40web.de>

Date: Tue, 21 Mar 2023 16:16:44 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
=C2=A0 Return directly after input data validation failed
=C2=A0 Delete a redundant pointer check
=C2=A0 Delete an unnecessary variable initialisation

=C2=A0drivers/message/fusion/mptbase.c | 49 +++++++++-----------------
=C2=A0drivers/message/fusion/mptsas.c=C2=A0 | 59 ++++++++++++-------------=
-------
=C2=A02 files changed, 38 insertions(+), 70 deletions(-)

=2D-
2.40.0


