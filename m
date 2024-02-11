Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45238C4829A
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VetbotXyJA2Jkg0uhXHPgOO2ERw+fgs9SWBuCZkDOQU=;
  b=Hhrplmacr8PzWWnm9e/KJ1CJ5HdA+7pa7h0a7Di9Pv0eB1Km4FE+Psnc
   zhUeVYWyqWqCXd+lz+zGqV75SRLzj0R+2PsgGohOUMhCxWdBjlQE50i3b
   oVY0umPyvO3Md9YXPt6RKtRySb2DNNTIFPw5XkkFvHWAtkRBZ5bai6IbE
   w=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="151347317"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 09:24:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09D38E0CD5; Sun, 11 Feb 2024 09:24:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 17CDEE008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 09:24:49 +0100 (CET)
IronPort-SDR: 65c88450_OeWlpO/dDmkMqQsq5UMDNOb/bHRAXF6fvzzOsjwfcmbLhsD
 1XzMuwRx9GpGPeWXIqi557XUErTi8eFIaFYeRzg==
X-IPAS-Result: =?us-ascii?q?A0EXAwB+g8hlhwQP49RagQmBT4I5gVIyBAtIhFOPRIF1L?=
 =?us-ascii?q?YQ+hzeSFIFAPg8BAwENQQECBAEBAwSCC4J0AodXAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJVGIEOgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjHQEBEScPCxoCJgICVhsBAYJ8gisBA?=
 =?us-ascii?q?zEHsi+BMoEBggoBAQaCZqx0HywiVoFhCYEaLogmAYUkhQYnD4FVRIE8glIxP?=
 =?us-ascii?q?oQKOU2DDoJohVSYX1SBAh0DgQUEWg0bEB43ERATDQMIbh0CESI6AwUDBDIKE?=
 =?us-ascii?q?gwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEHK?=
 =?us-ascii?q?VVBDFADZB8yCTwLBAwaAhsbDSQjAiw+AxEQAhYDHRYENBEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGXQkaBw8JBCUDCAQDKykDITNBEQMECgMTBwsHeIIJgT0EE0QDEIE0QoR8h?=
 =?us-ascii?q?G8DGSsdQAIBC209NQkLGwYiAR0CoGd6L4JYL8RuNAeCNIFggWEMnzgGEy+XL?=
 =?us-ascii?q?g4Gkl6YV6h3gWM6gVwzGiSDNk8DGQ+OOYQUj0dCNTsCBwEKAQEDCYVGAQGDJ?=
 =?us-ascii?q?jSBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XpQIJKP3f0q3qcBcTh+jsMiBIKoaSvp037BZ7TEUdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwIk80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3As1oKU2oJzxcs3bkTAaHiynbmUfEddjri3lPOGHS?=
 =?us-ascii?q?bMkpycoSbVnLL8qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AWy7BVw5J+SR95+ewYjPvbIhqxoxE566lJE8Ivq4?=
 =?us-ascii?q?oqs2dCzN5HhDegQ64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,260,1701126000"; 
   d="scan'208";a="79305931"
X-MGA-submission: =?us-ascii?q?MDE9RHukPSnwgRELfnW+uFacHq0U27DEYfw4GV?=
 =?us-ascii?q?8ikJIYWjUjOv2ajmmXZGnaDtEIw1P3krQ5DRtxxo2pInKPXFhN8rjmTq?=
 =?us-ascii?q?SmrgRLGyURh6Y3nnwMi+OA5tZlSISJg71ECeoyGlqxx3nqfQzv0vf1ul?=
 =?us-ascii?q?O1hGBw6Dbhxixf9cdWLgw+FA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 09:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707639887; x=1708244687; i=markus.elfring@web.de;
	bh=z6Dy5cLZPY8OG6GLYmf/7Vxb+3pKenBMtauhKHLx6Nk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=hhY17yk5tJYy1qpSb5bfl1X5aBAbKbjZYnsuxhlabVdRiP2h/tFh6fRx9POrQBz/
	 2HAocX0zkeMMcnDYgAYxT9Jb0Upmm44SSqnOtNxqkj7BRMOxPSWUWjjEONI2H7r5i
	 jpZ/HtwUsbraRZCJXrfsG6gYHi28ZxgMr1k2uQ/mGZx/+JDSLygIhMtCCkUhp3Suj
	 ie1b1erw4n1uhO1EKCv6fvWkqhrAijPAbYe/D8TIMslyxBLcLCBCwB2lj/v23XeHh
	 iWxqQ+iufEQtGLx3aKAomaM84mkt9u/hTsE3JBZkmDB1bcWKy0+n1SRkWNEwFB4tL
	 l5zji18THzYTnRdxOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1rhuqV1tgW-008rUA for
 <cocci@inria.fr>; Sun, 11 Feb 2024 09:24:47 +0100
Message-ID: <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
Date: Sun, 11 Feb 2024 09:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
Content-Language: en-GB
In-Reply-To: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t03vHa08yLRzjQS0g9DbRuyCNDJLwhD6OA8f+pntv630xxXAaLe
 THwymmWggKabtdcwZSsP6pfwjAKj97UWYM0HxAiqVHwVY+NBIsYu55Czu79bfw1XbpmpTzz
 5ROhZweOTAvj6VOVfv3ThK7Oc/3wF7g46Xyji4+j0U3elC5SUSFrK+6bPXCLvu0TQ5cz4gV
 5ISH8sYl+9cKbrztnntSw==
UI-OutboundReport: notjunk:1;M01:P0:GhG3HevFnns=;xMwdt7VggrEKydt3p4FlSg2vZJf
 AEasW6bb6c6EXE9Ks4hzuvs1BahmPoQSnFq8ldBNJ0zdCU91saAYZeBYVAwaoCmOz8IInoxYF
 CUxgKhoNqJpGBBsx57ZwsXK4/Fju733nZ7MfT8oAvDOz1V/NMBM2TTPkBtD3nsMPCL41kiU7E
 0GPndNMw/jD0VDqgGTq4WHlDnY3Ol//VOCqf0lOdbep5Y7sMseSDcghHdbqGx0qJvJ38Sv6aK
 hqHDMGw+ManKHcDQg51Ji+XhetArJ7KDd0dZuHixjSuTTMePpc3NipeCCjvoKnp2QyNfFzhU+
 G8SuEtPKEs4mu0Ycxs/PfVAlhQa0+Ab+cTFIg/yPnT8mSRuUtfROkTxpN0MYoSwa1rz9NAcdf
 CXQwUDrgurUJiPe+jOajXejEe36i1WMfkqSPM4uiZAWtnZHQNUKPN6TymNqoBzFIbI5zMFa8c
 skeJWQo/xq8lDge0D+shWeNdSz48VO/S85oqifFSWOL/BTfg5B18cBgNhqGFTSWNJfXHBcRX4
 ONAGDEuAULRiOLq42/ApTsluHbFl6aC48tlxP6k9HwJujva0xGpfliNYHH/DE/FzK1oR5F5bY
 Apma5Y3VCuFSEY+mHIN46pennx0dHICO8f6KGsKJtljHzrSsY9lbZkISRIsRESzS1mz8x6Ls1
 j1pmR2dkCSGtP1KfD+EPWi4W5ilD6FmKj03X2gDgdTV0m8l9ab4CdndHKfx+p/WPQqcqCZbV3
 0WMInI4DHUb3ADkoHhALf2pOb29FXVXxT7j8BuCEMgTeB9yDIsAa60i2dGK8rd6BbqbLlMZmf
 JvA37TtyRRKhMQ4ROx9W10ui3Rwyfs+eFiXnT3UN4/4ak=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1541
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/12009cea-f93c-4a80-a95f-9bde16dc78a5%40web.de>

> @deletion@
> binary operator bo;
> constant c;
> expression e;
> identifier var;
> @@
>  if (
> (    var bo c
> &    e
> )
>  )
>     return var;
>  ... when !=3D var
> -if (e)
> -   return var;

This script example for the semantic patch language contains a bit of
duplicate SmPL code.

Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch d=
rivers/md/dm-vdo/slab-depot.c =E2=80=A6/Projekte/Coccinelle/janitor/delete=
_redundant_if_statement.cocci
=E2=80=A6
real    0m1,046s
user    0m0,969s
sys     0m0,055s



I got into the mood to check also
how good the following SmPL script variants would work.

@succinct_deletion@
binary operator bo;
constant c;
identifier var;
statement s;
@@
( if (var bo c) return var;
& s
)
 ... when !=3D var
- s



Another test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-timeout 123 drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Projekte/Coccinelle/=
janitor/delete_redundant_if_statement3.cocci
=E2=80=A6
timeout (we abort)
Fatal error: exception Coccinelle_modules.Common.Timeout

real    2m5,419s
user    2m2,733s
sys     0m0,719s



@specific_deletion@
identifier var;
statement s;
@@
( if (var !=3D VDO_SUCCESS)
     return var;
& s
)
 ... when !=3D var
- s


Another test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-timeout 123 drivers/md/dm-vdo/slab-depot.c =E2=80=A6/Projekte/Coccinelle/=
janitor/delete_redundant_if_statement4.cocci
=E2=80=A6
timeout (we abort)
Fatal error: exception Coccinelle_modules.Common.Timeout

real    2m5,305s
user    2m3,025s
sys     0m0,547s



Will such data achieve any software improvements?

Regards,
Markus
