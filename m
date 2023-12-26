Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B536FC46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=gYuwGe02Z7rEnGlIMR5+0knXlws9tGoavm0CcgS0Ul4=;
  b=t7kz+G7xqx8mgWsfx26neDEwl+ckDSZ5hxTV1f6ayLTiEyPDBH6c/TC3
   uYrFdeUPCNcvWUpmdzohBoVYagRsL6sS7SPw9qOMipyLHdsY7M6Y40xzN
   8hfBZ4CklJcaTE8QjFAEZ1HRvGAL8J+xh3+YsBu0P1F2+ZNd2dThq/lQD
   U=;
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
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144077181"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 22:09:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0D96E0AF1; Tue, 26 Dec 2023 22:08:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EB9E5E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 22:08:55 +0100 (CET)
IronPort-SDR: 658b40e9_WPaD5DtSbpYvUrw+AXEnpVfA9UgtmKxfaY0Sj7jeNWbHMva
 cYAxaBuMeBGmtSbN6nYckShC0I2fte5+vmK+skA==
X-IPAS-Result: =?us-ascii?q?A0EsAADlP4tl/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3hTMgQLSIRTiB2HJIF1LWGDXYc1h0yIb4FWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDcBgVOCdIc4Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrB?=
 =?us-ascii?q?BkBAREmAS4BBQImAl4BEgIBAYJ8gisBAzEHryd/M4EBggoBAQavWB8sIlaBY?=
 =?us-ascii?q?AmBGi4BiBoBhWeDQYEhD4FVRIE8C4EJgi2ECoQUgmiJGwcygh2DUJFXfQVBc?=
 =?us-ascii?q?BsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCDLwqBAT8PDhGCPmE2GUiCWBUMN?=
 =?us-ascii?q?QRGdRAqBBQXgQ9uGxIeNxEQBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yCTwPD?=
 =?us-ascii?q?BoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJQMIB?=
 =?us-ascii?q?AMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmRQdTKBNMJoIEs?=
 =?us-ascii?q?ECUQTQHgjSBYIFhDJ8rBhMvlyYOBpJTAS6YHyCoRoFjPYFZMxokgzZPAxkPj?=
 =?us-ascii?q?iAMFhaDc49HQDU7AgcLAQEDCYVGAQGDJjSBRgEB?=
IronPort-PHdr: A9a23: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
 PLmq5deU0EpUOwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Hp7IU6zm//foHsXsbDIsKrPw771zdoMgy1knxilNYDZSddGVkN
 3rufgd2wL04QxhIE3I+OrwX5VoJEm2yXcb2+gs1NuZPDUO21HYSL2Kj7GSoQEIcheWnoBgPO
 VbAs5D4bbLfD1HZKjBkWqF+q4bsaC62ZHtv8H4710oYCNLT+VbzylfYzzwLmRGADNBApoyUL
 qwj/ApmxOQPU4QacSwQl0rNtKumzWe/KiKXSI7
X-Talos-CUID: =?us-ascii?q?9a23=3AoDNf32hIPQ8tqmjatow6hjhKTjJuQH/i83DKOn+?=
 =?us-ascii?q?DLX9pd7C8RH+J0bpKjJ87?=
X-Talos-MUID: 9a23:IjT9Pwq8PJZunp2rY6MezzpsFtUy+YeLMxAigZxZ5u+lCj51YR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144077180"
X-MGA-submission: =?us-ascii?q?MDGCjfruHuHziYNuRiTBfscMUSLSHtgWcy7bur?=
 =?us-ascii?q?A+H1dyhWDGSqgLxW/2OQ42T9TIb1UmwCHj+5R7Zz38laBu8w5nhDPDIi?=
 =?us-ascii?q?9l5Omx+2ZJKX5h2o9RyxlEOsySzcf37dWDivGMlGWLpErrx3p2up2Lb9?=
 =?us-ascii?q?RAWT2bkgtw84IIiQ0jPdvZGw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703624925; x=1704229725; i=markus.elfring@web.de;
	bh=YYLqMBA68P6qrY58GnIyIrx0OrX5LlW5O/TBIpKpe7Q=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ViBQSwm4HC7YuaI1t0CE4L4P/ofC46FGipX1JBgEB2stGTc6LdSs6MFdwYJvzXNZ
	 RcU91f1qodRi9jijTbDVVujie/ROhbpr8oES5GF8Ei30OQMoBAPXnZzhW7936eMbD
	 812TmuCkbonhKIWukbyzDFxKEJHLJ8VUVCiRewkVh2fRlbkSzXiDK0zenwXuOlAB/
	 hv3vdDZh8QGUlidkKLXIbGSHik75lsPUKL4lWELCJ35M+8gNzciLl/20B+wHQVf0n
	 WyHUU3COb6Tnf/AxOkIXZhN74HKQVrX23zf5e28Uahc04cGThExt5PDhKeVGHH9Kv
	 0uF3I5YA9kZhpLWDbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1rg8NY0GD3-00SlfO; Tue, 26
 Dec 2023 22:08:45 +0100
Message-ID: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>
Date: Tue, 26 Dec 2023 22:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTWf/3pMdRLUxPK+7SigLP5bPdm7FDsywYZQ9mwWxZfd5whVnCt
 MpaG/wwAiJ+sAZKc6e6X1Oz/1ZvXtXjnkODZUnt+bPGTOKeqGOVarq7b09RvfwmwaobPYhv
 KDhF1hQXXBN8GuJ0LTAHm1CZ4IxwZK1aaTGupnbJ02bufrYt/IAux3FnT6U3qknPSj45Q+/
 sM4ldrJWXAvku4s9LD7hg==
UI-OutboundReport: notjunk:1;M01:P0:gyXZStYDyoY=;GDeU6aTCaab8G0WZXtNI8pnZzWu
 AE4N9T4klh2nfVsoFShDJW1wxRW8rFfrqpo2fPA1EMQ3gvMhs06+w7BRKvHNEBsyBBYQnb4fm
 47do65ab7gRI4Qeg23lUUUYYhg9z558S4k+JPdkk96KJqK21PxbcyyuRcfCqb/77cbigVAAG0
 olOPq2zwGtDuxkf5iES9zBRvPBlrI4CztB0TRxSj4APatPxP+BlumQbKW9TrSogAYGIGMTfxe
 PBOYShATgW2D7tGlodpPfDp1XKEFwkGqs/RSoX+sJ01ouUmVwTFSHq11MPKpoqLGjfUiK5dlG
 Se3gVVyNUtAQmwo6grggI09WjSDeaU8Vun/z+4b6QbOUR6y2KZhNWcCp1bRi6vQF2RucgDq/a
 0+R1bcWHISu2tq1s7M06PabcEPd+G8vm5ciL5ngRt074aoH3GvPN9Ajy7QBAnE2dfhLiHoBmS
 1CLZlkfmaiMqU6MCjH6fkzXSv5ZB/fS5/s3YdSDXep/QdmhN/wkco7s3tfJfyd188vhHMts3+
 X2lQ8clwWngpuOCgo6n+MToFfUOnM5If/rU87/1U6st0oZ77rvpXEh3m3RwKscEzUnnsp0Een
 /ECc7rgoF4bhE1kq+IANw9UP8dGJnPA6hsJeaPQoUBq64lJJOus3xYsrztwOO0t7HXUQJqdSi
 pMPZkR1CxZl9fMcELNN2x1hdnb11WI90NWRU7WU39Y4nkkkeL1eaW+1qIY+oTzTMUVh9QPjeH
 grRxIWi4tyjWTJW086I+88Blwlqp5VOxFnQC8ADJ097tsnRXOfOXOd+aNwzHfU2Zgj+MfOxq7
 M4K0w+9PwvKNwSE+MxO7iKGoJwE+lqBjFiXARibkFLwK0L62KlRJJX0sWvnKD6sudciS20AKu
 bEJD8G9V2FNHGft1QPNc8HDGkIosSoxjuw0mO4f6HbS4tTqCleKdBahpjY4M6Zrphe/bdxMRE
 n0Eupw==
Subject: [cocci] [PATCH] leds: trigger: oneshot: One function call less in
 pattern_init() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1407
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/c73761c5-7150-4f20-9b3e-1da680400250%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 22:02:08 +0100

The kfree() function was called in one case by
the pattern_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/leds/trigger/ledtrig-oneshot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-oneshot.c b/drivers/leds/trigger=
/ledtrig-oneshot.c
index bee3bd452abf..31061ec0afe6 100644
=2D-- a/drivers/leds/trigger/ledtrig-oneshot.c
+++ b/drivers/leds/trigger/ledtrig-oneshot.c
@@ -134,7 +134,7 @@ static void pattern_init(struct led_classdev *led_cdev=
)

 	pattern =3D led_get_default_pattern(led_cdev, &size);
 	if (!pattern)
-		goto out_default;
+		goto out_settings;

 	if (size !=3D 2) {
 		dev_warn(led_cdev->dev,
@@ -151,6 +151,7 @@ static void pattern_init(struct led_classdev *led_cdev=
)

 out_default:
 	kfree(pattern);
+out_settings:
 	led_cdev->blink_delay_on =3D DEFAULT_DELAY;
 	led_cdev->blink_delay_off =3D DEFAULT_DELAY;
 }
=2D-
2.43.0

