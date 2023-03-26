Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27262C6FD1C
	for <cocci@archiver.kernel.org>; Sun, 26 Mar 2023 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6HUMOF5VN+EA+/PMf0+5rP1DlWFPfhaHe19V6KQavpI=;
  b=WEeuLjB0ZCBCkReTb/SC3YYtf6zGkE/yYlJv31zIWXYydWHcJvVvsizT
   iLWfC9d52/7+jnthCZi9o9x7cuTPdKxFpnH+oBPoSU1mjjIF4lUrPznaH
   6hev1g0b4zcg4Q/tdA77PIqz5+ShoqJGHxYvvE8PiejonOWtLlpvpLabM
   c=;
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
X-IronPort-AV: E=Sophos;i="5.98,292,1673910000"; 
   d="scan'208";a="99115785"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2023 10:21:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35C20E0D42; Sun, 26 Mar 2023 10:21:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E95BBE0D40
	for <cocci@sympa.inria.fr>; Sun, 26 Mar 2023 10:21:09 +0200 (CEST)
IronPort-SDR: 64200075_rtYXAMt6CbhfN6nOMtaR6IebdkmLNmBm8IUJ2BWoyG515Zk
 zv/vhacNnsUbJ0yKpTYNxoqN1ZKxf22UAsuBToA==
X-IPAS-Result: =?us-ascii?q?A0GIAAADACBkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORAS4DhC+HLIwhhAKDFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChToCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrkB/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUng0GIHIJngiqOZ?=
 =?us-ascii?q?AGIQAqBNHOBIA6BPYEEAgkCEWuBEghrgW4PQAINZAsOb4FKAmRMgR4lBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CN?=
 =?us-ascii?q?zQTBlwBKQsOEQNQgUYEgQ2BAQYBJiSacQIBgmcBUjtMJoFmCxOSWBGSL54ON?=
 =?us-ascii?q?AeCKIFVgVkMnwwGEy6XCA4GkiIBLoctkA8gp3qBeSSBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMjwkBPj80OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 JTqo38SgmqLifYqKKaWKKcbljBt
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:/HT3BaGwPLMcGHP5pLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 eTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2+ks1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eAbmSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,292,1673910000"; 
   d="scan'208";a="99115779"
X-MGA-submission: =?us-ascii?q?MDE8rYLs41oNSJFIU6U/i9QjjjWs/XaVP7o2QX?=
 =?us-ascii?q?+I9Lcs0a8DtXvnQNFDQIgfWOiPH0bfSKdduEgkAzA5f2XDTBCUZ5q+9b?=
 =?us-ascii?q?IJlyf3gsnPnhfKT5R9Y/x5/0G++8NBlhMsDHs+uge98dTh/zaq2SmCDB?=
 =?us-ascii?q?YXmq+kpezbx4Dc0Ry8cGuF6Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:21:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679818851; i=markus.elfring@web.de;
	bh=Q5Ds2+pCdUtK3Bik+ZNKEEpMExM7V/oFwSRbspzR/d0=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
	b=IrE38SuNI/u/SIMvH3xOnAv4WQxeF8HR9QiPDtKFm1aEECmYpkferDY9qDGpiqnd5
	 zhJPF8Rk7LLEpGH3q4wSBr3OsH1Z2l7M1LF+zNW3U7abXMd5vEtHV+VZGl4LBZwz5D
	 jI8bkwHJ9YBsysuULNyCXvXa1uTWrlqfSl+yZlWF7xmpCtv1jgMXOEW2VUhYdqmLYk
	 M9i+OuD4RO6W92mRslgXFS9soYBo4c7fhbewURP8tPDVfkyC5K53eZAMxcc6qHJLJY
	 lKITr5q9hewFSddGw0wcdKa8nThzebPsbizHbtkdZUamodH7i9Sq2cDoxoC1U3x/Y8
	 SWobK6tmzVDSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1ptfP90liC-00Uxjt; Sun, 26
 Mar 2023 10:20:51 +0200
Message-ID: <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
Date: Sun, 26 Mar 2023 10:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
 =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
 Eric Paris <eparis@parisplace.org>, Michal Orzel
 <michalorzel.eng@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Language: en-GB
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHr6ujRiMFlRWglzpDBWpBF3uWqQRGtSLDRCr3V0yhu96l/BczM
 ueIx7yrsh8hDgMi++AAvAJmLR1hcy5URvStNO9wyvqxtPLQ0ch5xaHdk/HIEOSL0uZmYtx8
 JF+HpjUQU0Granf5Ow2HhxhNXvGEQP+6OxrcsasRtUoWjsyl+71J0rZ/0JBtna5QwQGXu9Z
 OTg5DnLzsQZPIdltb3RTQ==
UI-OutboundReport: notjunk:1;M01:P0:Fm08PBS9/RI=;PD3yqR+1gWERViNEdniU0Po97A/
 HZq7GU6xTHTDXkyNTvQdarBJNELNHr+hGz3NZC36yRSxPCEHg8Sa323FXZhFyDxt2CRk0cW5n
 QsroGdRUGkN317fiPB9FqPsEiuce+x2qIIawuCxIsc82DLv9qZjdduUSnlhUlyBbyBbRXpZc/
 f4fckIsqJZRKdywF1bXczlDFeEGJ5NBVfsSCsunSMOv7I+6tQ51h4TcPk1565SOLk02TzLk4w
 WkzZIzI8PXpkIbqJhnJnHw5v/3OTrp1LECl93KNewZ89tnTaSJIFaKDHxL79niSCnIX+Xl0/1
 wFgJ4Bd2ABgR9TbvXcPTKqEzoVgLLBaD0h4Lk8MuZE0uMI+vo05pglVT8EhSOuEQkuHKmYIeE
 7CZD4AB+J5Wh9H6SE7Iy5qSLhXeDKKqsPrtY5KTq12DZLNLjymLcktycthcad2McFcZjB1Ndn
 6Y8HqqgrGMvFdyOT/CCkTwzuGNpLy0+wmN/u/cVLV6C4UkXqLsgRJLlyOkh4FewwRUdO5FrEd
 uDdbBPsu7hOKmDvxEYqkfENAzCk9QzBkhz0FZuLHprg86qZlAT8u9Vjaevixke5S+IUwOIblz
 tdTX36U9QUp4Y4HKYZ6Cz06pvq/dKQ2zCeuyCr6AhkySzVo7JJ8z4oKrDUezPlpxgOSQa556H
 4MbxETVlwYLaXpZ4lHvv4UriwNdSlWOAUxNOq45DtEcljyvdzR7/99Sov0CD9UvAc5q/q3Qc0
 Di9oLTpG/Rmo0mrlKuUGN5/8BQ0LbEj6/jMnnKjXivAe3kYTQIETLk68g3NvYL2lm4EL/2MJe
 5sPw1sYfUWvqhsmcGb+QSuLnMxcjneqHfr7Z7Nf2ycrMeT817TiW5w8ZC9OXe6sVJHOL1B1FH
 2v+DVkxDQf5UUemcdonX+goqQZq1eoa1m38jbjESSo4Ocsp89fPDG6y82
Subject: [cocci] [PATCH] selinux: Improve exception handling in
 security_get_bools()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 960
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/83763b78-453d-de21-9b48-1c226afa13a0%40web.de>

Date: Sat, 25 Mar 2023 22:30:53 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Csecurity_get_boo=
ls=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

1. Thus use more appropriate labels instead.

2. Move the statement =E2=80=9Crc =3D -ENOMEM;=E2=80=9D into three if bran=
ches.

3. Reorder the assignment targets for two kcalloc() calls.

4. Reorder jump targets at the end.

5. Convert the statement =E2=80=9Crc =3D 0;=E2=80=9D into a variable initi=
alisation.

6. Delete an extra pointer check which became unnecessary
   with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 security/selinux/ss/services.c | 47 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services=
.c
index f14d1ffe54c5..534bf977e95a 100644
=2D-- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2966,50 +2966,49 @@ int security_get_bools(struct selinux_policy *poli=
cy,
 {
 	struct policydb *policydb;
 	u32 i;
-	int rc;
+	int rc =3D 0;

 	policydb =3D &policy->policydb;

 	*names =3D NULL;
 	*values =3D NULL;
-
-	rc =3D 0;
 	*len =3D policydb->p_bools.nprim;
 	if (!*len)
 		goto out;

-	rc =3D -ENOMEM;
-	*names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
-	if (!*names)
-		goto err;
-
-	rc =3D -ENOMEM;
 	*values =3D kcalloc(*len, sizeof(int), GFP_ATOMIC);
-	if (!*values)
-		goto err;
+	if (!*values) {
+		rc =3D -ENOMEM;
+		goto reset_len;
+	}
+
+	*names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
+	if (!*names) {
+		rc =3D -ENOMEM;
+		goto free_values;
+	}

 	for (i =3D 0; i < *len; i++) {
 		(*values)[i] =3D policydb->bool_val_to_struct[i]->state;
-
-		rc =3D -ENOMEM;
 		(*names)[i] =3D kstrdup(sym_name(policydb, SYM_BOOLS, i),
 				      GFP_ATOMIC);
-		if (!(*names)[i])
-			goto err;
+		if (!(*names)[i]) {
+			rc =3D -ENOMEM;
+			goto free_names;
+		}
 	}
-	rc =3D 0;
 out:
 	return rc;
-err:
-	if (*names) {
-		for (i =3D 0; i < *len; i++)
-			kfree((*names)[i]);
-		kfree(*names);
-	}
-	kfree(*values);
-	*len =3D 0;
+free_names:
+	for (i =3D 0; i < *len; i++)
+		kfree((*names)[i]);
+	kfree(*names);
 	*names =3D NULL;
+free_values:
+	kfree(*values);
 	*values =3D NULL;
+reset_len:
+	*len =3D 0;
 	goto out;
 }

=2D-
2.40.0

