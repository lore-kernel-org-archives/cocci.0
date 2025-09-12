Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EA7CA101F
	for <cocci@archiver.kernel.org>; Fri, 12 Sep 2025 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PvvLMdirDEwLLyd8cvNyfkHbGV5hw5trPliTc3X8k30=;
  b=gU6qjA/rEOsexlt2ia/eDRKmxIVIAH+EFIB0KmMdytSr3vUlmsa1//Qk
   cwZti9d6JT8L+MfG0smMtpw+dm0uhXS0G4H6UYbxkmFncMy+sRKpmNjyq
   e3CFLVo3NQA2pElO13hEj17Y6+CEuHiIfjif++R8yqTIltmSD7k1BBqyr
   8=;
X-CSE-ConnectionGUID: m+7+ZMGLQOaF/fUdzTlP7Q==
X-CSE-MsgGUID: tor2av0bRtKyrmbAqH/xOQ==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238762223"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Sep 2025 11:29:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86FC4E0172; Fri, 12 Sep 2025 11:29:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01943E0171
	for <cocci@sympa.inria.fr>; Fri, 12 Sep 2025 11:29:06 +0200 (CEST)
X-CSE-ConnectionGUID: +dmb7YPlRYq5Cl2Rb8u8Cw==
X-CSE-MsgGUID: xxIHOSAXT12mvbp3yJ6dRA==
IronPort-SDR: 68c3e7e2_dW0yIxGvTRMETU6NU9ZmJjzgtysJ2vNGJlszJ+PhZg8kG7H
 LEmiVhiBdrUYvZvImVniX8arl1cONvKUHvmTfzQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQAABD58Nog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQIGVDMEC0kIhE2IHIc0giSEO5gKgVWBfQIPAQMBD?=
 =?us-ascii?q?UQKAQIEAQEDBIIMgnQCjDACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAg06RAEBAQIBIwQZAQERJwQLCxoCJgICVgYBFAEBgn4BgiIBBhABA?=
 =?us-ascii?q?w8mBw0GsXd/M4EBggwBAQbaXx8sIlmBZAMGgRsuAYVrgmQBhieEPCcPgVVEg?=
 =?us-ascii?q?RUnglIxPoJhBIFeg1uCaYImgRaDWIgjhDaLVlJ4HANZLAFVExcLBwWBIEMDK?=
 =?us-ascii?q?jQxI0sFLR2BJ3mDB4ENhB4rT4IccoF0PhlBg1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?WsiBh8SAgMBAgI6VxCBfAICBH9AAgELbT03CQsbBj2WCYJDboE5gkgysR2UY?=
 =?us-ascii?q?zQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBiKNZpVzhUaBaDqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYNnM7k+QTUCATkCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:ISTKJ6E+nYrE1R1ipLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:z/xAn25kSe64e90vcNsst0IREJ8USnnn/W6NCEviM2w5Ve2+VgrF
X-Talos-MUID: 9a23:9LFJRgh61MGIAQv50ZRIIcMpJNdJw4OVIXAxyM8DpcOcbj1SZTunpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="125328663"
X-MGA-submission: =?us-ascii?q?MDFZhCXSnJkNq6/I8w9gdfx0bY9IizJoWP23vN?=
 =?us-ascii?q?we+uNP1Mcukl9z7UXb1ZbBjq30JG831762xE03f74WaOn8AptF0C4/lL?=
 =?us-ascii?q?GaISOkt+P0q0S1M4Qg6d561S++/ftAegX33nYdIKNdj+sNH1q1/hXEZW?=
 =?us-ascii?q?ESg4ObN8Jl0qpmsp9iMdGHcg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:29:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757669345; x=1758274145; i=markus.elfring@web.de;
	bh=PvvLMdirDEwLLyd8cvNyfkHbGV5hw5trPliTc3X8k30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LghsRHmu2t/5stHTQfFlyrKrPMefvrQ8XgM1UkEiUziaxgTvwoRYfWC3k99RCEAl
	 75a/FXv9nQoVQ83/+fVjSbJQsqDxty2QiaPYKaGXXz4NkS4Z+2nnzjPWfmMDViccr
	 prWYZ4mewCrGo8IZ9b0O9bWdRdLfBq0VYOTRUfbr8Se5EyFY+KjCjwlq+G/PiqBiP
	 ek4PCLo+NzkQR1jUT9Rv3dcMSSWleaPZnJDexBQF5jPoYkRApHyF6U2Infon4vL28
	 tiOsSdhD66Ird70pXIZzjp+8QixBA57cce0hjEb4d6ZsHu6z0tIy3g9SyXQ15rXiD
	 +WMixrPFP0vlatyo4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALiL-1v795v3kdP-00CSn6; Fri, 12
 Sep 2025 11:29:04 +0200
Message-ID: <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
Date: Fri, 12 Sep 2025 11:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GvNvhAJujMLEhKj7tQPYxN3qIUEFlbr9F2VorWunjbfq0FyB5R4
 4Vyql+lFTAweLB9j3y6lOZo9UsdxOQj11GPPHREzKsUqGVmcaSeJlHFBwAZMK3bEP/LDeB1
 b4G1mhMKJXVyMvIR/750Ym/xckZrgH/+OAn2wFsMY55GOAEK9QgM990ExpJQ1sPLbIuKWcJ
 iHsfLJjCSrSxCInPaaQ0A==
UI-OutboundReport: notjunk:1;M01:P0:Llm1X20KOp4=;hh8pOdwJdLxDh6HhrG7tlZktFz7
 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
 BO7y4zQHjtTYrDj1S8o
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3013
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/504107f9-09eb-47fe-96ea-53e375b17eac%40web.de>

> But if there are cases where dn really should be freed, that could be
> something to write a patch for.

I would like to clarify possible software development consequences
also according to a diff output like the following.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_missing_of_node_put.coc=
ci arch/powerpc/sysdev/fsl_rio.c
=E2=80=A6
@@ -511,7 +511,6 @@ static int fsl_rio_setup(struct platform
        }
=20
        /*set up doobell node*/
-       np =3D of_find_compatible_node(NULL, NULL, "fsl,srio-dbell-unit");
        if (!np) {
                dev_err(&dev->dev, "No fsl,srio-dbell-unit node\n");
                rc =3D -ENODEV;
@@ -537,7 +536,6 @@ static int fsl_rio_setup(struct platform
                                (u32)range_start);
=20
        /*set up port write node*/
-       np =3D of_find_compatible_node(NULL, NULL, "fsl,srio-port-write-un=
it");
        if (!np) {
                dev_err(&dev->dev, "No fsl,srio-port-write-unit node\n");
                rc =3D -ENODEV;

real    0m0,968s
user    0m0,547s
sys     0m0,059s


I would expect that the previously mentioned SmPL code =E2=80=9C... when !=
=3D dn=E2=80=9D
should exclude some C source code.
How does the shown test result fit to this expectation on the behaviour
of the Coccinelle software (when there are obviously places where the foun=
d variable
is used again after a null pointer check)?


But it seems that the code is still improvable.
https://elixir.bootlin.com/linux/v6.17-rc5/source/arch/powerpc/sysdev/fsl_=
rio.c#L439-L731

I guess that of_node_put() should be called before the affected variable
is reassigned here.
https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/of/base.c#L1011-=
L1022

I would appreciate your advice.

Regards,
Markus
