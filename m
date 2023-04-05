Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF71C7619A
	for <cocci@archiver.kernel.org>; Wed,  5 Apr 2023 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=J7TTiQ3JBWIQ4OLhTpwSuFh2NrxJvdoU/+WrS8k/j2s=;
  b=j4gx1mSvckb3Hdez/t2DLtXkF/U4HAzsPYRRVKGXunD/xcgGHKqkLmD/
   NOZ/BjOxKWEYssQEig5osGT6bHyXmKL5KtcMdqla9mAyNQQLUzrTi6Nq5
   RLgNtKYzFtlQZZVkjqtG0jjbxrrFJcrsUOVJTFIR57SQvwsdpteoYFUvg
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
X-IronPort-AV: E=Sophos;i="5.98,321,1673910000"; 
   d="scan'208";a="100944822"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2023 19:11:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87D0AE03AC; Wed,  5 Apr 2023 19:11:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C0A2EE0157
	for <cocci@sympa.inria.fr>; Wed,  5 Apr 2023 19:11:32 +0200 (CEST)
IronPort-SDR: 642dabc2_Z1d5nKysj/KcessOPi4UP65VgDGPFPxEbDeqA3gITFlMplm
 M/b/jzp2zu54KTQUpfeFEzbCPf3dQyVdsBxwl0w==
X-IPAS-Result: =?us-ascii?q?A0E/AAD6qS1khwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORLwOEL4cuhz6EZ4QDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFTgnQChT0CHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB61pf?=
 =?us-ascii?q?zOBAYIIAQEGgmOZKB8sIlSBXgmBFC0BjQmEMCcPgVVEgTwMgzWEC4QUgmeCK?=
 =?us-ascii?q?4dSh1qIQgqBNHSBIA6BPYEEAgkCEWuBEAhmgXlAAg1kCw5vgUpjTIF7BAIZJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIQZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPL?=
 =?us-ascii?q?EQOQjc0EwZcASkLDhEDToFHBIELgQEGASYknVJsBwFSKBMUOCaCBJJYCQGSO?=
 =?us-ascii?q?4oYk3s0B4IqgVWBWQyfDQYTLpcJDgaSJAEuhzCQFCCnfoFqCyiBXDMaJIM2T?=
 =?us-ascii?q?wMZD44gDA0JhAOPCQE+PzQ9AgcBCgEBAwmFRgEBgyMCJgGCMAEB?=
IronPort-PHdr: A9a23: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
 TYphwE4bel/rV8EBn8oK1CMqCZiyCEM
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:azLCHq7uk9TfliLz7APXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,321,1673910000"; 
   d="scan'208";a="100944817"
X-MGA-submission: =?us-ascii?q?MDG5gCIohizxv+ceY3Jhydc2B/RiTRe8Qu6ivr?=
 =?us-ascii?q?QHj0HZIVXgDLAV43YmsccbN9xKt/0oKRjv9KjheklUnTPPyTC7Q0xRDk?=
 =?us-ascii?q?s/vKxTSc5iM4gvNSQxKpeovSBhIulk+Ch2URwoNUW0UVu5e4plt6BtkE?=
 =?us-ascii?q?H3VCUUmdgvdSDZ+T3GBUjNgg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 19:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680714688; i=markus.elfring@web.de;
	bh=9vk/wCzM3misVERGO6hb9HrWR0a3YXKHA6xQqnouWCQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=VzS1TIL/WhDb8xpluPu7UpNIsT0RMOlIjUx8kqX9UUhPTCsDHz9u0g5QTkBN7NaOI
	 g1nK3A1M/sBZSqcucr4qqR3bT0GCgAoEoIxqrNS7uySCrMQ/c6wAAfADRH4xMzndY4
	 7G+FzTXUkCwW3lNoateltb7rBAIcjabL9oDnP1XDS8z4WZ8rUHn6L2E/PQ78hfGAFM
	 CfyDOBU/62xI1jwSzB5wueJpqyORct32gF5f3uBIfLGURNnEbv6RFkXSI0Q1hlgata
	 XH4iyOK7bOn+DorpQ61e/5PL8JYZNFokM2um+bDD/Ww0Xj3eVN8RE8Ff84o+ZhokHM
	 Y1/9ONRBqgLBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1qILI72BUd-00b5xo; Wed, 05
 Apr 2023 19:11:28 +0200
Message-ID: <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
Date: Wed, 5 Apr 2023 19:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qFv9xlk5AIOZ4GNsZRuSxSI/E015NJ+DKcMIB1asBsWst+GZ9/L
 zvT37d2pqq0s34WFIYKlbjJYZgDSOae6KVPUa3i/3ehI6dj25z3znMmCZ7Cp69353WUbi/R
 jcopn7CZBTZZH5LnuliQ99wKse4OjXV3Oc64ZM61hwhGfUMVQCbNN49nRBVstujkxIbKFGh
 EWCOiezCC4SavgHuoqFEw==
UI-OutboundReport: notjunk:1;M01:P0:VmX8HXijx+Y=;VHIV+tkYWdhpKAkkcWaLtGbESN9
 wgVCqzAyXFvqL82/Sh4sdJ2p4B0cm+NOgNeYW3ggORbtxFdi3jv5LERZqjaPhYXbQEo4OCwIU
 0LPam2g0rYZ+WndjxaW7Yv/hAeMvAA5kpGR7JF99Sbxb3dWc4tFp1Eg3PDf4zUQcsszWEiBD1
 a/u306kfA5526uzP7cccpf2f8C8v62eRiiqqjNJB9++kpxw/0tEFPkZW+7abjySCKPrGrAl7n
 VCDRXz6QJMRN1F5HbaYsgFJqHQr20bBfzWwKdkatRf+xtsno+t+ByCVCgvN86YUUWmbZfQsPf
 SeAhKs8tPsnfpbWKtDpPjtbT9ocDo9DQfkpK91oNv1xaTJqCMtw5L5tNZlPqr/zYVFrzQe+N5
 Q1XFvmxhfLaVbz5AqGUynnRmBYG0BZWrNKY7Elp19l//J168Irjkd9w93M7d49jnHRzbBa9SL
 5SVi9x6hAtq3PoHh7q72aIqIIysuw40zxcqaOzNus+KwGtm/zE3Q5PdRxD9X64XmbCuBRmxDS
 1iBa3DFwDwogPt5N1bn41pqMHx4gwL8M+2YBuPgMhTJjPpwxp/lP8WdKPfkqJPxLJliUOH277
 qV7TV0oHUl5isBgfenh44AtCE2alcLg1w5rhkpMtTqjqiRLAzFc4lUWjaowqtqsDEPjTDAoU7
 lVytSrEjUO3gFJJ20xoeAfExW3dPAPuk5Rhqikb4AqLU7QZcBXugIGMg+CnyB3r0gTSZ2BM4Y
 FfWHX6uOkCRJ4arrjUlpMJGcxVsZKuC9hCHwQiWOfO7qYUrDSs8QGcG5WY7HjkJuJizUgURdm
 9omEA6tu4bhIhiNUPq/oHJqm2PPpxcW/QHero4UBaSYwSf0zcYPtOy523DFQcSGj/T7w5TQGC
 xVaGCe0kmm5Iqyn+JenMye3bwVKDsEo6ykyJQ42JO1Fa3CytCtw4X1DrE
Subject: [cocci] [PATCH] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1004
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/809905c6-73c0-75a6-1226-048d8cb8dfda%40web.de>

Date: Wed, 5 Apr 2023 18:38:54 +0200

The label =E2=80=9Cout_prevalid=E2=80=9D was used to jump to another point=
er check
despite of the detail in the implementation of the function
=E2=80=9Cnouveau_gem_ioctl_pushbuf=E2=80=9D that it was determined already=
 in one case
that the corresponding variable contained an error pointer
because of a failed call of the function =E2=80=9Cu_memcpya=E2=80=9D.

Thus use an additional label.

This issue was detected by using the Coccinelle software.

Fixes: 2be65641642ef423f82162c3a5f28c754d1637d2 ("drm/nouveau: fix relocat=
ions applying logic and a double-free")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouve=
au/nouveau_gem.c
index f77e44958037..d87e1cb2c933 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -814,7 +814,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 			reloc =3D u_memcpya(req->relocs, req->nr_relocs, sizeof(*reloc));
 			if (IS_ERR(reloc)) {
 				ret =3D PTR_ERR(reloc);
-				goto out_prevalid;
+				goto out_free_bo;
 			}

 			goto revalidate;
@@ -929,6 +929,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 out_prevalid:
 	if (!IS_ERR(reloc))
 		u_free(reloc);
+out_free_bo:
 	u_free(bo);
 	u_free(push);

=2D-
2.40.0

