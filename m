Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03049C46CD2
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Zn9KyCOqh0XzYqgX0GGCNaVsgPrXYVkcvYhD3qjeDkk=;
  b=o3c/ZV4rtwmbrkVM5nJnd/D4WL/hrZb/R+mhFFKnzTeqtaGLFV5jjR5t
   g1lq+V4w+/KknoJu+3SChyyqEkYMbKTSs3/EUTPU5ovGiQgcEizW78jNG
   rvu5Nti3Hjoq2PnGlD6jGbub8Pz0sn6bTgESi/ao97eel0/KpGNyP26M0
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143934341"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 17:34:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81435E0AF1; Sun, 24 Dec 2023 17:34:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C457E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 17:34:20 +0100 (CET)
IronPort-SDR: 65885d8c_CWd29K1C2I1mEghAPD4PHzi6fqDIp2Ue7+7o2pJq3L6wjnG
 LIu/PlKpPPX0JTcG0PRaPC1/WpJ1j8JfoOq5oyA==
X-IPAS-Result: =?us-ascii?q?A0EkAABEXIhl/wQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2JGYRrhzWHTIhvgVYUgSw+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDcBhEeHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAoEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmA?=
 =?us-ascii?q?S4BBQIRFQJeARICAQGCfIIrAQMxB68tgTKBAYIKAQEGr1gfLCJWgWAJgRouA?=
 =?us-ascii?q?YgaAYVnhGIPgVVEgTyDQYN8gQaDHIJoiR0HMoIcg1CKIoc4fQVBcBsDBwN/D?=
 =?us-ascii?q?ysHBDAiBgkULSMGUAQoIQkTEkCDLwp+Pw8OEYI+IgI9NhlIglgVDDQERnUQK?=
 =?us-ascii?q?gQUF4EObhsSHjcREBcNAwh0HQIyPAMFAwQzCh0LIQVWA0UGSQsDAhoFAwMEg?=
 =?us-ascii?q?TAFDRoCECwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfMgk8CwQMGgIbHg0nI?=
 =?us-ascii?q?wIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0E?=
 =?us-ascii?q?QMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZKexSCdZJyEZMMnnI0B4I0g?=
 =?us-ascii?q?WCBYQyfKwYTL4QBkyUOBpJUmE0ggjGmFYFjPYFZMxokgzZPAxkPjiCEK48JA?=
 =?us-ascii?q?T1ANTsCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0AIKbakotYcitY7A1C0g3CqoXnPpDfL03DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQmVxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObeEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3ALqAc2WlYFwLMeHBa1nvf5G1+85TXOSTU93n+fR+?=
 =?us-ascii?q?RMjZWU42FdXOo85M8quM7zg=3D=3D?=
X-Talos-MUID: 9a23:vwQLkgZYw7WyauBThSDLiRZfJttR8Y+rFXIOiJA7o/bUHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,301,1695679200"; 
   d="scan'208";a="143934335"
X-MGA-submission: =?us-ascii?q?MDGrPRU/YiIua96qle0lZQT+pxQVsgm0ioowMk?=
 =?us-ascii?q?I2+uEliKk53WFVIXUbns8vyKhBEvevOOuPzw/09WHL1RxwUHCnN3DzoT?=
 =?us-ascii?q?3yp/jNpVxchYVxZMEgDWsxauWdITPuQiDXYuNfvLlcM6MFItXI2M3vNA?=
 =?us-ascii?q?zxfoaFQnr9XcswJ5Fgd/EESA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:34:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435634; x=1704040434; i=markus.elfring@web.de;
	bh=9BiVbz0igTm7nDWglduX4wzhh6jbXHBNsHlsQ9SchSQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=bcUiXv2U4BW3uHtoz7UtDb6wyaqIKmeSH/2Vpxvpi0wHdbLtL9hpLXPD3e5XgmrJ
	 3r/YGP6GAbSigggtezR2bIi3u9QU/E5Q4DUVllR6UVxNWMQHpHonMc5svlO1ulT+s
	 1sIRTueixLnrK2WaB8zFJ+yznhBwlM9+ofYlEUn+sxPZ/HQSM4G+V/KomfQ5GQTga
	 NjqCeFIqSs07LExzNYIl9OEC28+HWlX7mF6l5rklWd785DZ5L+D6ErIp5dwJ+Pd0u
	 vcr79swPG6UqAydDMb3z6B71DTy0PD+y3iHPJx3DQ1tFegwviu8PAqWuStaUoKr2B
	 wOQAR+qslyfwunedng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1quU862wzU-00q6gg; Sun, 24
 Dec 2023 17:33:54 +0100
Message-ID: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Date: Sun, 24 Dec 2023 17:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XEePEDeY0FjWsC2QA7qlbhxGaU3mauLYiNr3cIZ3Rev3r7moCG
 EpqJ5+3sRGzZEKYzU6HcAzj7DCmep7Xg8Tm/h8uVyIgo4bsJV230JuACQT+Lh7iPDMaoa5w
 YuOKgsWqAVAOcPYBEsyoRGfW2IpfQG0Oweudch3paIq20Grmi4eJ6yK8O2vOHz09oDkMIhQ
 TjIiSk7LLBH4CH5fbYnRQ==
UI-OutboundReport: notjunk:1;M01:P0:sYxr3ZCv3ls=;Fc31zMwDem2J2sC/1TXNDDqWzLq
 KizXtddyaG01hvUgdhUdsnWXDpOhPMZ/iOhBrTtWK5psW9hdxHDQ8qMMal5cLjiNk1KEqfT+0
 3r6ltPdwgA4uvhY9g9IAV3/jmzG6A/gCWhrQRyOzCeqAKjBYyEpGQEqPIhGypu+jVvZgV6vRZ
 56ljNC/Zd3ZxsTfEkPZAP3K2zgibymLHjr73JZPBoZjHLTAQrh+n0DjlZC7ziXQaa0DRPlMV8
 /DS3cXxlwGmsuAJM+eQcYiYBOxWgQmkSxAZtDgM4a/F4/nTFii8MJYq1dWq+6rZhzwbUe59uZ
 KeN8+phus6suqOrNsWufP9qhID71c1Abt9rpsxCnCsYV+Pr1iWVR/D9dPz+09u1syJpFyyJeH
 aiIDZ/BZ6zasMD5bkEJLmnaPfbHFsztIjLCmm2hT2QRp442T4UH4QV+YZox7aizwPRsuopY2G
 wzZJ71VKEqReNrj14v07z8VOqPxATOTylivN27I6OfdImm88s/nk7ZUtN4x6OcLooew0CUxcM
 otwNOL/miNiMJF9DzLwqwaAQs4AQN/onGGmximvXKORAZPVW14RswOqGnXvtD4+IIY2emcCb4
 lWQGtXjdFxbpDby9V/vLgEJ87crXqvq+LTaBfxCyCrU+ZVEW5ty0nQuOBHD4xnFPVlL4xdMUS
 HjbKMgWrkXVOqbClJf580CuFOPI9DX+3GyCrtBggtuS4jRwHW63BlcnhRvrHjH0ei0vPFOBPQ
 KbkwRqGXxylsUB1XfSKLsRO4/nplWyD+cRYB/He33vP78noQK0rQM8H+Vqe63ucJnCXsAJTsZ
 brE5ck63LeABS/gweDDsEiXMATYIQ4Lpj0n1yk+CWB3BAKhGP7euaESCzLJ4kTNEXyaCIx81r
 VrCmV6WIWMtA+6OvdBPaH7vw/z+VKXMHYoYaosZ0qHeU0MmMj8OseArsdmbjuTvdHJRJ2N2ue
 H/J3fEwt4bRW88KgzRMmsshSsh0=
Subject: [cocci] [PATCH 00/10] clk: ti: Adjustments for eight function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1368
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/20849a8e-e0f5-46df-ad8a-9eae6cbe337b%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 17:03:21 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (10):
  Less function calls in of_omap2_apll_setup() after error detection
  Less function calls in of_dra7_apll_setup() after error detection
  Use common code in omap_clk_register_apll()
  Less function calls in ti_fapll_setup() after error detection
  One function call less in ti_fapll_synth_setup() after error detection
  Return directly after a failed kzalloc() in of_mux_clk_setup()
  Less function calls in _ti_omap4_clkctrl_setup() after error detection
  Use common error handling code in _ti_omap4_clkctrl_setup()
  Less function calls in _ti_clkctrl_clk_register() after error detection
  Delete an unnecessary initialisation in _ti_clkctrl_clk_register()

 drivers/clk/ti/apll.c    | 58 ++++++++++++++++++++++++----------------
 drivers/clk/ti/clkctrl.c | 44 ++++++++++++++++--------------
 drivers/clk/ti/fapll.c   | 29 +++++++++++---------
 drivers/clk/ti/mux.c     |  2 +-
 4 files changed, 76 insertions(+), 57 deletions(-)

=2D-
2.43.0

