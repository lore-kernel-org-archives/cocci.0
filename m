Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EF1C77B7D
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=04SqNDSbNHJygQRygL8QahQFolHlUXb/LmJNoE0eKug=;
  b=tlTOH5Q21dQt0TH5vPPOAJHk9VX5/XuN4kWr5fvALyp/dWr3xb0cwqYp
   LYBPnqKNbhgqTWlctQN80J8lhNPx1EmBozaFdv1CjNMnekXjLvIZKmBAV
   OHwJAHHgi1HtNUOOIrPPiGyVc2wNCWXeGxYbjAYzoucJLD7Gnlq6zONMa
   s=;
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
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677490"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 19:43:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2979FE00A8; Tue, 18 Apr 2023 19:43:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C8D0FE00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 19:43:47 +0200 (CEST)
IronPort-SDR: 643ed6d3_FuUTv8H6V1c/pPvWZ6aUG+LU/dNjjBKlO2JlQDGeKCq1UGf
 OR+MpqjKh+WTB8o+MTSIvVvm+c3L+bgvFKYaQkg==
X-IPAS-Result: =?us-ascii?q?A0E2AAAz1T5khwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGhFORBTGEMI5shGeEA4FWgUA+DwEDAQ07BgECBAEBA?=
 =?us-ascii?q?wQ4hEcChTwCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgINOj4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnoBgicBAzEHDKwif?=
 =?us-ascii?q?zOBAYIIAQEGgUABgSKZKB8sIlSBXgMGgRQtAYxRP4M2eicPgVVEgTwMgQmBP?=
 =?us-ascii?q?m+IH4JnmiRFgTR2gSAOgTyBBAIJAhFrgRAIajmBQEACDWQLDnGBSWNMH4FcB?=
 =?us-ascii?q?AIURA4YBg4lBA4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGG?=
 =?us-ascii?q?zQRAggPEg8sRAxCNzMTBgVXASkLDhEDToEiHwYEJGd8CgYBJiScTIJlAYENL?=
 =?us-ascii?q?FCBesM+NAeCK4FWgVkMig2VAAYTL5cJDgaSJS6HMpAXIItEgW+aTIFkATiBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gGR6DboRhimc/NAI7AgcBCgEBAwmFRgEBgyYtgioBAQ?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:Pu3316EU7pLV6i34pLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AC1iWUWvBrJDWcNT+PiFLPRcl6Is6Sl3Uk33VAnS?=
 =?us-ascii?q?5Im1qa4GuRGeLpZNrxp8=3D?=
X-Talos-MUID: 9a23:RvRaxgZfIXBm9eBTr3j+pAthbetRzpu3EmlWq6ojpsaiOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="53689647"
X-MGA-submission: =?us-ascii?q?MDGMpkOIq3vhib1J4e3S2uaZiryPICYz3aZaQi?=
 =?us-ascii?q?uu0DQSvJ/Sqr05ALxD8jstuxEnOcK5yENW3E8cgAoT4H6GoFM9wlBzF7?=
 =?us-ascii?q?2D33RHPiujvofc4yYGqSz7nvJBV/gk23ULM1Vda7CiZ4ssTiUHXTLWFy?=
 =?us-ascii?q?H2vjECKXKXsAEMIUmYqjEQBg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:43:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681839826; i=markus.elfring@web.de;
	bh=WifYtUn9le8/rr4oOOYjp+L2QmwgWZ/Vtej1JcBHGjs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=aDUHTKnMHD7uuvARf9T9WrUQc4hMez0Yquf0GeAbwe0f97KRJkNYVTgF/3j1pI++T
	 X7EAc3MevhcoFjK0FtSf9fVVaP26ihPrUZvTZXEPeUf5OOYCZd8iqh+ayzVx9aGFP8
	 ZFm1qQBnyLhLjhgdgndGmKzE40aGx98uTfWHS616uNQKJtUWTmqeTH5/M60MA5qyr8
	 TAyLVjYpwaunPgxjuehk84rH8Yv/PC+Po8N1ZnFPO1vhL8WZnm27J7Jhl4ao3mm2it
	 LTkCKrP1VKbL0ycKU7eYPJXKc57BZYRq7p+Xl7y5Tz6acUMLlwupHYf/kgjB8GTQqT
	 e4kL9FDx99j8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1qDk4E46Zr-00juhg; Tue, 18
 Apr 2023 19:43:46 +0200
Message-ID: <90eefb6f-7777-8447-1e7b-74ebcd603f68@web.de>
Date: Tue, 18 Apr 2023 19:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
 <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
In-Reply-To: <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJzYCK4tjnZFoam3BkkbRGpdPdIpqBqgkr1T/foeqhHUaVdUg+X
 ZilvXf0wEn+byz2uBffrcraidyRpMK8YBISbzxYljZ8UiqbEDTFdXb5hXo3ks6yfmMcSnZT
 AEOn4BFvwrMvOq4arq5hn/PfX8Ft+/vfg6ONjqZg09SUUsZ6QlZKlyiyzJ3tclKph60ZxNF
 3jB5HPTHXvgqJGzOB03KA==
UI-OutboundReport: notjunk:1;M01:P0:bhtev8H/ojI=;E65P1Op9nwEKtnBckMz6kVbalxx
 Z24rWphTO9eWez/N5PrJqQS5B5x4a4HU5lDr/2ugx6pcpXTzlrxgBp5l4jMxMRZ+4SHDCUuEK
 Rnl83wC9qdmglou+o3iUOaTmWgw8InqzN3zKC/ZJ/1nens5EWg9aw8som1uUtvjVXpfQCf6sF
 06ljbNfivO4xwJIbuACOOlqODoBW8RV/X9ScIIxtEtLvCZfEfwkUpZdAk4CPSExAbrmlCXpW0
 hoKS0uxjIArXquAN9gtqMMmqLdwKF0s7GH5OD52wKGiH2dcGjMg9fbphUHV3DkjfzZtDvPhFL
 MhFo0sCgbLx/RWjM6DE79a4dwoI43+4ibypm99jeSl63h7m8Iz+gvI3l4Hg9X4bCk4GGDLxXZ
 JoqU3qJXtT9stZu/eOADPT4JQX/GFteFZtxHRvKBXvRdWwvF/tAIyHnAMBs82wk4CmY6OxNb4
 YmabP+KlmnHboHKmFcrNZegL/PLeC3x4RB8Dv7Bpn6uIPfjRG03SrC+4WtOTizNUq6UzkLFuI
 nPU5yV8+qWAS3Xa+V3ADjf796z8qNo64Y3oGmwdLl0Z61FGuzi1K7sGwYW4Qv1FCyMiFYVL7f
 3J2uDXTP2xFV6KyRT533p7U4gV5DE1useDCpOzrtAU6wwXLbfOsAyVP8HDUVjTjCH5wRTW/cj
 MM1ZykKnl3DxYzKWss5OrCXLASXAUFvzjTldL8X5nTwJ1hmhChaRMf69reK47S8sn1GYBVD6b
 3cTmz4JlzijrRq9sa0ZLUfQa2u7yhy+BXB4QkazWIzAiJeEpUcsRXCpQLtIOeORzQVPPFMsX5
 ClFJhziLsor7TUcxiRw5PDQygfCNJwzfTkMfyuDYMT9MVP+8X3cNFp+9IcJj0vTZB00Dck4eY
 tZH8yrEfZ6BPPoLrIrl9trXO2FLCe+6gofH98VqjSbi2P8jRkgFXt7DXE
Subject: [cocci] [PATCH v2 1/4] media: adv7604: Delete a null pointer check
 in adv76xx_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1089
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/90eefb6f-7777-8447-1e7b-74ebcd603f68%40web.de>

Date: Tue, 18 Apr 2023 18:21:00 +0200

An extra null pointer check became unwanted
for the input parameter validation in the implementation of
the function =E2=80=9Cadv76xx_query_dv_timings=E2=80=9D.
Thus omit an if statement at the beginning.

Link: https://lore.kernel.org/kernel-janitors/8153cc88-2cea-0528-9d54-bda7=
2cbaac5b@xs4all.nl/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv7604.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 3d0898c4175e..d92a681f9176 100644
=2D-- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1565,9 +1565,6 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 	struct v4l2_bt_timings *bt =3D &timings->bt;
 	struct stdi_readback stdi;

-	if (!timings)
-		return -EINVAL;
-
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));

 	if (no_signal(sd)) {
=2D-
2.40.0

