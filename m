Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A7C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HD17gEkoH6IyDA3t+Z0tG4/daP4Lgwc5sRDP2vkdA34=;
  b=OFhv8j1WyY6iCeg4ccVpyzxLPeF4QOao/gVYUHEfTvdZ2aZSULFgcVRD
   gjIb7324w4zVeZ8Ppgi/wS0GJrpKrRUDXSnodjNvN3h2eyh3d5zmkH0gK
   /DIlmMgDCUPDvhajDIBUEbLs1E57yvRSU3O6/V1BiAKwDtsabiaLNeMtp
   M=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99064390"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 14:44:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C02C2E0D44; Sat, 25 Mar 2023 14:44:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F4A1E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 14:44:33 +0100 (CET)
IronPort-SDR: 641efac1_zpBmNGYGiDE8irNEBezarfhZHe8rRBu/CcCuyIvyv3yVEkb
 w9Pe1hR5o/aNMSeOq5PqG0QQzZQ3nwo3D1RF/JA==
X-IPAS-Result: =?us-ascii?q?A0GkAAAV+R5khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORAS4DhC+HLIwhhAKBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVOCcwKFOgIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBAQIQAQEBGgkXBw4QBSKFaA0Igi8pARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHs?=
 =?us-ascii?q?TV/M4EBgggBAQacCh8sIlOBXgmBFC0BjQSDNnonD4FVRIE8g0GIHIJngiiHV?=
 =?us-ascii?q?ocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CN?=
 =?us-ascii?q?zQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmYBAVI7TCaCBJJYEZIvng40B?=
 =?us-ascii?q?4IogVWBWQyfDAYTLoN9kwsOBpIjLoctkA8ggi6lTIFlATeBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR6Dbo8JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 RM8zAdzM7xFyQ==
IronPort-Data: A9a23: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
 OzyIkHNAyU=
IronPort-HdrOrdr: A9a23:MwDr5q6EEQ6juWbwBQPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99064389"
X-MGA-submission: =?us-ascii?q?MDHP4oBicPR7xjwVOa06NlCWjEnBuhVn40r2uv?=
 =?us-ascii?q?Rt5NYjMcrNl11rTGkSSKYZaLpbeQDsV+zGYGcvTJNfURmApxq5MtCKgm?=
 =?us-ascii?q?u84Fv6/Lwo+lWPJjvvqSP404Ad1En5JIHOJ1dgFzbVqQ2MW5XCHxnbUO?=
 =?us-ascii?q?+JLCFzc7cwPEnOKfe/4pT5HA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 14:44:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679751868; i=markus.elfring@web.de;
	bh=9MEMV3HONXkOFdWmD1JKhyX20q5i9cTWfln64sH0OnM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=cT3A7uc5KNtpT3Ndr0DpZhZmxgz02TyJ68nuD1VYOzF5hqehYYxGDIOW12+Raea2D
	 zyAxGfFTwaW1P8Xva8QvXJE77EaLnjEd8ARJaYX4kU2sFjaW9UNxvUTAoeYjytLvjp
	 ecftofcOSlhZiFWYj37ngPIbOFrL7wdb7MwYUfoidFu2dayG+aVeb5iN+Kioh7CmxU
	 Xp9fBuOPFnlM0SGJN4ExMRtbcjTntXLRycTRgbFMB25Ib/y4zGx9eHyYDMkQnbjirK
	 TqkkjmYnxBr9mtstzwH33bCqRKREeLmkM0lMwjq0ZGvuB3FN/G6AdV/hclZrJjac/l
	 KMuQIdTWHo8KQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1qAQvf246V-00eYGf; Sat, 25
 Mar 2023 14:44:28 +0100
Message-ID: <b54f8f9b-f279-c353-f68a-763e2ac3705c@web.de>
Date: Sat, 25 Mar 2023 14:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <08ddf274-b9a3-a702-dd1b-2c11b316ac5f@web.de>
In-Reply-To: <08ddf274-b9a3-a702-dd1b-2c11b316ac5f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JoEdPDWmvgdeSdF982ek9rSr9udo+HdUu5DiQjjaQjTjG+v4jf/
 eyv2L9JJ+4HRvl5WUJmKLUzQsYQri5K+5uWHa/LTB8X417ZMtSh/kQvFTMOYLhcgwyU6MQm
 ow9BgWmLEmhs/TuY9ZWlc0Vafzd4B9zRALz9Y2rAqKwrbB6wEwCpoIX8Fcs2KUlgJaZUSrr
 NwCHGzZ17BoLOYvT0aUIg==
UI-OutboundReport: notjunk:1;M01:P0:PXV7EA2zsIc=;S7bNfX5q2cCpl7RnOrCc42eGJs9
 b50zOCwALGHAJKTbK2cFrj/O4Jp0gKlBHfjWIuIZ5ZezUA7ynYY2Y3zFnBrZMpiVcVghjbaWD
 Sf+NAF/nmPwUA+CAzxKQDbZIsW39FhZTpnmL0XDtHuX8g3W22QBl/fO0qfCQa97DkjawxiudM
 Q/KklQZMsgip6ZGy2wraEKJY7IS3QaEObijmB8fdwEILC5gZAMNWODX2f+KCKU+MdlKvNlsk3
 cwXMHF5/6o+/CgdrSERbsd79Y85LLkp+C+wce0j/j5xqC9DrXo7giOP0bG5zGhfZnZ0XMbglW
 /36VD2E0rN+COGJYBxuu6kRe+YXuRW32GDNTPNNBd1EJE3M01YeetF4BGAl1MP9scebcrl4T6
 9xaqvsSvGZPKx+RVm1aKBC0NME/yARSLsoNkWuXrPN9qpgMo0SSGv6mHszd7V1OvtM3dKfZUN
 3gwd5QtP08n/LdLM/65XQigNhQpZvFJgoQ+/SOFyb524vPSRaWiokJYFhTMADgq8BCrO2gyj2
 7z2WNp9EC/ckWcVaZfMDw1i/M8ZB4/H1xyQGghL79RJK1wokOt5O02Y25AXhRI2rgh8LVlkFe
 4G+o3K+A3gICmzqsyyQaFCsV0awQNdv6TcAwOMYkwtqNl875rv3dEqx5imTPg9lwv43Y5+4WT
 kM2dR07eRo3t20Wd0FvVQvcujB456sRVWj42XlMJU4d+8nZ/Thh9JymqgSxUIkEwFi8hufigK
 nplv/fhR7C2d+2y0jCLhXDeiGvg+Ldop5qgjgunaYCKyxgsruEYY9skXyFkaw08x9D/E/+urP
 z6i863Uu3JmrcZKlDMWw0VyUCPZr0ob5Cbva0YgjzgbiwU4IAq4KkjtBmKdFwMo/HVk4tA1r7
 P5iKVI5aO2RQtn9TibzgauzLpWz0kJ1ZAXoBFZq8g1BDAdJ2550s9570t
Subject: [cocci] [PATCH resent v2 2/2] powerpc/pseries: Fix exception
 handling in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 945
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/b54f8f9b-f279-c353-f68a-763e2ac3705c%40web.de>

Date: Tue, 21 Mar 2023 10:50:08 +0100

The label =E2=80=9Cout_err=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9CpSeries_reconfig=
_add_node=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call in two cases).

1. Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=
=80=9D failed.

2. Use more appropriate labels instead.

3. Delete a redundant check.

4. Omit an explicit initialisation for the local variable =E2=80=9Cerr=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
V2:
This update step was based on a previous change.

 arch/powerpc/platforms/pseries/reconfig.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/plat=
forms/pseries/reconfig.c
index 44f8ebc2ec0d..14154f48ef63 100644
=2D-- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -23,15 +23,17 @@
 static int pSeries_reconfig_add_node(const char *path, struct property *p=
roplist)
 {
 	struct device_node *np;
-	int err =3D -ENOMEM;
+	int err;

 	np =3D kzalloc(sizeof(*np), GFP_KERNEL);
 	if (!np)
-		goto out_err;
+		return -ENOMEM;

 	np->full_name =3D kstrdup(kbasename(path), GFP_KERNEL);
-	if (!np->full_name)
-		goto out_err;
+	if (!np->full_name) {
+		err =3D -ENOMEM;
+		goto free_device_node;
+	}

 	np->properties =3D proplist;
 	of_node_set_flag(np, OF_DYNAMIC);
@@ -46,20 +48,19 @@ static int pSeries_reconfig_add_node(const char *path,=
 struct property *proplist
 	err =3D of_attach_node(np);
 	if (err) {
 		printk(KERN_ERR "Failed to add device node %s\n", path);
-		goto out_err;
+		goto put_node;
 	}

 	of_node_put(np->parent);

 	return 0;

-out_err:
-	if (np) {
-		of_node_put(np->parent);
+put_node:
+	of_node_put(np->parent);
 free_name:
-		kfree(np->full_name);
-		kfree(np);
-	}
+	kfree(np->full_name);
+free_device_node:
+	kfree(np);
 	return err;
 }

=2D-
2.40.0

