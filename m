Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9FEC5478C
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/YSpNCkkKhAvNgsskrKNYytWAIc9jPYJMb4rhvvEZ4I=;
  b=CG8Da+T2kUHbC+qp5bn7wU9uGTvNGH9tyg/FHsG5EIW7bMKnEDZKrRHa
   P2kMfd9pvGsIMHNk6TBPcKx43Kvn/9ZWPYKqLqA/PyIywdI4iUGG4EaDo
   tcxG0T8wKQD7PU8x5DHZzGiTsAlMg18eh6GrtE5haRSdcKgmxfShWxbdM
   I=;
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
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153449220"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 11:33:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D11FE0CD7; Fri, 23 Feb 2024 11:33:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D3BE8E008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 11:33:27 +0100 (CET)
IronPort-SDR: 65d87477_Ul+RI52BIMLndizhjUf0KyUnrNlAvZxkd3vzAWcZxSLTiX2
 jugHVJjH1YIZyOxdLDchADhb4XIJrzTcH2+lmvw==
X-IPAS-Result: =?us-ascii?q?A0E5BQD1cthlhwQP49RagQmBT4I5YhoDUzIEC0iBT4MEj?=
 =?us-ascii?q?0SBdS2EPoFVjTCIcIFWgUA+DwEDAQ09BAECBAEBAwMBDSuMNwIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CV?=
 =?us-ascii?q?RiBDoEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECDTpqHQEBEScYHAImAnMBAYJ8AYIqAQMxBw0GlGucNIEygQGCCgEBBoFYQ?=
 =?us-ascii?q?U6sdR8sIlaBYQMGgRouiAwaAQVliUEnD4FVRIE8C4JHg1ABAQIYghODDoJog?=
 =?us-ascii?q?haDO4EmiDmCQgGGR4gCgVMcA4EFaxsQHjcREAUODQMIbh0CMToDBQMEMgoSD?=
 =?us-ascii?q?AsfBVQDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMU?=
 =?us-ascii?q?ANnHxgaCTwLBAwaAhsbDSQjAixAAwkKEAIWAx0WBDARCQsmAyoGNgISDAYGB?=
 =?us-ascii?q?l0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4g0YEE0QDEIE0iiaCVAMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbBiIeAp9mAYM1WYFNBE4ckySyCzQHgjSBYAWBXAyIeIEjlR0GE?=
 =?us-ascii?q?y+XMQ4GkmAemDuNb5U9LoUegWYCNoFcMxokgzZPAxkPjjmDYTOBC448QjUCC?=
 =?us-ascii?q?TACBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 iff/IYGng==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZajItasoTKaEr/5AsKpVjv6C7skC94Mji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKdkrNhR4tKPTOW81dASbsP0WKM+UyGJ8STzI9gPO
 JbAtBD4b7LfBJHZKTBkW+F+r8bqbHpnpxAx92utkuFJjsaCZ2Imj0JbjpzZXcGITWua6BYKL
 Osou584xawc3Ueacq2QlMfWfLYmtHNnJX6JTYbGh8O8mC1/H+VwY+/NyLd8gYVUjtJz7tn23
 PCiRbF6qKqtOz+4gPA1lXU849dlLLau5R+7Y23+4YowwfX+0aVjbdaKv6/VfcO0aOSAWMR4Z
 jxStEbToFOAj3qDyWISFDWqnTdOX4VmgPfIBmj8DbeSIXCNUwH48Ytv/MnTjLJr0Unp91yy6
 RNwiaQsIdWFwrJmGDn68HPTAwCrDvDnZMOq59ms5Vka/poVJZB6YgEuE9FGpYJGyz3rIghDe
 l1FcnZoPJba0mTYXzVtnRmhIXEZAV6Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0LtOUsgVZ6RgA/ppe7r/NkXdBRbXdG6CK1XuE68Kf3rLtp7s+b0woPqnfZQZpaFC7a
 gpkGkox1LaV3ieevFmhqc7gywlaF/NLQjQ9g==
X-Talos-CUID: =?us-ascii?q?9a23=3AIQAmM2qOzA7oizdeHzrXg4PmUfJ8d3D4x3jwGED?=
 =?us-ascii?q?iMnRTFrezRlyh9Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:mqzCcgQUjaWC6Pg6RXTw32tAFcdPyZi2N14ymsVFlZiCNyBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="80434564"
X-MGA-submission: =?us-ascii?q?MDGFaApQN62oxwfAtITEY38rnsPYWj10xLcyzy?=
 =?us-ascii?q?vHnWqosUgPCT7tzC/236Brjz5MY91zVyzQfUNZABwsH1JLsZX4sBqOn6?=
 =?us-ascii?q?tPR+W7ay8PAXIZx7fH5f6I32R+ZpPArxSsuouPoa1ORa9ct+SC8dTIPW?=
 =?us-ascii?q?VMyqpuN90hIU/Eq9xT15IEFQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:33:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708684406; x=1709289206; i=markus.elfring@web.de;
	bh=9huQgTepf8HXf8TyOG4xMGktxyY84WNqrjI9mUC0HOE=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=OohOeeay/s74aC4XclFw0wf60zVBFYsXTPyikTifKMjw9VXlr7w7MwYNEhFD1gRj
	 f53BAxZFHbZpi6e9o7ziKsUWC/1J0sLpEbWyxcWAAqk3fXnLCiEUpHi3Gck9gfK3c
	 +U35s4ycU6fIrwbntKV/1iCmZ+KWxc2EZo2gvAmsa96PAHkh3S1WcMRvpllE8sw2d
	 jLiE2wtd4uXUugdXTEDhM/MDJN1dxqRw8OT8OPN+6lBB4Z99YNmPRBXsiK6IBXVpU
	 TOK7t7S4ARhGOFuIHjppY71mqonUXxEkV+/oVlGPWHrZhT1EnMw6eO984UvSCjw2h
	 O7qW5Y9CXH7sdqjFWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCut-1rVOEQ3cG3-00RKhz for
 <cocci@inria.fr>; Fri, 23 Feb 2024 11:33:25 +0100
Message-ID: <c8285996-8d89-481d-9262-5824879e7e1b@web.de>
Date: Fri, 23 Feb 2024 11:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wH9VMwGgGn/xUaATBfXLDboRaUkcr0fgA9dv9jdAuT9FvwcYBR5
 bQn4u0f+Nh/CCLe/Ois7W2J500LbaXCQxZFxTovIE6GOlkYYGvFUlMNvwswjC4Il8NRd7Lc
 ln7zOPJyD/B8aO+9icYg5YAjYud+1sA3UiyPmLnF6ZVXadAQlY1g/+aF//TNAxuW+NcBxmC
 CLcM197/jmU67EsbdZzHw==
UI-OutboundReport: notjunk:1;M01:P0:uRFCaT5I/mA=;90wAgHolTnDAohxdz/rxbiHTMP6
 XKTB1O4ec08jfkO3pehLCWZwJ/YyzzGL8Do8HTQ4wUydfdshvsMOboRoqJRHjEYjE+9TyURTp
 hmnOJnl+Vzauy8T1p/CSM96Z8G9FFcmk8/cS3tKdNzVq9G4Kv7Dw+FzZGV39dvxY9SX4go3fG
 7CyFEaxuHFczgy6iTPzvpGriaIIAMpd7GOQd0FLa3FQTn3flJnXDzIaj/0Cd66QEInjDlYcEL
 Zjaos+scFKiYPDUdjKxB2c3nobfrFNaL9uXR05A8/W9ypkhzVG7Td8u4XVj1Lu3fFGY1XYrA5
 H7vvi2P34K/gIvWDbQukebFBU/50nnovcPCCKpl+sr+9hb5FQE2xDIdHVYfMSctRl9nbG9eyF
 brIYRsFej14kzJQcGKeCwACwkKsFyp3ObvP6SYZvt7DbcTmuj+08jxRQsiXvoAl64d0h7Fsny
 PmkQXc4CWnxTghoNsAGfDP56yFsvJxvAlARQWfMd5ocnqJBPnkdOMSl02bQbif9fCoi8NX57l
 jF28SDAXoIUhczaLjSI3N1LB8CWJYK3a1UcHz5tGzzche9Il0cm8ufDPgC29PsYfz3gMukmdJ
 slXe9esfwfOx+oEWx4oehYxkMDuhyNnM54C/LKsKSdIJnK83E7Bo3YmDSW4CfzfFcg7qyvtHm
 OXfekjlg+h+DnN5iyQFNBlHuXGMa1gTdweRYVKiKutZ3y+qFmlPncw9lPIi3dyq1GTsqisTkY
 EXufr2x6/aVgmKKlAbxsbDgykX+5o31LV8P4XThC0oLP/Z7aINKT9vObSLP8DuwBt1ddcAQ54
 PU7mPuX2TFOUvVrUVNQDMgQ502XsMNEe14cybPrrwvcPQ=
Subject: [cocci] Influence of shared memory areas for parallel data
 processing of SmPL code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1603
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/c8285996-8d89-481d-9262-5824879e7e1b%40web.de>

Hello,

A bit of information is provided for the usage of the program parameter =
=E2=80=9C--jobs=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/68c580f1f1abf9979d591=
371e5b2e474f97dac90/docs/manual/spatch_options.tex#L762-772 :

=E2=80=9C=E2=80=A6
This option is not compatible with the use of a {\tt finalize} rule in the=
 semantic patch,
as there is no shared memory and the effect of a {\tt finalize} rule is th=
us not likely to be useful.
=E2=80=A6=E2=80=9D


Another bit of information is provided for the applied OCaml module =E2=80=
=9Cparmap=E2=80=9D.
https://github.com/rdicosmo/parmap/blob/963608763589e03de38e744d359884d491=
e65460/README.md?plain=3D1#L21-L26 :

=E2=80=9C=E2=80=A6
The principle of parmap is very simple: when you call one of the three ava=
ilable
primitives, map, fold, and  mapfold , your OCaml  sequential program forks=
  in n
subprocesses (you choose the n), and each subprocess performs the computat=
ion on
the 1/n of the data, in chunks  of a size you  can choose, returning the r=
esults
through a shared memory area to the  parent process, that resumes executio=
n once
all the children have terminated, and the data has been recollected.
=E2=80=A6=E2=80=9D


Can such descriptions fit better together anyhow?

Regards,
Markus
