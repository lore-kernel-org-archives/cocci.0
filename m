Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25097C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j7oKOR9ZnQXhH8okTLFBH2rNKq5NbHxIWKsa/SGSYoU=;
  b=mqwWMLbJCMN+xPgOxfXXHP/IH7tcEqHy8vNdh2a9AXoyVO1g/tzZcOrN
   hSBbx9AC6ZCLz+xsjdajyXG7f86zdkGTBRHcBliZTOMXuyvTmcKVJ1yHM
   Kzlv9elMQATDUh3dF3YyJbcnZ7AqDYVyz+3/hRrdNf+gm7EbTN7+yzNR8
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99064298"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 14:42:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 84816E0D44; Sat, 25 Mar 2023 14:42:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CE082E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 14:42:42 +0100 (CET)
IronPort-SDR: 641efa51_wrUJw719LWg685kk78Wmj2oWMiFHfcfYXjYFE24IiI/7qee
 Emx19zAQumLwoi5J/Ocwvy+JSKrpEyBI27Tkmeg==
X-IPAS-Result: =?us-ascii?q?A0H3AACh+B5khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGBIRPiB+IYi4DaYNGk02FWIFAMA4PAQMBDS4LCAECB?=
 =?us-ascii?q?AEBAwQ4gVOBYIETAk8JhGICHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEAQECEAEBARoJFwcOEAUihWgNCAEOEIIQKQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAg06GDsMBC0CAQMBIgQZAQERJgEPHwYCHwcCA?=
 =?us-ascii?q?igvBgEMBgIBAYJ6AYInAQMxBwwGsCl6fzOBAYIIAQEGgUABmkkfLCJTgV4DB?=
 =?us-ascii?q?oEULQGNBIM2eicPgVVEgTyCU26CSxcDAoEkhBGCZ4l+hyWILwqBNHWBIA6BP?=
 =?us-ascii?q?YEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEwjeyUEDgMZKx1AAgELOzo/NQYDC?=
 =?us-ascii?q?yAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpCw4RA1CBR?=
 =?us-ascii?q?wSBCoEBBgEmJJpxAQEBAYFzbAYBexMqAkYKUIEqwyY0B4IogVWBWQyKDI0Wh?=
 =?us-ascii?q?2oGEy6DfZMLDgaSIy6HLZAPIIIuiRWBb5UmhSKBYzqBXDMaJFwQgkoSPQMZD?=
 =?us-ascii?q?44gGR6DboRhiigBPUA0AgEBNwIHAQoBAQMJhUYBAYMiglkBAQ?=
IronPort-PHdr: A9a23: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
 UE2bF8spppUiKZ8M39mgknQtMkXccM=
IronPort-Data: A9a23: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
 e0jx0A=
IronPort-HdrOrdr: A9a23:C7osEK9Q4VqMZYppkhtuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51232185"
X-MGA-submission: =?us-ascii?q?MDGWjeR4VsUiG+8q/8jURXV/oebG2K2/RZAYhT?=
 =?us-ascii?q?o6CHcCUm1oyZQ8eshbbKL1Mm0PKE+ggZjpN9QmnO8MGn3wCcK039C39H?=
 =?us-ascii?q?3z1rh9dvki2RNat+25jchqleRDX+6NOnGse+v4r167ielRKmEiL5t6mr?=
 =?us-ascii?q?D6BICOOT6DWADVdGK8PdyX7w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 14:42:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679751755; i=markus.elfring@web.de;
	bh=KO3BKZVVw6mbo81Zr5Lz6Z01ExV290PntqJFfRRjrKU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=F+3KSBJYMSP5pb4y/6UgRtIeNH5oU5uU89AJtNbxlZvBYPFTgMh9MIucGfXrWy4gh
	 ISqTOWmtKiBccT5RqtjhosnUuFdrQlC6qPgQM3uNsPLNzYgtLnApk7h2uO/2Y91uke
	 R6NdLenHGCHVHkCrkSG5E2/GBp2UJ2NiNDKktJgqaUKb4uElmQrIpiCpJCcDntHv/h
	 PM/GcNRbxEd4SeuklaF2ZeIS+H04oXU1xT3NUjwHddnjkffFHTnrWvPYpPRNfd1FpZ
	 a6pNMVg3oZhUzazokWy9m8faPfw1MAUCab4aZmUnlhSHjyhKfTAsvP3ztIYGBAund3
	 K5xFlXxLilYkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1q7PEd2jSm-00h3HU; Sat, 25
 Mar 2023 14:42:35 +0100
Message-ID: <f5ac19db-c7d5-9a94-aa37-9bb448fe665f@web.de>
Date: Sat, 25 Mar 2023 14:42:34 +0100
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
X-Provags-ID: V03:K1:RfdaZlFOSV3M64SKFPUXdwaCJTA7xUu4N6/KaHtpNrcYpQ2mw1y
 ePwYGxPOYKd4LLfoQcjSJppIa2nvji/228ZpC2qOmUJFp2LtM8GkopMUPRggW5tJq6M3uYT
 1JbDjxgYSWVncu3ciDR6U96LOafJvToRGG8e26OFOEKpHxNMzD8vtCNToKHDiMkAWnRpXSN
 DWRuqpQno3pgFXBCi/aww==
UI-OutboundReport: notjunk:1;M01:P0:euUHpvkGFEs=;yVylM0wy3kOod/nSXvMQmTXuEV4
 inKf53S6H+hxB+Gk3HT/DYa7hHeyKRvf30mnJX8iz/w4JCHlD0dVPZMtfSkz322fHhRRc7niU
 x3jFXG6q9ocHgp64EPZ1QGkjyuLA169TDP6Ih+z5a/QaQ54ncYwlLOp3I0JdFx5Us7PMLB9Bx
 5rWkbPZUlOcptjNgMGEXkJAu+PxI7JG619D9UzTqHIT27GWQKzBgh/zk6NkGa2RSd8URbHFgw
 IGj9TpatrH2CJoY5wHIFZLy9+PfJuYVelhvgB6N2u4oBmoekXiMKQfxsfUy93fpin7nZJheGo
 3ZS4q/kuurX4FSuSK+RoHv2rD+UwZX2H6YiBKfEyN4Cj3DisU4rhhAsu1/Y0f75fyFHjxpdcq
 hkb1zUDnpUUW/A+bQkKo36GHQGLI+Hr8gZFtWBMaLtaAIQ1PrRBgPRI6WU2ZvIyeeOWvBak6V
 XJxnlXsOW/8Hx2OtlicmHmOFXEtLCW7OHRRMxZu/dOnFbxJ688VatBTyXqoKu7Sf1zfmTCg7W
 lL79T7aYfwegoZW1J62GNUDe/RauWPohNCa4Fhxdmt9smUJ55/r8bm1jHH6enfEp8vVafZ0Kf
 nr9EfL888lMCOqBcQuMtJB6mvd3CelAiCIpeePdY6vv4FMzhdDeXCHDfRytACilNXraDqp6O6
 Ab4i8w8rMBQQXYIaScxK0u1wa7z/VZoeswLlxSLxJdNWPsdFMLQD9dXxua6Uo2WMAwC98+HtO
 14UX8gQnuosefZV3elSFrFUxrb03vxSFh4HNODX6hKhp7yyDrKnnIdKv/qgbRc7gxbtqLe7pt
 KwrnsqRNyt7L0wBcWzXbtAgRWgkvO1LJmjBQR4jv2jPK1BjUhVF9bKcpjGJida0PTSJ6EHpay
 0ba4wsPDhZ97cPG5hCZEo898B0Z1l5uQHjuOfLhWZyXBQoKc04N0cjRnc
Subject: [cocci] [PATCH resent v2 1/2] powerpc/pseries: Do not pass an error
 pointer to of_node_put() in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 944
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/f5ac19db-c7d5-9a94-aa37-9bb448fe665f%40web.de>

Date: Tue, 21 Mar 2023 10:30:23 +0100

It can be determined in the implementation of the function
=E2=80=9CpSeries_reconfig_add_node=E2=80=9D that an error code would occas=
ionally
be provided by a call of a function like pseries_of_derive_parent().
This error indication was passed to an of_node_put() call according to
an attempt for exception handling so far.

Thus fix the risk for undesirable software behaviour by using
an additional label for this error case.

Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2023-March/256025.ht=
ml
Link: https://lore.kernel.org/lkml/87pm9377qt.fsf@linux.ibm.com/
Reported-by: Nathan Lynch <nathanl@linux.ibm.com>
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
V2:
This update step was added according to another change request.

 arch/powerpc/platforms/pseries/reconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/plat=
forms/pseries/reconfig.c
index 599bd2c78514..44f8ebc2ec0d 100644
=2D-- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -40,7 +40,7 @@ static int pSeries_reconfig_add_node(const char *path, s=
truct property *proplist
 	np->parent =3D pseries_of_derive_parent(path);
 	if (IS_ERR(np->parent)) {
 		err =3D PTR_ERR(np->parent);
-		goto out_err;
+		goto free_name;
 	}

 	err =3D of_attach_node(np);
@@ -56,6 +56,7 @@ static int pSeries_reconfig_add_node(const char *path, s=
truct property *proplist
 out_err:
 	if (np) {
 		of_node_put(np->parent);
+free_name:
 		kfree(np->full_name);
 		kfree(np);
 	}
=2D-
2.40.0

