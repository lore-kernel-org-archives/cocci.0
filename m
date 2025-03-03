Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FA8C282D1
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=haP3YnQ1hTaM4n45Pmancys67feBgEgblRKSuXDvr1A=;
  b=Frk22ERPOqlQrvfA9DA3QQOHPdLgvKw4PIx+v6F+mrTUAGtRk1SsK1vj
   mOnUhilbv0o4tipnFLTnBo2OpWTaICtKVUaeBHzCA0UJGvKqo+kDzDZ8j
   NB7P+mOqAmgNK/lMpwU3t2Fgnc9/Add7X7Lt5bUIlZ4ARBWyBfQce7SOh
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210886662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 14:18:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC21AE0D1E; Mon,  3 Mar 2025 14:18:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5B65E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 14:18:44 +0100 (CET)
IronPort-SDR: 67c5ac27_YY/kaaPlq2ZtqN4qVfd/6BUi/1F2frFyLfYZWE+MsZt/7yH
 PT9O5XJwNAcrwAApXIwDM49pCqW8ck25vpsUvcA==
X-IPAS-Result: =?us-ascii?q?A0GJAQCuq8VngAMP49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVczBAtIhFaIHYcygXQtA4Q7hzuMQoQGgVaBfg8BAwENQQECBAEBAwQ4g?=
 =?us-ascii?q?VSCdAKLFQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjBBkBAREmA?=
 =?us-ascii?q?Q8fAQUCJgICVgYBEgIBAYJ+gjABAzEHrzJ/M4EBggwBAQaCaddzHywiV4FlC?=
 =?us-ascii?q?YEaLgGFa4JjAYYmhDwnD4FVRIE8gRSCLYgegmmEGgODPY0Tm0WBTRwDWSwBV?=
 =?us-ascii?q?RMXCwcFgTk4AyAKNBQEGQIUHAEPBhAEanqCRWlJOgINAjWCHiRYgitqBAWDW?=
 =?us-ascii?q?4Q9hECCP1GCQoIRcYEXiAKBLYRqHUACAQttPTcGAwsbBj2hbjqDT3IBUjtMg?=
 =?us-ascii?q?h0Nkm+zIzQHgjiBZoFjDJ9eBhMvl0UOBpJ8AS6HZZBqIqkPgWc6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIQwWFoN1jwoBuRNCNTwCBwEKAQEDCYVGAQGKIi0FgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:wMEYpqD+3L/hfF/lHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AZ6SYE2swyuJDQzEQYbhHk9vx6IsVbXfF5VHBEnO?=
 =?us-ascii?q?0LkhbSZa8cwe90oJNxp8=3D?=
X-Talos-MUID: 9a23:bmSSIQYu3wbHbOBTiT6rtBJAJtVU5Yu3LmYQi7lcqdi8DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110502978"
X-MGA-submission: =?us-ascii?q?MDE8dtldoNY/GZ4BgCIUs199Kr3g03P4ScSC2D?=
 =?us-ascii?q?X1gEguGWk4LylEUHN6GHhjUlzvp+L4W/OnScHiRvdxxjPgT/Yfw/z9J0?=
 =?us-ascii?q?BMDDnwF0aDioUI+WDd9UgO40epr6aBzsRhRzcx4CJLqYe8MmBxj1ND3W?=
 =?us-ascii?q?F78TkRSObjxjQ/pbeX1r4UHA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741007901; x=1741612701; i=markus.elfring@web.de;
	bh=haP3YnQ1hTaM4n45Pmancys67feBgEgblRKSuXDvr1A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pMWhQSZ7mmW6WnDrAnSZ/723yKkMZsWgqcHn2JYzn1A2XzjyBQm/ik2Ej2mC1NQH
	 GS13QOP1KrUfaS9mzQLNqpYvcAXt+ZrVgZNDc8I985hG21SwlbBCjbbyuHewMB0j2
	 RfUayrlNt2Wq4kVnJ7kkrs/JOnFoliDCRErARsIXSntPWj7AN7XGGIEdC//pfHwBe
	 C65KCMh/qrJaLbD5iw/e5SYFHMqa8zoI5j6/qFfTybG52f5DLtpbv2CDqt02CG0fl
	 5XvG3fzPCoxLs+DE5EQh32/D4va8BUxB+HX1cOrQEgmk5eC+PfTdnHTOkS0zaZd89
	 eX2aliMELA8jm5EZnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1tAIuH18K4-00yGaQ; Mon, 03
 Mar 2025 14:18:21 +0100
Message-ID: <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
Date: Mon, 3 Mar 2025 14:18:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Sriram R <quic_srirrama@quicinc.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
Content-Language: en-GB
In-Reply-To: <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klaLpxqRowNpOLqo5TgPE5pwLuOQZxsO7wlnEJEJTMtovuceQzK
 9j5rbUI7I/TUnJK5L4CF9gFQ/eXeg/hblRTs/rM+HoQQF+nLiHgvC/yTerLULFGe/c3bjBb
 MarWJxxg7QLtmxPmtF6LdNp6dF/otzHpWAAhCXfm4i7bDtKLPYB1jL9ij0B0MigrfUOTzCo
 MJ5lJiYrKHkil1c2EPwtA==
UI-OutboundReport: notjunk:1;M01:P0:8hjet2llDHg=;XzADO0IesvNkdn8ez1GDiDig+Fz
 zTe+5Ine+8o3lhtscOx2xxi399ryECeYZas5pCUHajSWwa2tGmdwuInMoma4aFSTyAtiZPsT8
 Td3ElBtGnXvSZPt2JqexXGkv2th3KLL4Ksn6WUyuSs60H4HXN0PkhqDUMGBc3RB5t4JF7sQfT
 m1o7WJsk8vTAsrhDgRw1ZvFiCqEML2kYSTkJex2XIqjQ7lCXtgVEdfA14+qsl+FdpQOFHFT/0
 b6el7Rh3ECXRN/hJH96cfwNPbCIUxZNeVXegFDlQXhDnDNlIjz5iMEr8q/CX2O6m+X3x2yYFY
 v2amNEe2oyJROYUyGCzI9IHecp5McECXojybvKBRSdSrXxH1rT2B1GTvCNZGg3aqVC6GY9wQs
 YJjK1j4mQC7OdbxrjNQj05YszK8t98EsRL9YXExRvbylVnGj68YlKDuZmdRITkNUEB6NhOXrt
 9ENDovRTtJiy67JzRlDE3pKxcPiMHfNPJeMuEO5DpxC2Ca0NPuuq6joFmFz6u1tny/f6gGFvF
 CwLnm6PYRtyXliEVUEn3UUSmDQTz8qyhLs1YDiBIlfeHeZxOaCMscP4YmSn09lyxFef31utby
 9e/uuey3/Jb0I+EZMPUlcH+R23S6MB5gWQ3dFKyQa0f4IypJ389rcODASgUmiXOj5yJYd1u6h
 18/XyDfamrCdIDiv8Licz9/xCiJNJ8IcJteTAMtttm7VFfDjpwlNTvnHVsyP+l+s4ArmONhUD
 XczPFTFaUcmcyFNmNE1+Jf4oEaB8JHXup56yNPoPdXUB6O5mvI/uRDflz8PPQDB3cDowMDC2K
 fJI5d8OkAD38Lr2Y7HnRdBtpy4YiG/JvLBoDMiMdwdwjku861gIE4yA9KZ5atkEG8iZsiVQNG
 Fp5RrdyblFAmPqP+tokyt0D02ZaqcVWwaXCJxBtF/bom3uKwkcFeZajNEHvzXJeRimFFxuRSx
 iTVGaRkdxNOJpP/dncIAe+YYdMSVbCcaPK8BtL5BgehI9VSW730Q+I8Geqoovlt5z0r5C3SyP
 Sg3sMcN6rbx4eRDJOjdxC7OxPDQ+wq98GAyjOCXUT5kRlB8+qBGyQ4xtCwdswHicA1amiAULB
 mb7YvyaJRDSVf6JNK115i3QuY5Btciqw5FVf4+X7UmnoDROerESuHj38PUsb1WoBhg9Z4hItd
 egqapByLzxK/qytebvoMt39/lcwCM9K6VqwRXThr3O/FQk5pmyrSkJsa96UD7aS19COdjUN3C
 8vJyHRwOqwn4h0JhsvpgBpMZbA7Xobq7zhjU+IPlCtOJcCB6ycaFsFgxPk6Z/XVY8nh8gT89k
 cYx7F5B3JDlXk6E1236nBVcknM7JRLrPnkZ/LEGDzy9wvDplvGK301Ntv0TxPsf3//NbNRc3M
 q/WBsCJCPfXChuIyUY8QNUwh8NbKe56CRjUR3vHSvZctplmyU9Hat8/WJ2yOkA43RHGhLrvre
 NgFLOXuXjSyn+3kQuRcx4J6xC2XA=
Subject: [cocci] [PATCH RESEND] iwlwifi: Adjust input parameter validation
 in iwl_sta_calc_ht_flags()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2481
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/22e24ec8-283f-49e9-b7b0-555e8113c250%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 19 Apr 2023 19:19:34 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ciwl_sta_calc_ht_flags=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Csta_ht_inf=E2=80=9D behind the null pointer chec=
k.

This issue was detected by using the Coccinelle software.

Fixes: 046d2e7c50e3 ("mac80211: prepare sta handling for MLO support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wi=
reless/intel/iwlwifi/dvm/sta.c
index cef43cf80620..74814ce0155e 100644
=2D-- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -147,7 +147,7 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *pri=
v,
 				  struct iwl_rxon_context *ctx,
 				  __le32 *flags, __le32 *mask)
 {
-	struct ieee80211_sta_ht_cap *sta_ht_inf =3D &sta->deflink.ht_cap;
+	struct ieee80211_sta_ht_cap *sta_ht_inf;

 	*mask =3D STA_FLG_RTS_MIMO_PROT_MSK |
 		STA_FLG_MIMO_DIS_MSK |
@@ -156,7 +156,11 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *pr=
iv,
 		STA_FLG_AGG_MPDU_DENSITY_MSK;
 	*flags =3D 0;

-	if (!sta || !sta_ht_inf->ht_supported)
+	if (!sta)
+		return;
+
+	sta_ht_inf =3D &sta->deflink.ht_cap;
+	if (!sta_ht_inf->ht_supported)
 		return;

 	IWL_DEBUG_INFO(priv, "STA %pM SM PS mode: %s\n",
=2D-
2.40.0

