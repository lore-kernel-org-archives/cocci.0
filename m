Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C62C74A5B
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=snSyjH4npOa5TIypPWZu7J8zbAA5TfZkJo5vseoSjZA=;
  b=ViFt1xc0XTK/ykMskqn/KIkCu0WkuIWatzeYKRP2HiVM8wnI8fBdgpAM
   2zUhO+2dWejbfFm4cxXoj8SDFKizNzWKkHYbppfS/WrL7KzNkPwlF08Mc
   HjgOW2otmQUer/dD5G8gUzt6bTqhNBEseje+KR4z7s2b/GFa7mfvhiaya
   0=;
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
   d="scan'208";a="99723592"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 15:44:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C4020E0B53; Wed, 29 Mar 2023 15:44:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C56CE0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 15:44:45 +0200 (CEST)
IronPort-SDR: 642440cd_GMoyYXhzu9QA28BsjkfhtroByu0DRuF5zSdvG0s5j1i9Xlu
 YYqOkWXRULb8pLheH3kI5uQuL1IdRu3v0ZTH8Fg==
X-IPAS-Result: =?us-ascii?q?A0GIAADqPiRkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORATGEL4cshzqIaYMWPg8BAwENQQECBAEBAwQ4g?=
 =?us-ascii?q?VOCcwKFOQIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQetY38zg?=
 =?us-ascii?q?QGCCAEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFSeBFYIsiByCZ4Iph?=
 =?us-ascii?q?1WPSQqBNHOBIA6BPYEEAgkCEWuBEghrgXxAAg1kCw5xgUoCZEyBISUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYbNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwSBDXwKBgEmJJ1pUztMJoIEkliOdoNKng40B4IogVWBW?=
 =?us-ascii?q?QyfDAYTLpcIDgaSIy6XPCCneoF5JIFcMxokgzZPAxkPjiAZhAyPSD80OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 DMXzLm+IYlBb+XG
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:BvZJ6aFszunqDrPwpLqEHMeALOsnbusQ8zAXPiBKOGFom62j5r
 iTdZEguCMc5wxxZJgfo6HjBED+ewK7yXcY2+Ys1M6ZLWzbUQmTXfpfBPrZrwEIcheWnoU26U
 p5SdkFNDSXNzhHZK3BkWqF+rgbruWvweSHosqb9W5kSUVRYad6425Ce3imO3wzai5qQaAlHI
 eB/KN81kudkdp+VLXeOpFZN9Kz3uEjeaiWHSLuHSRXlzVntVuTmdnHLyQ=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99723579"
X-MGA-submission: =?us-ascii?q?MDEaBRjspzSTg8dsW3wR7pMO6ne/ny+hX6cAg9?=
 =?us-ascii?q?UksweN1UE82/qGO8uS2rsKnvDDTUsHBzGc84LZvDcjpQ0Ru0yi3hAkvz?=
 =?us-ascii?q?hWSufvB/EP8fi/hUiAynGgQTYMyBihjYrVEgOtVtOqubXhQlfb8dx+8v?=
 =?us-ascii?q?JzsBUvVWR1osE1ewDyR/GXHA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:44:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680097483; i=markus.elfring@web.de;
	bh=TvIQUNQPstY1OjSfC8Y0Y21nxMV5PI207ftVdNZHAVo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=gs1neYbzhRkJpJjhVkWToHE59is9t3Oe+9UrBwtjBhPh2AO14WjrVNBGVMPQZckoC
	 76naGGC6fI1AYkb3mmz9YDR0HatjLdub41onTEXVWxae3v76Pcnn7tsKVOZkKa9wlZ
	 qUNN9VRGXprBWxyh5/t0ivtDn8AGnDKWOrgjgpu0pgnwaTU61o2IV2ezjB7jbBjVNR
	 nmeDTMMnmLMlsNeAZDxMDtukIeCXntc+aYjNH4QIeb5tZDrWxN0lVKMHgGXjhYnyFc
	 rggvy0u0f/RQsqD82giiPWzwiysIltsp1N4u/jUV4JtCLAmr6VBN9AeOq3EJQGvoWy
	 zIs0lNXq31oaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1pzsIj45Hn-00IVBH; Wed, 29
 Mar 2023 15:44:43 +0200
Message-ID: <ccdb761c-9ca1-fb59-467b-fb4d34adc65a@web.de>
Date: Wed, 29 Mar 2023 15:44:42 +0200
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
X-Provags-ID: V03:K1:iTl8rae6//Yib+Bq9D0Db7oy+MObKf2yhz5O+cXp1jAFcoV1GPk
 zLVt45gNVV4yh/tqfJtnL5pd9bueLyFqKa/MGTDv/k2VFmUWKts8jPsyP8LORsJG1QFLrVg
 Ig1doPGEYvpVYcAVvgsVxqwwj5ePkwvCdxcs9l8JLDdcqM9TAFXBuSCUQxBK/uH/IFjN1gk
 GIbZtWW+dyZ1qVkFmcJ4w==
UI-OutboundReport: notjunk:1;M01:P0:HJwFvu8owrw=;TT9zAuSwIzATzVJg1TLJ2xDp7/a
 UPzzHgdJLpZjdEphyFdk5LRib9CFieVv1MQnGnDG+W7wUp1iHcnYUB7IXbsVYuGXnuo9n+S7I
 LITYoMQ+blQiWWOMz6mnGlkGjoO16kbLiC0P/nxBMMl9qS0JO+RBxSwL1PQAfsAN9XmZZgt8C
 THn/rHMlZBrbkeK//oipwwgLrFYsunzqQBKYvWNWc+BMWzg4/gzsKtqSNFOW+5EAxb3gqQlgX
 1p52EORVRQzr9NS2KqwKKP0kXmVXUlHgKwDErSnDUzq0WoZfulr9HWibSx5kJ6ta3w3/LbIW3
 IQlch4jt2oM7BJ4LXv2THB2jMP4uAxZNPtzu9VrEz+RE51WFucKgXN2xbkQmXPsKudTRGoyUS
 Kspdr55NW+OWaPyNLTELY2ik6QyV54FOo9Uw7bx6AAljVgelu35+sYEsRRaa4lS2J6D4TIRmU
 JzuHyWJqic24poEGvlsENzCfattsl6fxpxB1Ea5nQkWu+sTH1XeTQx+aOLgf9xGJXaiJAn1Bw
 tneSVH/u7HSN22z30CamSk5CFo3wQG3h8TiLccCxagE0kUy9LPoa2e4E0ZTwbtCtovlHS0HHA
 28yTiKIoRuTrfmUw5TZnOk+dYj63RuF3iRyIe+zVH2I5nEwLdw9Th07wjtplORmLdpd0701Nf
 jSM0ilSS0hyZ8ET28lXEQcZ52auNRgpbb6ZSsp/LWQjW5/u0+rOR0Ty4nickrmBpW9KYz4ye8
 DHG8oHvAJjnWvKK593YkPxNrHe+E68rYJ5tud/0/att9W+dDUIDnceeafkxNlo0LdZaX1xBgV
 JvtdJzq551POncXvnJLbfD2DG+NMwKtB9+B4o/R0UZinL3kZj/5dulwYJZYTmf/4OIPLJssqR
 MpQAyoj1XGZmmmn+AlcemRBtdot0bP8NZx3+NfKbNLEWHN31iMKlX/Py1
Subject: [cocci] [PATCH 3/3] lru_cache: Improve exception handling in
 lc_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 986
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ccdb761c-9ca1-fb59-467b-fb4d34adc65a%40web.de>

Date: Wed, 29 Mar 2023 15:20:39 +0200

The label =E2=80=9Cout_fail=E2=80=9D was used to jump to a kfree() call de=
spite of
the detail in the implementation of the function =E2=80=9Clc_create=E2=80=
=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

Thus use more appropriate labels instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/lru_cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 31820f03b146..fdc8bd6fc888 100644
=2D-- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -100,11 +100,11 @@ struct lru_cache *lc_create(const char *name, struct=
 kmem_cache *cache,

 	element =3D kcalloc(e_count, sizeof(*element), GFP_KERNEL);
 	if (!element)
-		goto out_fail;
+		goto free_slot;

 	lc =3D kzalloc(sizeof(*lc), GFP_KERNEL);
 	if (!lc)
-		goto out_fail;
+		goto free_element;

 	INIT_LIST_HEAD(&lc->in_use);
 	INIT_LIST_HEAD(&lc->lru);
@@ -142,8 +142,9 @@ struct lru_cache *lc_create(const char *name, struct k=
mem_cache *cache,
 		kmem_cache_free(cache, p - e_off);
 	}
 	kfree(lc);
-out_fail:
+free_element:
 	kfree(element);
+free_slot:
 	kfree(slot);
 	return NULL;
 }
=2D-
2.40.0

