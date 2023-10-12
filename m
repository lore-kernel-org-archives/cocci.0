Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F420CDB46E
	for <cocci@archiver.kernel.org>; Thu, 12 Oct 2023 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TpcjbmA2gKDWZoMWxh8vQJbQoxF2t2C8kRCkevg3ipc=;
  b=uMRp8Ei/CAnjLhcEyiB2AcMOKOAlgXkSpRPP0TgfH5+Z1P2AaTiihJik
   h4YfA5HR2zdgmsK4F+JcapCneITly95MfVXBRgBZMJpQWP9z3AMoq3y0N
   m+ge2YgcB06W/DJ0DPYxyUR25YVXJZuskx3Eh4b9sEaYTtbyNS+QLVgwF
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="130799478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Oct 2023 09:30:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17094E0205; Thu, 12 Oct 2023 09:30:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F2242E00B7
	for <cocci@sympa.inria.fr>; Thu, 12 Oct 2023 09:30:26 +0200 (CEST)
IronPort-SDR: 6527a092_AKb9qL8bkEQ+yrtJgKiRI9SYyrApNvpcrpmAIQ6oKyIw94E
 3E+QEMzWcSMvwF/R9RRdJF6bnm7YM6Xebx2t01Q==
X-IPAS-Result: =?us-ascii?q?A0HGDwDinidlhwQP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI3egNTMAQLSIRTkTItA4Q7l2qDFj4PAQMBDTkIAQIEAQEDBIIMgnQCdAQFA?=
 =?us-ascii?q?YYTAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4VoDYI3KwERgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCDTpCAQICA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlcGARQBAYJ6AYIpAQMOIwcNBrRTgTKBAYIJAQEGr?=
 =?us-ascii?q?1QfLCJVgV8DBoEaLgGICQGFUYQ1Jw+BVUSBPAyCRzE+gmEDgV+DW4Jog3iFA?=
 =?us-ascii?q?TwHhVBfinFfIgVCcBsDBwOBAxArBwQyGwcGCRYYFSUGUQQtJAkTEj4EgWeBU?=
 =?us-ascii?q?QqBBj8PDhGCQys2NhlLglsJFQw1BEl2ECsEFBeBEwRqHxUeNxESFw0DCHYdA?=
 =?us-ascii?q?hEjPAMFAwQ0ChUNCyEFVwNHBkwLAwIcBQMDBIE4BQ8eAhAaBg4pAwMZTQIQF?=
 =?us-ascii?q?AM7AwMGAwsxAzBXSwxZBG0hIgQOAxkrHUACAQttPTUGAwsbBj4CJ5dOhGltg?=
 =?us-ascii?q?ydRKgKBA0IMNCwMoi2iKzQHgjGBXoFfDIoWlQwGEy+XGw4GkjeYOiCNQ5Vch?=
 =?us-ascii?q?Q6BeSSBXDMaJE+CZ08DGQ+OIAwNCYQJhGGKZz81AgE4AgcBCgEBAwmFRgEBg?=
 =?us-ascii?q?1qCKQEB?=
IronPort-PHdr: A9a23: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
 UNgKVbQMokZcIH2iRQKgrZSg4nAXUbdD4klnw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:am76S6zVK1zjVOPMXOF4KrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:Vijt3WCD+AkfRob6EzhA60sPM/kpSV7AwG7CPErlBmZRQpTAHA==
X-Talos-MUID: 9a23:VsECpATxudRmDxtsRXSvoDhrK5pzzJ+QGQc8gZwAtcueMhBZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="68476285"
X-MGA-submission: =?us-ascii?q?MDHVz6sAMzNHyUNvrobv+RNyiduFBr1NBsxZp4?=
 =?us-ascii?q?JBsLawuO4FXRVAeE8rO7ewaIE7fc8cJssgLBu4U805+CGue671OHAvBL?=
 =?us-ascii?q?6KpYlVY3olTkmLmZ1a9yuc1YOky/cuBLELsIfgp86yHDLnaIDY4+v0Yb?=
 =?us-ascii?q?bClZuY7her6Pnt+VpPCa39Kg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:30:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1697095823; x=1697700623; i=markus.elfring@web.de;
 bh=PChsNbeFPJrE2kDh+1rrJHzKmp9gihLHp9AImbYGDWc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=FHeU1JTroa2L045XAvYR47NbZIQmNT9jIqzbBRuxpXVevf5fzlWYVFuDIAHXjH6iU57onLYOjXl
 l9nsEkewMc7PfueocC/lSZ67PMZPMiw6/KKZB+98xvas0QyreI3so5xVx/U5I4VYeYgmRYKdc5pd8
 SbnMvXAwCTkXL+KrJX6ZWn5Tvs6Ct1rhGS4odap5dDS+SGlCWkIOxE+jB83zaEhZhu4pvHPZJhrL4
 7ZII8RMhHvygRGZgEG+tzV5vMzVJjmoTJqkmT7Emuc3AE/IIkN44T+zlZNMBipl2j3NwLNoUmE4+4
 9+CVrn4UQlIQKdd6gkkDOQqZZkCIF0UkoYrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW6L-1rBYUs2kJJ-00NPIs; Thu, 12
 Oct 2023 09:30:23 +0200
Message-ID: <7d897c4a-aee5-4380-af11-a8ced3f8c31c@web.de>
Date: Thu, 12 Oct 2023 09:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Anton Eliasson <anton.eliasson@axis.com>, cocci@inria.fr
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
 <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
 <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
 <d6ab6509-9969-4f36-96fe-b6ce6bc74b73@axis.com>
 <e695187c-e83-c844-7f70-7bb9d952569@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 kernel@axis.com, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <e695187c-e83-c844-7f70-7bb9d952569@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TT6SYIufUlf/T4NX83z5rVizdWRdXgR+DBDiZlXXWEFcTo57zRZ
 5jsDv+7AChCV+lTBkWLU7xxj312kb1ihGZTK3fNhBIaAht/Qoptqjo/IhJwS2+D7+Y+ua6U
 VaUK3hk8BAznOfWqd9LQzSIZ6UZFOoHV9RYjha/bgroHOKgfJE/oqkW5EYPrLzhCZg9nMQB
 W68VnFxc6NSLd36FScKBg==
UI-OutboundReport: notjunk:1;M01:P0:3piR5wj9fdo=;3n+RvAHePKsId+mpILkeVdO1JsB
 EaW4H4Qlua9qRQNJ/61y4pTlbtYNCn/JfkZO6o62CYyPTtRGJpKvv0dXTd9p3Of3KDrFqNR1c
 O8kwJGNOkCXye7oPJib66hLHPdc4abXA3y6Y5DgR+0t4TssWktzpaPrJf5XeT+lASX0esZQd6
 keeQS7g0aUKJxt7Atm1nXs9jZ2/5h1Npji7M0dOx/dXksrpqugdUzKfAWx8ZOnWwE1fX/U+lb
 HLPpXSitGOg1N/kr8a8FiA4YohGmgYMbyl+lqQLGIx86vx9VbI4JH/LeRF6E+TKOGJryIh1pG
 LlKwR8lSAfmPKThFrB/5xaE8z6Fd7JAdWnogBnvsMDN7L45/f80fI+GvQqcfQn/4KqLOgbtuL
 bMeeQ9ZbMC/TZWPtrM+Dmdj3XwPsOXbzMG1m3xCilaZqOgzC7GSWaez4xvSaygC0MuOzbcR+s
 h+vmrwl3JFZSW2bb0o8pLEKvXawYiYRR29hBK5Y5r/kERyo7GToiXGPFbnAkFZue5H4h76Hxx
 W9LGT6KcVJJMiBRm+Hkm89tcxmDn2IWb25NHoM09tqHdDHrgVBimqZdAtbvnyWyzfdZWZFhe9
 JBWVan3F28efOa8Ut6jJLiQ9h8YUX7UzoQfqsxGg4/8I4Gn5k9chIaZPa3nACtZ6k7ctRMh1H
 3d7T85HuKNQjd50QYlhuV17u1aj4kmi8t7fiGPM6+WBMkxqJGOiioa9XwvWGQv0Wj2E8QZcn5
 3kj76yHYz42/QXGHO/0FStyCaUVf5dzjsiKEPUjp57MwoDUkHUTnzJ82IAI6HAzaNRItSDJnp
 CxhAFf+vrrUAC08L2C/ruZ0RDL9owW5Dcd+YyFu2y7LkAIcb7V85jy9MIYSGXu4oMRj19rH4c
 JlTwP73j2axFiqI+oJ6sYacdnOUn6hHKVdgfb1cWKk8Tx2mRPICdpfQvNCdZ01McWw9yduyGY
 FYCQbg==
Subject: Re: [cocci] Detecting differences according to source code analysis
 warnings
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1256
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/7d897c4a-aee5-4380-af11-a8ced3f8c31c%40web.de>

>>>> The problem I'm trying to solve is to be able to diff the output of t=
wo coccicheck runs
>>>> and notify the developer if any new warnings were introduced.

How did source code analyses evolve?


>>>> That requires the output to be stable.

This seems to be a reasonable expectation.


>>>> spatch is always invoked for each cocci file in the same order.
>>>> However, the output from each spatch invocation is not stable as it
>>>> examines each source file in an arbitrary order.

Will such information need further clarifications?


>>>> My workaround is to sort the output before diffing. The line-by-line
>>>> sorted output only makes sense if the input is one line per warning f=
ound
>>>> and that is why I try to discard all output except the single line pe=
r spatch warning.

Can any other data formats become more appropriate for efficient compariso=
ns?


> OK, thanks for the discussion.  I was also thinking about whether it cou=
ld
> be possible to make the output always come out in the same order, based =
on
> the name of the analyzed file.

The Coccinelle software determines file lists.
How stable are corresponding file search results actually?


> Maybe it is possible.

Selected data processing variants can achieve something in this direction.

I imagine that there are possibilities like the following if a =E2=80=9Cst=
able=E2=80=9D file list
can be used.

* Perform desired source code analyses only sequentially.
  I am unsure if this processing mode would fit to execution performance e=
xpectations
  depending on the size of used file selections.

* I guess that the current parallelisation technique can trigger data outp=
ut variations
  because of the creation of background processes.
  https://opam.ocaml.org/packages/parmap/

  I assume that algorithms can be adjusted for the concatenation of genera=
ted output data.

  The programming language version =E2=80=9COCaml 5=E2=80=9D (from 2022-12=
-16) got better support
  for multi-threading.
  https://v2.ocaml.org/releases/5.0/manual/parallelism.html

  The program =E2=80=9Cspatch=E2=80=9D can eventually control the software=
 execution then in ways
  for a consistent data processing order, can't it?


Regards,
Markus
