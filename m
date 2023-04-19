Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC5C6FD18
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y4Ozb4B+s3nUps1lwgPehTGesKU//HYG9mWzUp2Ws1M=;
  b=s86qXS7Lt4FtuWpnkeSUJHM0ZvqMaSKYjKdaSgKmPSoSK4svFVcIMqxM
   L+6YCYuLDkak6rNWKx9oh7GIpmeShAVvJ8s6zh2OAYgTZMD7GKDOvUjDm
   DX57IkwoS4a90dPEVAhKbSbaIWNI86v+fHZUilslaqGsaDQPz1+eLdMvB
   A=;
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
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103860300"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 19:30:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A431CE0141; Wed, 19 Apr 2023 19:30:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D41DE0133
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 19:30:27 +0200 (CEST)
IronPort-SDR: 64402534_IhUl+Pn+dg1UdQuVLKQG1IsRGkm9z+0dfvzjkinApbG0PAX
 6ZXEbdD62XXjSx1KDUuBQoTOH/NWKNk8TeLNCgw==
X-IPAS-Result: =?us-ascii?q?A0GKAADfI0BkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORBS4DhDCHLowlhAODFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnQChTwCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPgMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB6s/fzOBA?=
 =?us-ascii?q?YIIAQEGgmOZKB8sIlSBXgmBFC0BjROEMCcPgVVEgTyBFYItiB+CZ5F/iG+BN?=
 =?us-ascii?q?HaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIURA4YBhclBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sRAxCN?=
 =?us-ascii?q?zMTBlwBKQsOEQNOgUcEgQt8CgYBJiSeRXIBUjtMgh0NkjuxAzQHgiuBVoFZD?=
 =?us-ascii?q?J8NBhMvlwkOBpIkAS6HMpAXIKd/gXkkgVwzGiSDNk8DGQ+OIAwNCYQDjwkBP?=
 =?us-ascii?q?j80PQIHAQoBAQMJhUYBAYMmLYIqAQE?=
IronPort-PHdr: A9a23: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
 gGI3TdOKjFkvx8Cvf9gsE8wabzo8g==
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:C+0PX65dJAbQ7BeOAwPXwP/XdLJyesId70hD6qkoc20wTiXqrb
 HIoB17726OtN9/YhEdcLy7VZVoBEmskKKdgrNhR4tKPjOW21dARbsKheCJ/9SjIVydygc378
 hdmt1FaeEYemIVsS+V2mWF+p0bsb+6GeiT9J7jJllWPHlXV50=
X-Talos-CUID: =?us-ascii?q?9a23=3ANp/PBmqItiFqOFiouUM0sdPmUdwaeEz46y+OGnG?=
 =?us-ascii?q?DAzxta4WzRFyiv6wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aif+gUg4rqS1vzZlY4XRxHfOzxox5/JaNLl4Vm6k?=
 =?us-ascii?q?agMCIbAEsFCq8rG64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103860299"
X-MGA-submission: =?us-ascii?q?MDEg008J//giVU1mD/a5lvenXj6N3GvuJGSYAq?=
 =?us-ascii?q?RmZdnUgUjpbRwYxwgN1ZHQe4dsKxRApNsGS/JVCMJOZBBEKMyu2kAOeA?=
 =?us-ascii?q?HsaJ7vo2x7XiGinGmMyZ/gwihnCDFTNRFMIkZkYbzOG+jkv7F9a9pETS?=
 =?us-ascii?q?QkFCT12So4S8JX1Zo2gBHzGg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 19:30:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681925413; i=markus.elfring@web.de;
	bh=6p9hkOeEOUXs7/nkpZQ7tcm8+Q1zSjkvro7tbFX8CQc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=NqSLjieUp7qRpxfVKba3Yb5GlTA7CPJkMsnwurgVLTOveTG+tNslBKn+HZeRzR/Gu
	 mNMFdADVoJfZfa9CiqeMNsGx5bBcIQo1LtJ4u0gwMKxkBladEFUB/9qyz4o/lVfApa
	 EOA+HDsz4MnPS9zO7lvpqYjR77f3fol1IKiL4ecU9vnhAeHleVuTYUPpPwff8I1XfP
	 5N8j7Jgkh7f2dHfdVLpvsjaS3kwDrPwPUJ927eupmkIvF59d5XvbaI2sBmv6B3xkGu
	 Q2KRnGyponMsC523owDYD63jBeZcAfib/DI0VGvCW2eR6yHZmgGLyjKBjUh9Th1r3r
	 qnib9z7d8mr4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgNS-1q2v8p0y5C-00ECip; Wed, 19
 Apr 2023 19:30:13 +0200
Message-ID: <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
Date: Wed, 19 Apr 2023 19:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sriram R <quic_srirrama@quicinc.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wJ8DZj6J2JRen0q6cjSbR7SOcia21nm6TQ4qdYYRH7VmVGTEHDr
 BJpj6aRMXb+VOqlztod8b6jpd1lhtmhYWf1tMLWCjf05Zma3qF69QIAcfhg7/yoqYBNa5eH
 B7wpETQygZiXeU+c+4QE27Vx17XJq/uoMRWdlov54YzX836sQQGgMXkPTODc8iATohoCc+1
 UG2KVJh17pyLGi0ARNgjA==
UI-OutboundReport: notjunk:1;M01:P0:20J7rtOixMg=;3hpTKkam2JxvMPo0iPpp43Ikm7H
 p9BSF6xdlA8lmS76GYojHuEu9hbPQVwTlc+i5SwbDuo+AClJvMVV9aGM3ipV17EBXoDQlGhbV
 BgZO0M4Zp5FE1OIkcTMx6RvPgRTUnxkwja/ldnTWCeGKO+Zk8bGwpAtfBgObsphQGbHu7bENV
 X/yln3KuIYdZF/Ypd928T9qoEKvPk9ej7tS6DVgd2sMburp2pIAZ+Q+xv9La63yGjvOcnvffH
 DOIw4d1aQ3qNQbxuCJB516Hlw7t1gLBI6iN7ZEdgvvd2fBt3RRaiFpc8PgOE8T7/0WKiA+WZy
 N5Jj6HeOFJjK6FYAvXF7ilS8+r+FOo8UKk37Ym92Jjw2ycnuQtMXlS9jbIgNt7Pbfz0YnCnmr
 3ds18KPmVE1bYTo8AAjRpG5k7JEA81bw2Ii0nlUEc1AKQVIXZTm6Uq/rEDHba2hwBcvy6bqVY
 YUqaODelrw18biE8sXgM9h+twHkk9AqEJXJ/I6sBvDqtUJxG9WTR4ArwwIOWrpjwHl40AMrzL
 KuZH0nxiFWKqmCwRW5FxeygliRmipCKL+lR/MIIpB5clOTKNRcq+fSOl8Rbwnlo2825H6+3bd
 08Rpx1e2expwpvDcPVTQcjxzmj97lk6WoxkZcT0ar9pdD9L2/WEUa6KjTRHCL4U7z5Wflh4Cs
 QlAOLULSb+ZSe1424z71q0uqD7pKsV9hhyxmTT/Z9nqSpHJ0COVAE5L9xGS2qvJJ/JrvqY295
 BVV+ZDK9GtNbM4ZlE9LU3lfm8l/luLzBKrV3Y8r2fw3s1313ZSHh8TCxi2Nb1ZBplUext7IV+
 OuZv1KsHtoJNxjIKyOndbPRm0fSThcA9uG1jOVgDtKCn+oivomv7vctyZwXtwtaO7aUEgALc+
 pJs1Yl1hMDqOtwnJ/xVQt9fylN2lPMT6qLvNQNWhdrs5qaSO/VflXyJSl
Subject: [cocci] [PATCH] iwlwifi: Adjust input parameter validation in
 iwl_sta_calc_ht_flags()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1096
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/9cb634c8-d6e6-32bc-5fd6-79bf6b274f96%40web.de>

Date: Wed, 19 Apr 2023 19:19:34 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ciwl_sta_calc_ht_flags=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Csta_ht_inf=E2=80=9D behind the null pointer chec=
k.

This issue was detected by using the Coccinelle software.

Fixes: 046d2e7c50e3087a32a85fd384c21f896dbccf83 ("mac80211: prepare sta ha=
ndling for MLO support")
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

