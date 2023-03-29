Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB6C6FD18
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=by58TO1qgZPID7Vz2neAz3kOWIUEo/BV7EXC5J0YydQ=;
  b=SpQoF7r6cu5Ni8D3TmJZQ2FxF+yavS3+Xx2h9uajXUeBqP3iaTPjSVwr
   6Vm0P2sV/9Q3Kp3sNnddeBSWxikLX3h6hs7sj1w0/v24oCzC1zkvEAPX2
   OX2ozM7clAJ36H5QIwNuJdAZMfq4EyfBW+BRcxEl+FJ0nFZTQ7UXL7/m3
   k=;
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
   d="scan'208";a="99682617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 12:12:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 580E5E0B51; Wed, 29 Mar 2023 12:12:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 75A1DE0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 12:12:56 +0200 (CEST)
IronPort-SDR: 64240f12_LY4uHyob/0twB+MjXvPHbwcVRZeSbAHLiqzCd8anxiZA6MG
 tzT+FC+3O092zTMeKqV6ixK7pLQFBE0bHDrdJtQ==
X-IPAS-Result: =?us-ascii?q?A0EdAABrDiRkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4cskCOBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVOCcwKFOQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQeuD?=
 =?us-ascii?q?H8zgQGCCAEBBoJjmScfLCJTgV4JgRQtAY0EgxGBHycPgVVEgRUnDIM1iByCZ?=
 =?us-ascii?q?4Iph1WHBIhFCoE0c4EgDoE9gQQCCQIRa4ESCGuBfEACDWQLDnGBSgJkTIEhJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPL?=
 =?us-ascii?q?EQOQjc0EwZcASkLDhEDUIFHBIENfAoGASYknWlTKBNMgTBcHpJYkkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIiAZdqIKd6gWM6gVwzGiSDNk8DGQ+OIAsBDQmEA?=
 =?us-ascii?q?49IPzQ7AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 0xu4jY=
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:NHR/iKnz/uHgZNlgSXM9f67ppBDpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="51579864"
X-MGA-submission: =?us-ascii?q?MDGdpnTYcDQVYW8+vuCEQ8zDzJam8ExtXV5VGs?=
 =?us-ascii?q?wxDejEz4CENxJD0viI9MbZ9oakasxIWzDYVlBHglLCNig7izbJlIk5Qw?=
 =?us-ascii?q?Namo09HO2MfZBMkzFqVPRqQPRkt8lyJ2o2A7BEddZFTo3b4IyjexjWPi?=
 =?us-ascii?q?wp1XDo0O06KG/xVmpJCdbkuA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 12:12:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680084745; i=markus.elfring@web.de;
	bh=rdv2++pwVmV8PsZU8YmUr86+P+8uRupey0HMgVnvREI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=LtdqzrLU5OVMp5aL5pqpDk06TTxzxidNJ4E3IUc2Aks2ck77BSBulO34LqUB43q6p
	 O1EXchajN6kUOJQ8sYfKQVnz4zA85hlt102wdh0ddAcgFk8HjPNGeERW4yhwIaVMj6
	 HzstK7WJYu8+WUH7tK4aTosPNQzrz8DVq7BDJHSU5OZfhl1tqUeXpr5aScAadXDYNY
	 R/ZSQNvCpmE2Gk3hBozQH9QUjSxqVX+uxqGpbblRzDC0ZgefJRqefrmcYmRJY2UjfU
	 PKtUrlpiTvUi5l9TrQgTSl7huN0J193cCpOeXd13VxEABXBcPKy/rJGr3N/frtGOrB
	 gJMroRxVZnzvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZQS-1qCS2D0WDA-00mbBj; Wed, 29
 Mar 2023 12:12:25 +0200
Message-ID: <d33ebeca-0900-8c6c-ac44-f301daf24a5b@web.de>
Date: Wed, 29 Mar 2023 12:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-security-module@vger.kernel.org,
 apparmor@lists.ubuntu.com, James Morris <jmorris@namei.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aB8WA1zqeRwUG0BN/gpeOC9URczopY5grprdsnMedts4YndCDab
 Yh3MAzCmwsPqJee7Y4pmUd6HakYj1+aT0gM55naStOyK19N1sKUAnnQEJu41epLfeEvOEV1
 Xv2SSG1KceANI4M3SrnyrUQAdsuPqcttBwzjUnFjEewBT9Mqb+NfaSmnae9sS3/eHqeo22n
 0r6cj5OUYuJ3hPZI4AmPQ==
UI-OutboundReport: notjunk:1;M01:P0:/DmDku8rvbo=;qg6pbqbt+4VNqaOJ4tN196lbzuz
 by9bStmO8NG+E4lU0RQRW+yaWjlOdEOQc7dZFWJaC/qwunlPchMgq9N7YYNHBHPlP3t6lRPTl
 lcp1rYcxfHcVLzMmeuCYndMCB791ph3yYjJuiCSpFevSrMMS4qnMG3GsluuMgC2+EjtMzS/jn
 FpVwaxTb7geooPZiiWWuDEulgeF9BwNu/eC6ojIHOANy1BPFDF8hME0B0TcUfFWCVKhymAdBT
 uj8XxXC4Dn6KZkhfgo1f9tpVRyVXC56XNHXTv7gxlbhXzs9tmwZj9yzMtkPqiy4VqlAsJrJro
 KfH7etvUT7YwNIoTdVuVI2GEi2Zs1agCtTiDJrGPs+huJnao92nlfg0qHU4xYYI6FfWZSP0ER
 SOLv3ykyXNAC1uUEp+pBABoyR05eif+Z42tQAGGkPCKfrYaKpY2bEKB/RVkllknO4hKX5Cdhd
 dQe8HOylrpOl765AVfVh1CwHZAjzOSNUMV0bR0j38EfSo8wbohYKD3YzoLbJWFqfuD5uK5Gqg
 d3NXoV6u41Yqu12Xr8SugekxktrV0CSEZxiA7mYLLghW9jxaWj/73gvX/RnnNzthq4gYTKmFA
 8W+GARqId1MogK/biTH02ySB15roDFmEZUULrKdSIThxl8ExlOOu84J/rBVPF+JPY9mhU+BSs
 DKB9wWIzCV+ZX5c6+0SgfhW3lwZr84fHRD79GHupqdjGGtf6CurmKK6RT3WHAx8hfuqVZGcph
 iDXjYu0hFcCZMy8yjOpxxexVOhhuDW/XV+Jok3Cb/mGWCkMr+cvGijQyno7fZNw11V5BZZF68
 M0lwYkaUPmjPOHxT02lPvuVqkA40jRCmTZlrByeHB3t1nGTEzxJlsHdFYCSeE2fE+MHFXgtZ3
 L1OEA/cQ3kRQktyQlM+nobWiy6SGTI1gEtFiYKwzOlE/I0KuR5j861eFH
Subject: [cocci] [PATCH] apparmor: Return directly after a failed kzalloc()
 in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 982
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d33ebeca-0900-8c6c-ac44-f301daf24a5b%40web.de>

Date: Wed, 29 Mar 2023 11:50:44 +0200

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   at the beginning in these function implementations.

2. Omit extra initialisations (for a few local variables)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 security/apparmor/crypto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index b498ed302461..6724e2ff6da8 100644
=2D-- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -28,15 +28,15 @@ unsigned int aa_hash_size(void)
 char *aa_calc_hash(void *data, size_t len)
 {
 	SHASH_DESC_ON_STACK(desc, apparmor_tfm);
-	char *hash =3D NULL;
-	int error =3D -ENOMEM;
+	char *hash;
+	int error;

 	if (!apparmor_tfm)
 		return NULL;

 	hash =3D kzalloc(apparmor_hash_size, GFP_KERNEL);
 	if (!hash)
-		goto fail;
+		return ERR_PTR(-ENOMEM);

 	desc->tfm =3D apparmor_tfm;

@@ -62,7 +62,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32=
 version, void *start,
 			 size_t len)
 {
 	SHASH_DESC_ON_STACK(desc, apparmor_tfm);
-	int error =3D -ENOMEM;
+	int error;
 	__le32 le32_version =3D cpu_to_le32(version);

 	if (!aa_g_hash_policy)
@@ -73,7 +73,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32=
 version, void *start,

 	profile->hash =3D kzalloc(apparmor_hash_size, GFP_KERNEL);
 	if (!profile->hash)
-		goto fail;
+		return -ENOMEM;

 	desc->tfm =3D apparmor_tfm;

=2D-
2.40.0

