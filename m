Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE02C6FD18
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MeAa+xZneH+el1EN57C+bJJmUzjMDXKdO4/tvpjiPes=;
  b=nHDlpvSEG9EgFSgga+Y/bwd20cFi6rvcR8h2aP+3/R/Ifqe9Dddb9ncY
   EicRE6ykHDGsi/X41doyc+ZxwpJj4YVLDflpPH7MsISfQ2VMVAczlG2NT
   M9VWsiCAmXXvWrfm0TDrf+d2V+bB614qGmbISUUnsDhoExt67mkUP7RoK
   o=;
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
   d="scan'208";a="103856278"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 18:49:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6515E0141; Wed, 19 Apr 2023 18:49:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C541E004E
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 18:49:34 +0200 (CEST)
IronPort-SDR: 64401b9d_Bg0j/tZTrvlV1M2hzdMEDTvvXafbwENHvEHA7Yc8+F45HNn
 UHt0ZB4JTB7AB38PjIfDdUJp+Zr6eoPEszZhgKg==
X-IPAS-Result: =?us-ascii?q?A0GKAABGGkBkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORBS4DhDCHLowlhAODFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnQChTwCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPgMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB6s6fzOBA?=
 =?us-ascii?q?YIIAQEGgmOZKB8sIlSBXgmBFC0BjROEMCcPgVVEgTyBFYE3doFbgkuDeYJnk?=
 =?us-ascii?q?X+Ib4E0doEgDoE8gQQCCQIRa4EQCGqBeUACDWQLDnGBSWNMgXsEAhREDhgGF?=
 =?us-ascii?q?yUEDgMZKx1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYbNBECCA8SD?=
 =?us-ascii?q?yxEDEI3MxMGXAEpCw4RA06BRwSBC3wKBgEmJJ5FcgFSO0yCHQ2SO7EDNAeCK?=
 =?us-ascii?q?4FWgVkMnw0GEy+XCQ4GkiQBLocykBcgp381gUQkgVwzGiSDNk8DGQ+OIAwNC?=
 =?us-ascii?q?YQDjwkBPj80PQIHAQoBAQMJhUYBAYMmLYIqAQE?=
IronPort-PHdr: A9a23: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
 Mz0x5ql8x1uZpg5KP6ITEKm5kddjOSCs33xvt0=
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:/66NyqPNKssJN8BcT8f155DYdb4zR+YMi2QD/1t6SBxLfsHdv9
 3GpoVQ6faVsl0ssRYb6Le90ci7MBfhHPFOgbX5A43SLTUO1FHYVb2LA+PZsnbd8wOXzJ8o6U
 5LSdkKNDVpZmIKxfoT2WGDYp8dKDPuytHeuQ6m9QYacegIUdAE0+4GMHf8LqQsfng3dOkE/f
 Onj6IsylbOFxUqh6KAdwU4toP41qD2ffzdEH077lIcmWuzZQ3D0s+ELzGomiwFSjtKzPML+3
 XElQuR3NTjj9iLjiTHzmfW4tBvhNf8xp9iCaW3+4coAwSpsRywbIBtH4ePpy84u4iUmRoXeN
 KnmWZfA+1Dr0nJdmW55SDgwRXkzV8VmjHf4G7dvXvE5fbBa3YAB8BMhZ1Uf3LimjJQ8e1U4e
 Z230TcjZBeChTNkU3GlqL1fiAvqkqT5UA6mepWj3tRV+IlGcRshL1a+0UQGIwLHSLk5OkcYZ
 tTMP0=
X-Talos-CUID: 9a23:e411Fm4T45KEjLPNUtss10AtQ/8VbHPh5i38DhCfLTZIbLObVgrF
X-Talos-MUID: 9a23:hsfHxwR4UIRRgsKwRXTruyNzZc1u6Z+lDX4LgLUAhMa+MHJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="53790995"
X-MGA-submission: =?us-ascii?q?MDEKLeGmNLaXO2e4u4SXhBB/Ucfg6gLg/NZ0MQ?=
 =?us-ascii?q?Dp2KXPJV0SrKZc5e7pMX76RJkzfGioGUll07DxUTtUmx4OhKs2rvyP+g?=
 =?us-ascii?q?iw0qVXVnuXtGccVFsjJPFAiGHKnQjENU7aAhvhXG6Yude98V2xryTBBl?=
 =?us-ascii?q?6tAZs0ZmNkgWgxtbNcrBIA9Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:49:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681922935; i=markus.elfring@web.de;
	bh=qt1d57nrscWLduFuNdsXGbxqWKA0wZ9us/B1SDMjVG8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=s1G6hJnKxqX8SD7JQKXFZ682cxVawNxjpX4WMrIoJDFb2muijLgclEcfERzwThen2
	 pY7/TvdAkhUbJ6vUiN/9KmSzG2vFBuQoi4DLYcLm8IGoORqUlrj791Nw+zX+QAGM+J
	 Pwsb4xsKDZr3NnU0I+Vz0GnG7YGGSmSRugtR79+bMsIamHoz8AMWR0NguBmJ0w3tt3
	 FFi0viJW78CFV6TKDmPbQJk4L981VTh2NVzGNJJkeiGEN8SlPDo2av4izzQYy31FOv
	 NOifMhUxwH3K42mhxwVNu+UxkAwRqhsRbX3zhcAHMD7aSztl2Xa1u9vRk8XjP899x2
	 Nyq3ZL0rtY0Wg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1qZXLz2JA0-00kT7t; Wed, 19
 Apr 2023 18:48:55 +0200
Message-ID: <d90b8c11-7a40-eec4-007d-3640c0725a56@web.de>
Date: Wed, 19 Apr 2023 18:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sriram R <quic_srirrama@quicinc.com>,
 Stanislaw Gruszka <stf_xl@wp.pl>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vbjNQVyFeDKMW/6TioOMN6oieqUyIskWklJhZtbrFInB827g5Ja
 HfU9OmcoV9Su8TiZ1+nzOD62GP0/fkTmzvJSxGgnVnu9KQ9COetAJsXaw8FLveHTe4A0w7N
 Dot603XDBUJ8zDnJN7wO8OqlWaq7Q6+oXtNoi98xCa4NIxrD3DR58NVdWzZLFyQpEyBB8xe
 3v526u6rNv2glEO8unQXg==
UI-OutboundReport: notjunk:1;M01:P0:KbtYwGxGfXg=;0hBxzZRj0BFf6QK4LPBYjAmr/mR
 VQUGJfFegNufUG7i5i1eoXuW4Y4nvEKx14YUWclBLAbxE9FczEq3fStg+TaalyZJcFRuI6gwu
 fjcAqQPrGyoih6iqc/PwOZHBF9l3sDNwhS0ZQUok/H0a9MXSKt6VAWe0BVN5r7RdBtNxujwyu
 R7xPnLYsS7+uFoExWveXwTCeMzpNrj8JvUWJ2OTiDnvby4VT7UcvIv4FUR3c0G3QApKfzP1xu
 TuV8kB1IE1Q2/Y/68JTGtK/E0TUAukE71FhU+M8Ny+pTjzPXAB19yqaW7Y3xJ6wmeAv3jAQSc
 wMZkp6DyJwTo6oC2rVX5pk3xuxmy2hJbWXrBJxdC9L4r8hdv81OESWMzPTEHOwlBnWuTUaHOd
 D0r03DWOH8n8fpeS++/8y/wbM2qxzxZLAc16Am3dt7908FdSwMbfonB8xv9P0Cp0URVKY/20e
 HC4r9tp5bX4nO2AVEKrf85TCrVj1gNSMLbl93DcEVvyilOSzx9hku39LCilzDEI310ZRkQzN2
 mV1YuTUxuxxaPZQEsK2csFENC4Dwb8ox0iLdqZIQLmEGekt+tMG0H5/xiJm/wLYAKRKMGBaR7
 lDCg0fx1vYuZpslTjTemncLJOjEfsWO1JxCHDaTHi6tQuGeUOuOynp8zeTmkk1k2LXnIJx8PL
 xRiGKPk3oe7ZJjgaD+p1ety9olQCGoLOkR6M78scsQMYD+HKgAnp/NJscxmhZxc5Ki5MOUjLN
 teZOLYkvIUWk9Wpj4WJdoTiGnNI7IZGpELJDBKVw43HE2xskgM03emR/847wBI8mIzrH/6I1J
 etc0YKW970uCCSkLh43VzIQExDWjGthoVJX90KbdS51IQc8rTxE2riCEOnBBuq3vH+nY1v6Zr
 v++gOlvrLQFp8SWygFUJXwP3/ju9HRauo1OVd2F+UJZTVE7EGB2yx5h0Z
Subject: [cocci] [PATCH] iwlegacy: Adjust input parameter validation in
 il_set_ht_add_station()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1095
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/d90b8c11-7a40-eec4-007d-3640c0725a56%40web.de>

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

Fixes: 046d2e7c50e3087a32a85fd384c21f896dbccf83 ("mac80211: prepare sta ha=
ndling for MLO support")
Fixes: e7392364fcd1004a5e495f15cf21b1e0ef874215 ("iwlegacy: indentions and=
 whitespaces")
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

