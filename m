Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53057C761AF
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Il2SDzrycFJ5DpdhRvit2CrWUX8a8mVUasD2Yu9go8E=;
  b=q0hV/cHehepRbYOWV0bEvii408kW237VWHF/iR9p5VYtx37lXdHnhvBe
   Se+1RLngqbyujUdAa15B2gVkT1uEtZupchf6dxUZwumIhUVxx7qQNDMlz
   Zu1tH5FTHShAH4L3s51J9q0DBp4YxU53Fc7CkpHY8m6XLRCF8Ws0cRGEw
   E=;
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
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99851553"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 10:58:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3271AE013A; Thu, 30 Mar 2023 10:58:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 15EFAE00CE
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 10:58:01 +0200 (CEST)
IronPort-SDR: 64254f17_hLLmQ1woKdBPLb96M6WZ6jfn7TicBavAivb9dzKl77pNid3
 YPIbI6d00yHk6YNgiyTnqOXnuviYLxC3syLBl2g==
X-IPAS-Result: =?us-ascii?q?A0FgAADCTSVkhwwR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4cshzqIaYFWgUA+DwEDAQ1BAQIEAQEDBDiERgKFO?=
 =?us-ascii?q?gIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHU?=
 =?us-ascii?q?z0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQesG38zgQGCCAEBB?=
 =?us-ascii?q?oJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBPAyBCYIsiByCZ5lTCoE0c4EgD?=
 =?us-ascii?q?oE9gQQCCQIRa4ESCGuBfEACDWQLDnGBSgJkTIEvJQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPLEQOQjc0EwZcASkLDhEDU?=
 =?us-ascii?q?IFHBIENfAoGASYknX6BDoJ2wyY0B4IogVWBWQyfDAYTLpcIDgaSIy6HLZAPI?=
 =?us-ascii?q?Kd6gWoIK4FcMxokgzZPAxkPjiAMDQmEA49IPzQ7AgcBCgEBAwmFRgEBhXsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 tWdzMobxx9d/tiS8cZOXqDp
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:88mKka6sfuK8TzR8nAPXwObXdLJyesId70hD6qkoc20zTiSZ//
 rAoB1p726TtN9xYgBbpTnuAtjifZqxz/NICMwqTNOftWrdyRaVxeNZnOnfKlTbckWUnNK1l5
 0QFpSWY+efMbEOt6bHCX6DcurIruPqzEniv5am854kd3ATV0hP1XYDNjqm
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99851513"
X-MGA-submission: =?us-ascii?q?MDFNj27ebD4mOpZjs3/JwdkrcA78OEem/RLj6N?=
 =?us-ascii?q?WVGTUVivXDuhapniWWn2G7ub3GdBhdSqmlZ8gzrOcvMaayQJNrr1sLDh?=
 =?us-ascii?q?XNuFPfoGjpdtVKWq+aRjf3KriDVNRzhwWJHdLZoEvdArr1SXEzxCNpNE?=
 =?us-ascii?q?/ocqYSkMBzgA9QIcLD1JutIQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 10:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680166679; i=markus.elfring@web.de;
	bh=zuGybFBApN87b/wBuQJadcKoHb99zesNX3Js+eJlyOA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jr7ChPJR114DHc5OSGsUE5M/gtQSVOjB2pL+DtvROGyyiTbkJ/DjADj1/WEp9ewC+
	 Ve78KfW12ENZyrkUk1KoP9yzFRY1vk1YFwA8vRMhUzmb8DPFVd9gPzD0NlgaBRjWpA
	 eD82L5stVPVQVah3YjjScSr4C8kU/m3Rbr6PmMWVWlglYNKedlFE21xYxZUYXx85pY
	 yGKmeY3PABZL1wZOjPxNXAiNFIMkAqoWUbyCbX8BMEozDkFAQzkUKN1GA1bzgZiGpL
	 HMXKaSspAe59w9mVl4dghTt0zoW6eKGTak+YgcjG9vbQ8WZ1BiS9bF/BfZVNXZmZ9u
	 PcQV9hSqYfVqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1q574y3DDT-00Q6xS; Thu, 30
 Mar 2023 10:57:59 +0200
Message-ID: <8f1440fa-378c-7152-27a6-d73e0eac8bbf@web.de>
Date: Thu, 30 Mar 2023 10:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
X-Provags-ID: V03:K1:9A6DS4KijbegplE/pESCHCb+h4nw2kGePGAuGhHkAa88NjmdlXo
 bdA3IpLDxK4DvTfeZK71PvYAhwp4A2MlhuMRwffkoEMhF8UfmxYa+GmAGHMJlq+ABYYTqBX
 CG/zGIqrGQhoxRxPg3zGx4SXNOkVaDzctAt319VTQ6jRbetEJhvdZTJmdizIdIIrgnp1HqM
 PZIWXnXljfn6qBDz4vahA==
UI-OutboundReport: notjunk:1;M01:P0:t6249x5DxGE=;s6a3eoUsfXfmI4YSigyhiK+yMPX
 NBflzEhwwZmtGk6K9ls7gCsBbg4qYBB7TQjz/1nZ8Xt/mEXURdPACFFmowl4+Hyh70KfJpPLS
 hxIKm40AweN18Tj9JeW15ziS9VoH1C0xpLRL8Y6C8qGYHSDzPxewuBSTPjCl9T+k7CPeOagvN
 /IWmfE0XLNm5ooLPeaEPNx9bCnqrLqNNGC7XSV25Vnz6av3ii6o6/0nYoYEIVD9mNxJGxvAKD
 HDP9EhP6rRD6QYCapVodRgMCFxx6yyJVm+sfrmfmDSMRGHEJx8SipfHBE9GqvEgdltOwsAyLX
 ++M+2Vfn8ObfNN3RY7GKqrms7JcSgGxByUjat+RLZ5l4h4nRfO8aRuGKUyIRv8ISQMcK+3Huj
 xxBFxVHH5mDwJzXkgjf08tngDotEVPvRGPfEX+XiR++2e2NX4wQvQItnrxEtin2C+uWAvm2gQ
 PDQU5NqGNedRkYbnjd1OWClYhJlqRiagBdy7i/r4MPOXBd9CI0j9oDMnen+wAA7pz1nsH5UtB
 1rEq84ZKYLtghS72no4dNRzMmhm1IyddkEsdFArl5BGnHEyuA3vV0p+LrFvVVTHEjezFQgFeU
 dO/WQZ5aYWHKgJkj74h+PGq0hGSZRI1UOgEUl962vRRRuPUb1fzHz73YZcotMs2wmcBmTbF0h
 bSlqVmzx/BEtPO7UUhO9Q3YKTgO7mU9z2TtVDx0hHs5VjbbM/ZEjbsBe0q9SWM+od0yYrikpg
 qvPz5BX+Xvj+yMEmpaQScBrkniICRY8Qrcsvu14FsaDm5VIbpTPnNThYseDbGmXhqkVFur2fY
 4vvu5fZTdLsErkXQ3GBpEJkHTYg6F4ihqAntEXcjLMgzWkp/GY2KnWjmTDt4+ud/GmM1/Wyp0
 XH/UG04lOkIcOHsVl5BOfNNHkFqTyCxhb6YIBFyxt14JjUGsWz6gfVv0F
Subject: [cocci] [PATCH 2/4] overlayfs: Improve two size determinations in
 ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 990
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/8f1440fa-378c-7152-27a6-d73e0eac8bbf%40web.de>

Date: Thu, 30 Mar 2023 09:02:10 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/overlayfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c0d33ab331ec..c721d6fe9cb4 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1899,7 +1899,7 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)

 	sb->s_d_op =3D &ovl_dentry_operations;

-	ofs =3D kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
+	ofs =3D kzalloc(sizeof(*ofs), GFP_KERNEL);
 	if (!ofs)
 		return -ENOMEM;

@@ -1941,7 +1941,7 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	}

 	err =3D -ENOMEM;
-	layers =3D kcalloc(numlower + 1, sizeof(struct ovl_layer), GFP_KERNEL);
+	layers =3D kcalloc(numlower + 1, sizeof(*layers), GFP_KERNEL);
 	if (!layers)
 		goto out_err;

=2D-
2.40.0

