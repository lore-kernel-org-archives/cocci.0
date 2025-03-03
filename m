Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C981CC282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZefGaaDikQnjs1LGtmcyi6zUvqK48gTikrVFialZuG8=;
  b=mn3b8E5R6VlW/61O+8sIrrjIvwoUixCHZEwCb9UbWtJyxgZApY0UpU2O
   YS1JLZN6MXf/7QBWeJEVGT7PwmRtCc1ty4eVVPnHRBoUGIUyPXiDickrg
   RlMQ30nV/XYrIVWNEU//D9jAsnJtgHqynDWKzT0Oa7qZRy6kXNWBo4RIq
   8=;
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
   d="scan'208";a="210882643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 14:04:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBF2DE0D1D; Mon,  3 Mar 2025 14:04:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 69D85E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 14:04:21 +0100 (CET)
IronPort-SDR: 67c5a8d4_V5ASjnqqGswwQb/+hueStW42aeEf6MCbNudjsCB8MdWQyoO
 JrD9UEeuD5vRrQnzspGCNAgeWyZDWz2AkeCqSRg==
X-IPAS-Result: =?us-ascii?q?A0EDBwBSqMVngAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0LQOEO4c7jEKEBoNUDwEDAQ1BAQIEAQEDBDiBVIJ0A?=
 =?us-ascii?q?osVAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMEGQEBESYBDx8BB?=
 =?us-ascii?q?QImAgJWBgESAgEBgn6CMAEDMQevNH8zgQGCDAEBBoJp13MfLCJXgWUJgRouA?=
 =?us-ascii?q?YVrgmMBhiaEPCcPgVVEgTyBFIE3doFagkuDeYJpg24sA4M9jRObRYFNHANZL?=
 =?us-ascii?q?AFVExcLBwWBOTgDIAo0FAQZAhQcAQ8GEARqeoJFaUk6Ag0CNYIeJFiCK2oEB?=
 =?us-ascii?q?YNbhD2EQII/UYJCghFxgReIAoEthGodQAIBC209NwYDCxsGPaFuOoNPcgFSO?=
 =?us-ascii?q?0yCHQ2Sb7MjNAeCOIFmgWMMn14GEy+XRQ4GknwBLodlkGoiqQ81gUgkgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIQwWFoN1jwoBuSdCNTwCBwEKAQEDCYVGAQGKIi0FgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:9qXLsKm8XN7nC/adYDzmPpvf13HpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:Y4/qvmNN4wD0Ku5DUXk68lc9Jf4fd3jb7izOfxWpTmAuV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ACxYSqQ1zTdBbbroBWPUvqMI1+jUj+Y7wKGpKn5Y?=
 =?us-ascii?q?6+MjeLixqZmyez229a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110501071"
X-MGA-submission: =?us-ascii?q?MDGEGZtP+Ih/gfLdfDP5lECC1Dt7BLlTxFKI/A?=
 =?us-ascii?q?+3fm9yeMoObXGDl0Yrda9ic4EjXj3nSykwL5NCwaXp5z/TuNhk/TBm4E?=
 =?us-ascii?q?tyhkxyiFGe3meCq/KlscGShBuyNDgC6JZdkyV3aky6AWdQ1N+ZlEqqZc?=
 =?us-ascii?q?/8GADjurybpXb2bB2bdQg+6Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741007051; x=1741611851; i=markus.elfring@web.de;
	bh=ZefGaaDikQnjs1LGtmcyi6zUvqK48gTikrVFialZuG8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VUOQXwykHDmRACVU8X33Rt1uW0UUPZiZAC3Wcg0Y4VnTpWz4BJHox8LC2q2aKGj3
	 /mteEDNZVtYMlJSp50eLAIXVzEQLyajTwhoQZ8gMklF1Fbplz20+4rl9bh8voktCh
	 7cEYgDwORv85DsKoYhyMiLyQD9/mtqoDk/a6zvi5VYslE9kHUVMJn5N9HurQ4F4tP
	 5oVv4t8BOx3GfzzP/nkB85IB/UxtjUUx2/CoLb1UzVdyetd4DHwEikdRx3/L0wiJj
	 21HPZDsF/vGDINJjIVvDtdhH8IrYJpCcLChljjeT/Ck9u+8UwVzVNcTsPuCaLYiBV
	 I9OSbhrL7JEIcdruKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl0r-1tTkt42vvR-00eFMs; Mon, 03
 Mar 2025 14:04:11 +0100
Message-ID: <535ce5e9-9ad0-4a8e-9fc2-0e759417d1b5@web.de>
Date: Mon, 3 Mar 2025 14:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sriram R <quic_srirrama@quicinc.com>,
 Stanislaw Gruszka <stf_xl@wp.pl>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d90b8c11-7a40-eec4-007d-3640c0725a56@web.de>
Content-Language: en-GB
In-Reply-To: <d90b8c11-7a40-eec4-007d-3640c0725a56@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jymu+Pr/1TM+UE1JmuPUEORIpf2+qiF1lVGAScvypt9vYK8bt5v
 idl/iM8PTR6GeLd8dQ/PV/NBe0QVMImhaGA/no3YROXP3+O/ZMOy4OehC8kK1NC2wLPrUvt
 mJEk30C10DOjyID6CK8aBMgsaNMkOjtScGq/Ry79uPBtaLQhcIZOOcMSxwHv5KgFjxKOoBL
 v2j/MsWi3yyovatcuxhRQ==
UI-OutboundReport: notjunk:1;M01:P0:uVOiMT9twh4=;NMDytpay6lIFj3dsqdE/Z4Yl4c/
 t592kNeaCLxQJXeAmgukVFmcI623zCrOqNmZIWtsJOfMWfm+KPzGUaD+bukKKNt9QupSsprUS
 eryIqHbO+P/CgFsCs1cljKSTsUodBNmNHfg77J9K9QBRh1hdQXs5hXrrQgcECr0ih/FdOLxp9
 2fDlGbiCR7yzXHW+wCiZk3bhQRf5T4E3x+UwpNZ2rsn+jtnlk9EEAKZpv7gtmJjOtKZt1dB1p
 yQ8kYbxeBgbcZLAFMz6ospRvWCf2B3lWMZcCRiWipObsYtnM50kFRxxFFeEXih2S2+HWHG69w
 hnd0HWQW5MbxO96aDIAvpIFGWFcPGDY9DGArE8VvtUuOeRH/jk7A/AkqBpJ5CymTc22IvTRH9
 8zdrwBZMhC4SDK8KWAbiALVy6j7y1nOQrNX89TgvE3oTACLW1/uAkP1+A2N3jPMtRyF9CZKtA
 jbLt6Fvk+0inAjpbIzXZyA05rNpP2SnBvm9cXlQGWe+/D5xoNx6cmX2vi3QNLxndGhhTWWIUO
 G2yu6Gp7Y5vZAllrjWB104TQ754TBOIZPJi7LmnCAJ3j9ej471RsuyRpHiI81YYff01NJva9d
 rsSTkuTeucTVezfTplviL/cLvGGGqIYzTqDWPhYaMPElMWJAyJEmFtpvfxceZYMA3t6nvDdEZ
 l+qWL5NbV0cdTRnnXXMCzpQztkXihe/fnS+sKq8DwJORqkMr18CUKj5t52cu4114jpS9E0d4r
 IhdFDt6gq9jRO7dADQtmHKsBAnMnjLcDK3VsJxUlaDYefXnQCGNdSrQmAEtUupKnKL0ESYJSM
 W+xqVwjbpQqGdyKGwi9xfI+wCpAxx5Sg/McPGYwVFJjKNhsv1TyDqwIZqt1JNvHQKvuTxAk5x
 FQ1LdHN7h+4+K31L9Uv/D0bjGxvNzAzkC9nXad5AZ8VZWc2+OS47kOkSeRbY9auS4jZfQCi9B
 0K5eXCYA6BCFP+JwYOWe7B2dWfhx7rFft289lQFW2cuhThgcSJk/aD7KGMORPxbRqhMem2iNE
 /Aqj2uDhNAZvQOlK/zulc6hWf0Q4ckiBnN96Q704GV988t+wFWn54jXGUbHODCfM17hBs2Suv
 wrfLBztoieDegRtA6YBhegRCL/EG1WhaB1AkEbA4y+r07nC2JkJWBVvll11IyjtLdfIn7jCSz
 pvCsN5ZljvPq3QXxY9wQTCArITqU8afvoGTFGXQbgFDG4zTO9MKk7iauXDiMQXn9IXv3Aju3u
 etaLLjGHpdY1L6t7AvuuDo9XbPTuJy3wYJXWsYI1EZqrtwrWZnJZaIsGkuojCz88m4mGL9tJ6
 WTviBm2dVQrszANHsNdjCfWLuRyhDTiMmRiD5s9tvYImRQs87/tkZQ0E2XCfA3FcPoZ2JVx0Z
 Jzxe5c4toDudXb1oe93JEGuRP3EMfJjmXDLdg3e/p7uwvAOIwB5PwuInPuBnhLLYC2XgNNixo
 iVdIJYNXq3AFU7mVU129qBvfhyk4=
Subject: [cocci] [PATCH RESEND] iwlegacy: Adjust input parameter validation
 in il_set_ht_add_station()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2480
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/535ce5e9-9ad0-4a8e-9fc2-0e759417d1b5%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 19 Apr 2023 18:35:55 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cil_set_ht_add_station=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Csta_ht_inf=E2=80=9D behind the null pointer chec=
k.

This issue was detected by using the Coccinelle software.


Delete also the jump target =E2=80=9Cdone=E2=80=9D by using return stateme=
nts directly
for two if branches.

Fixes: 046d2e7c50e3 ("mac80211: prepare sta handling for MLO support")
Fixes: e7392364fcd1 ("iwlegacy: indentions and whitespaces")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/intel/iwlegacy/common.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wi=
reless/intel/iwlegacy/common.c
index 96002121bb8b..8f6fd17b02a8 100644
=2D-- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -1863,11 +1863,15 @@ EXPORT_SYMBOL(il_send_add_sta);
 static void
 il_set_ht_add_station(struct il_priv *il, u8 idx, struct ieee80211_sta *s=
ta)
 {
-	struct ieee80211_sta_ht_cap *sta_ht_inf =3D &sta->deflink.ht_cap;
+	struct ieee80211_sta_ht_cap *sta_ht_inf;
 	__le32 sta_flags;

-	if (!sta || !sta_ht_inf->ht_supported)
-		goto done;
+	if (!sta)
+		return;
+
+	sta_ht_inf =3D &sta->deflink.ht_cap;
+	if (!sta_ht_inf->ht_supported)
+		return;

 	D_ASSOC("spatial multiplexing power save mode: %s\n",
 		(sta->deflink.smps_mode =3D=3D IEEE80211_SMPS_STATIC) ? "static" :
@@ -1906,8 +1910,6 @@ il_set_ht_add_station(struct il_priv *il, u8 idx, st=
ruct ieee80211_sta *sta)
 		sta_flags &=3D ~STA_FLG_HT40_EN_MSK;

 	il->stations[idx].sta.station_flags =3D sta_flags;
-done:
-	return;
 }

 /*
=2D-
2.40.0

