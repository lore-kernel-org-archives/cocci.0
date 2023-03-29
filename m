Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9A3C74A5B
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vKa+TdD5t7wDoBpffRD9tjfKnRkQxtSrmOQOWuATsLU=;
  b=StXzgPt3f5dMCxgDVMA5dAo0bvn+S7mXMlUJi15arZ+kf6xoN/fU7fQd
   X1I+qvwJ2kO+4/+WCDkREJq7Gh4mtLJQEvoBzYPUz5WrOlaUfaN95Dufj
   ccZkC7VVKUTIQtNllO7LkeFZh6j6TrRlc39SFEUmR2YCY1tAykk/bKG4p
   4=;
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
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99722706"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 15:40:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 595DFE0B4F; Wed, 29 Mar 2023 15:40:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD5A3E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 15:40:10 +0200 (CEST)
IronPort-SDR: 64243fb9_YIfL+OZ10k8TFccoNMRwnmJ3ZiLEZZg7vkrKEhdGaRDtyAG
 +zLnRoH1mWkU7gJ0swbY8hDs41GtX6SfAbNDZjw==
X-IPAS-Result: =?us-ascii?q?A0FCAABsPiRkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORATGEL4cshzqIaYFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiERgKFOQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0DAyMdAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB61lgTKBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIEVJwyDNYgcgmeCKYdVj?=
 =?us-ascii?q?0kKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMH4ECJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPLEQOQjc0E?=
 =?us-ascii?q?wZcASkLDhEDUIFHBIENfAoGASYknWmBDoJ2kliOdoNKng40B4IogVWBWQyfD?=
 =?us-ascii?q?AYTLpcIDgaSIy6XPCCneoFqBi2BXDMaJIM2TwMZD44gGYQMj0g/NDsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWz8HpL20QpuZwsj9Lk=
IronPort-Data: A9a23:z9/wXq7SXYOHwPU3g3400QxRtCvDchMFZxGqfqrLsTDasY5as4F+v
 mAWXGjQM/zfajGkf4ojboiw8klV7ZTcmoMwHVBorn89Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhnglYgr414rZ8Ek05K+o6WtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj67JDHR0UJZY1wdxqAXtRx
 /BHJ24Lcx/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIehWtYasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw+QPK//Bpsze7IApZ2eTvYfTWRIGwXeJ4s0uTm
 mbfp0ikDURPXDCY4WPYriz137GncTnAcIkVH7a53uV7hUWagG0VEhwfE1WhycRVkWa7XM9Db
 VMZ8GwioMDe6XBHUPG6cgzkgmafkyUmRtpKDN82tw7TzLfbtlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmOPEIZ563ujMxQ5eKRT5PkdfPHFfHFptD83L/N9q1E+nosNLTfbt5uAZDw0c1
 BisiEDSbZ0hgNAG0a+251/KhVpATbCVEVBvjuk7dkSi9B95LKS/boah70Sz0BqtBIOeU0XHo
 3UO3cSThAzvMX1vvHzRKAnuNOvwjxpgDNE6qQM/d3XG32n8k0NPhagKvFlDyL5Ba67ogwPBb
 k7Joh9275ROJnasZqIfS9vvW5xyl/i6T4m1Dam8gj9yjn5ZK1/vEMZGOhH44owRuBNz+U3CE
 crGLp31VB7294w+k2rnGo/xLoPHNghnmD+NHMmlp/hW+ePQPTaUT6sIKl2Dcqgw48u5TPb9o
 75i2z+x40wHCoXWO3GJmaZKdAxiBSVlWfje9pIGHsbdeFYOMD96UZf5n+h+E7GJaowOy48kC
 FnmBhQHoLc+7FWbQTi3hodLM+uwBcsu9i5jZkTB/z+AghAeXGpm149HH7NfQFXt3LULISdcH
 6ZdKfaTSO9CUCrG8Dk7ZJzw5t4qPheyiA7Ee2LvbDEjdtQyD0bE6/31TDvJrSMuNyuQsddhg
 ruC0giAf4EPaT4/B+nradWu7WiLg14jpMxIUXH1f+ZjIHfXzNAyKgjarOMGHMUXGBCSmhqYz
 1m3BDkbl8nsoqg00oL7uoGZnaiUEs9VPElTL0/E55mYaAjY+WuCx9dbceCqJDryakL9yJ+AV
 850kc7uFeIhp0lblbZ8H5JA77MM1/G2q5B0lg1bTWj2NXK1AbZeE1y69MhotJwV4IRGuAGzC
 3m9yvMDNZqnYMraQUMsfiw7ZeG+1NYRqDnYzdIxBG7YvCZX3r62YX9+Dim2qh52DeVKads+4
 OIbpsQpxRS1iUMqPva4nylkzTmwAUJaYZo3lKMxIdHNulIwx0BgcK7sLHb8wKuyZuVmNmgoJ
 T6ph5T+uYlM+3qac1cOESni4OkMo7UPpxFA83EaLXurhNfup6E6zT9RwxsNXyVXyRRLidxyH
 m1RM2x0OqS80DN6j+dTX22XOl9gBT/I3mfT2lc2hGniYE3wbVP0LUo5IvSo0H0C1mBhIghg4
 7CTzVj6XQbQfM3e2jU4XWhnoafBSeNd2xLjmsf9Oei4BLg/PCTYh5GxaVoyqxfIBd07gGvFr
 7JI+MdycajKCj4CkZYkCoW11aUidz7cHTZsGcpexaIuGX3QXBqQ2jLUckC4RZ5rFszwqES9D
 5RjG9JLWxGAzx2xlzE8B5BdB59vnfUs2sgORaOzG04CrImkj2RItLD+y3HAoVEFEvRUrNYFC
 4LOdji9PHSaqllKlkTs8sRVGGqKTuMVRQ/73eqKobwFPM9Ygt5NbHMd77qQlFeWOTtB4Bi7k
 l7iZajX7uo60qVqvdLmPZtiDjWOC+HYdbq34iWsldVRf/bjDNzrtT5JmmL4Pg9TA6Qda+53m
 ZuJrtTz+kHP55QybEz0hLiDEPNvyfipfe8KLP/yEmZWrRGCVODo/REH3WKycr5NsdFF4/iYV
 xmKU9SxefEVSuVi6iVsMQYGKCkkCoPzcqvEjgG+pa7VChEijCr2HOn+/nrtNWxmZisEPqPlM
 TDNutGs2IFonNwZTltMTfRrGIRxL1LfSLMrPY+5/yWRCm6zxEiOoP3+nB4n8ivGEWSADN282
 5/eWxzib16njckkFj2CX1Ba5XX7zUqRgNXcumoY/MNqzS+3BigKIIzx9HnA5o58ykTPOFPQP
 Vkhr1fOzQ3iUD4CfRiUDBHLQFKEHuJXUjvmDmVBwq5XAhtawKufDbEn+ioID7KavNf85LnPF
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:YcU5SqlIa1ilKdzYY+2CGv+Vpn3pDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99722687"
X-MGA-submission: =?us-ascii?q?MDHD4y/409ChriTB9lt4sGmty1RbEqwOd6cpDi?=
 =?us-ascii?q?7Z8VGeid4FrAL4nERUl105Jvp1pnvEyOS6KSUYMlw0lErpkTEKEIsKc5?=
 =?us-ascii?q?UmEA1Oci2FblGEOnyVYU7CxoVXp5znpW3lY8+89ok1b+ySRddKp7Lbzh?=
 =?us-ascii?q?ukSyo3MDVdrhfU5Jizt94new=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:40:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680097208; i=markus.elfring@web.de;
	bh=xm1Gr+53XVq21wzSzf2W9qt33ydlVjL8cbcG72ewbl8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ErowAxompTVcoLvHTk89wgYQyUNYFH8RI1Gr6nJqHbfJrdvoLA3HSgdGL3VnUIrLe
	 4/PMuS56fLuYS3nJdpSX6sbLX3N1rkysMChyKN7bYePRrEXpxQ9UZmkCmMfq2PUUIZ
	 hWAVMQn2suEDQIlAI8DLQ2M03aMxvXnNQdIS469l6uF9kVUWZAhRlIEAoi7RruDjqL
	 rT7JH3+ZQxpG5BTjaZc3Z+lIVJ0LJIeMa2rrhpiQZ2Z/W0TdaEtHr13VmYGI07a/hx
	 QlW7jlktEUOfdFwEzekzN6VEk6LkeZlefekO9GwAkuqWDfXJWvWqlwMZhqvKZrwoK2
	 b8okXRlJ+0rfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpU1w-1qDUBg22FY-00ptK7; Wed, 29
 Mar 2023 15:40:08 +0200
Message-ID: <18b0a6f6-8a18-2073-1e73-78bceac03fad@web.de>
Date: Wed, 29 Mar 2023 15:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
In-Reply-To: <33226beb-4fe2-3da5-5d69-a33e683dec57@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tjpUXGBUbazH2ycCGpDC23WGvZjghstW4Fm6jDIuzxXEy/fGP1d
 JheX7zKpU/JNx/dJ/cu6lzamZ7kAvH79NWdD5CztkM9JyxGByjnlSUxi3OEWU0m2FAkr6qD
 Q8mcPAxbPK6My+Gcgx39xVyOS+bUWLiVy3l9mN/ShuO47YXsyG1NQ1DlKIPrN/Av6K1oPVe
 LqbPbARDPlvXHwFo6jEkA==
UI-OutboundReport: notjunk:1;M01:P0:xD3x+xOO/HY=;aXqW5qTF9R+a+7+j4G1kIYoyv9T
 NkqjIywnQ4a9TJPeaVaLJdWte0PX86qnC8MNvctjeN3VANn38TxDT/rNMeY5wFSTU4siaYcMZ
 FT9shSOCrZx1ulWB9t5wZzbRRhHAbalkuZzjgo2k/Hc5ToRdHxXMfw2YVLU9oDw4T55vPpZ8u
 uFetDmWPcpph9wfqnkwlG6fWzdkmadWrgMaHwxS/Bk6cRSTx5rrgt1FH8bzbIZpfnSGAAIPzp
 alcUGJVkE7GTOuReqNrrJWTOEeNWeeXygkX66rnFYZmHy5+lV+LyquVJWM2UQtHjUgoubDWe1
 mtgx8GIzg5Pm51inUGDtwbIf62DveW24TnU+OnycWfWKMILxgsN8LKvBR6WVR64o6iRJGm+ow
 NXUuumC0EABQKdOmULuCzz0yXdUnXJXiWeHGUoLkoYv4VSgsqLbw3RXc47KfULW2ea9AAdcEF
 8e8N+CQn/TBAY+JC4jJxNtg0PUSZ25bSxlzyLyJUxO6i27vb9XzNiijFmMS1HC2irKscGZ/Zd
 p19Uy3Nl4psmTXtW8oWkdETPrBgQgMw5gpiRY8hSPEln1oVl0lbZ9SBJVdrB7n3WzwiXDc3Z8
 nsZYAfRyeIA/V0k2gHSH6SnhEpRV43yuKUeE2SUtI0/8WBMOGkf3nIR4afgpynBHM9PFFACsx
 kUhFarN9EcbINLrq8PhrhgWrAyLfE+8vsMtQ2DX9gU9D8UhZ/x6COwFmltJJXPBk0mcA93mBC
 xJWxy2aCgfpjhv7hRP+SCNzZQKpc1WdsJOgvJ0K9iplExttuvxcC56+a3cIjYxUNFa2t8wioa
 hJj+O5Q7GKM6xE8ivB/ljt/V0PsYGGPqSPIlCxt5qrKBmweva23avirHPWtBaYr1nWcF8vu5P
 D9cG4tMovTaIss8xPWIftjTxI+wZgcEv0Is/6U+GIKOpd6bLH6giriXKf
Subject: [cocci] [PATCH 1/3] lru_cache: Return directly after a failed
 kzalloc() in lc_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 984
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/18b0a6f6-8a18-2073-1e73-78bceac03fad%40web.de>

Date: Wed, 29 Mar 2023 14:45:34 +0200

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning in these function implementations.

2. Omit extra initialisations (for the variables =E2=80=9Cslot=E2=80=9D an=
d =E2=80=9Celement=E2=80=9D)
   which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d9187611de..e0db27b3a2d7 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -78,8 +78,8 @@ struct lru_cache *lc_create(const char *name, struct kme=
m_cache *cache,
 		unsigned max_pending_changes,
 		unsigned e_count, size_t e_size, size_t e_off)
 {
-	struct hlist_head *slot =3D NULL;
-	struct lc_element **element =3D NULL;
+	struct hlist_head *slot;
+	struct lc_element **element;
 	struct lru_cache *lc;
 	struct lc_element *e;
 	unsigned cache_obj_size =3D kmem_cache_size(cache);
@@ -96,7 +96,8 @@ struct lru_cache *lc_create(const char *name, struct kme=
m_cache *cache,

 	slot =3D kcalloc(e_count, sizeof(struct hlist_head), GFP_KERNEL);
 	if (!slot)
-		goto out_fail;
+		return NULL;
+
 	element =3D kcalloc(e_count, sizeof(struct lc_element *), GFP_KERNEL);
 	if (!element)
 		goto out_fail;
=2D-
2.40.0

