Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B25CCA470
	for <cocci@archiver.kernel.org>; Wed,  8 Oct 2025 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Bn+QPp4pRCIJDKGggdXGpYZ28y2Uk6zjLOAaY8G72tM=;
  b=DKi5MfsIzr675clzMiZJ1j8mH5lYN7CdZe3wRGOf4A+b6RhtVSnNqBTk
   HQORyqAEX5HdE97Y9Av+MFoL6j1GU971fsy7RrHCx300ue5d2EqD4Bt8V
   X9Ga+FgmYKt1La90fWbkZ/hTQewHGUuSkgak2ktuNQwkoVRejJ+TEuF+1
   g=;
X-CSE-ConnectionGUID: dhTNyn7IShOFHnbNvzvrvA==
X-CSE-MsgGUID: FQQZj2s/TzyNCdiZahDt+Q==
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
X-IronPort-AV: E=Sophos;i="6.18,323,1751234400"; 
   d="scan'208";a="243080594"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2025 12:10:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A1C5E0CD5; Wed,  8 Oct 2025 12:10:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CDF8EE0171
	for <cocci@sympa.inria.fr>; Wed,  8 Oct 2025 12:10:47 +0200 (CEST)
X-CSE-ConnectionGUID: k66ck896SbuomRePliPqhA==
X-CSE-MsgGUID: NwkPFv8cRUmYNJxDY0LO8w==
IronPort-SDR: 68e638a7_JPUrigHM03UND9tgsLctLtdBrIe0mOs+7QS/v8c39ltYOIC
 cBMOh3VaVk2eNLkKgo5zalCn0AVvhH3fXh14XxA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FbDwA2OOZojwsR49RagQmBUIJAZR0GWDMEC0kIhE2PU?=
 =?us-ascii?q?oMNg1KYCoFVgX0CDwEDAQ1ECgECBAEBAwSCDIJqjFMCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAjoFDgoxhk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOm0dAQERJzQCJgJzAQGCfgGCIgEGEAEDNgcNB?=
 =?us-ascii?q?q8wgTKBAYIMAQEGgmnXdh8sIlmBZAMGgRwuhW2CShoBBW6EYIU3D4FVRIE8C?=
 =?us-ascii?q?4JHMYMBBxcEgiuDDoJpgiaBFYZBgnWMXoFKHANZLAFVExcLBwWBYwOBDzI8M?=
 =?us-ascii?q?h2BJ0Uedz1Yg0wiaA8GgRODWYlsD4M0AgELbT03CQsbBj2Rf4J5gTmBAIFIk?=
 =?us-ascii?q?zGeHpRjNAeCOIFngWQMiQiBJpU+BhMvl1IOBpMFmQaOCJVgOYUggWg6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OOoNnM7QEQTUCAQE4AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpsn
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:YjnI6qrmkuEgq+h/yk5cYpkaV5sDLNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXcH2/hqAV7CZnithILMFu1fBOTZslrd8kHFl9K1kJ
 0QC5SWa+eAQGSS7/yKhjVQeuxIqLbozEnrv5am854Hd3AJV0gU1XYcNu/tKDwSeOApP/oEPa
 vZwvACiyureHwRYMj+Ln4ZX9Lbr9mOuIP6bQUADxsH7hDLqT+z8rb1HzWRwx9bClp0sPgf2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k5spfCNeKgs01LCyprgqzfoxuV5CLoThwiuCy71QBls
 XKvn4bTohOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCuJa7LgpMyfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0m3w/iuQe5kYvEbf2KYUh7rD3znklVavoLxiKrLzP19
 MeS/000cwmM29yqUqp+FWHjubcB0jbVS32P3Tq8vblrwS+2koJgXfwjfZv4Eso5dYzTYJJ6P
 /DNbktnLZSTtUOZaY4H+sZR9CrY1a9CC4kHVjiVmgPLpt3TU7lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lSVKV/NFgjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EaDtfAU/
 i+NZpKC7voLHfoG4xOwwriMqMiYUU2QYkQoJI2SliOqsXEJsnjsfHaau/aIP73HTMtSgrEcw
 8+tfjIVbB9B2yQKwzFaULqKgLQU126+Yg1C6TT9fUSzo8WX7c8zTT9oW7Jlv2jOHlFrrE8el
 d4Lffujr67zFPGj1r10w==
X-Talos-CUID: =?us-ascii?q?9a23=3AoLy4DGu5/yl+5H1SddnHWjUy6IsmLCPWzyeBfXS?=
 =?us-ascii?q?yFGFscrCtTV6o4aNNxp8=3D?=
X-Talos-MUID: 9a23:T1v4owURC8+atK7q/BnzhwlMKpdj2ZmrOWYvgbk34+2jZTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,323,1751234400"; 
   d="scan'208";a="127607768"
X-MGA-submission: =?us-ascii?q?MDFOG0VjfcQXetDWeH7lmMSG4jitblR734rkgr?=
 =?us-ascii?q?InJSo9K05L9JFySGvsFEoMthd8PrPfCXqt5/ZGTK/rNGrOdpHCPn+3iz?=
 =?us-ascii?q?JYJDGQhaQT5igNc3CMXuHq8nvah/YYWp5U4+1sCkAiZrI9VF6Jcz12Pz?=
 =?us-ascii?q?Y7aXuGJGt3RI5Rwzjjmj4/Yg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 12:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759918246; x=1760523046; i=markus.elfring@web.de;
	bh=Bn+QPp4pRCIJDKGggdXGpYZ28y2Uk6zjLOAaY8G72tM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cdsOgfSelUxvH8MzEFnDr1m+6LkuZkhmr6KDTTwFT8Hcj7YTaPa8JF6Mpo01Jk4F
	 435Cqg5VwkllVPUxT/5auwilaFyKeHAoTExAsQGhmwOHUHhJw8J9gOUg4Aeae9P84
	 cAFtnSPBx7KgPIEIR3++jUTqD7sffVjXz91dtzbfWZwkhFtkasLCXGpNdgma+D2Xo
	 JQiOeEjpWhbrMuBF7z0OF/Z4pQXJ4C9JsblVoPTpaGy+MDqArZI7p1nnz8zdK9zDt
	 JmwE/jCNnrvXE2sGxBqsTo0VJBLla2XMgmuj2ZyCCxfPjuEayRytdRhuDTafa4qLX
	 BdP07QRTcpA2t/nbkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJNd-1uehnO49QN-00Lp0r for
 <cocci@inria.fr>; Wed, 08 Oct 2025 12:10:46 +0200
Message-ID: <36f32079-1045-4913-9fff-3d1110b153c7@web.de>
Date: Wed, 8 Oct 2025 12:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vj+0m3YYJCMrtLDwTY+gXRDY/3YzYhJHv6WdNxns3pccLv32nqv
 gGwWRX0pmiVQYUq/T3wuF00yCLQuap+eet/tilQ2tALrUbB97zpSxg6CG6/MZ/4uxpcel4X
 rqoCmaVnVqcMI3ngKn0QLIcFzwWRIcD7Yvi+fYli2SOrk5ggrmRe2HFOs72Ss3TXgqW3Xby
 eW8T6s1eqLAY5oSqGpA9w==
UI-OutboundReport: notjunk:1;M01:P0:prqAFd8LV4U=;cNdleLjpsKIUQEO4P6sN5OOmkWd
 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
 KntM3GAzkLPoOw==
Subject: [cocci] Reconsidering condition check repetitions with help of
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3063
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/36f32079-1045-4913-9fff-3d1110b153c7%40web.de>

Hello,

I inspected some source code.

Example:
smb2_compound_op()
https://elixir.bootlin.com/linux/v6.17.1/source/fs/smb/client/smb2inode.c#=
L697-L748

I noticed then a special implementation detail.

Now I would appreciate if another source code transformation can be achiev=
ed
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

@display@
expression e, x;
statement is, es;
@@
(
*if (e)
    is
 else
    es
 <+... when !=3D e =3D x
*if (e && ...)
    is
 else
    es
 ...+>
|
*if (e && ...)
    is
 else
    es
 <+... when !=3D e =3D x
*if (e)
    is
 else
    es
 ...+>
)


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> time /usr/bin/=
spatch --no-loops show_questionable_condition_check_repetitions.cocci =E2=
=80=A6/Projekte/Linux/next-analyses/fs/smb/client/smb2inode.c
=E2=80=A6
[no diff output]
Note: processing took    72.8s: =E2=80=A6/Projekte/Linux/next-analyses/fs/=
smb/client/smb2inode.c

real    1m12,835s
user    1m12,532s
sys     0m0,184s


Under which circumstances will such data processing become better supporte=
d?


Another SmPL script example for further clarifications:
@display2@
expression x;
statement is, es;
@@
(
*if (rc =3D=3D 0)
    is
 else
    es
 <+... when !=3D rc =3D x
*if (rc =3D=3D 0 && ...)
    is
 else
    es
 ...+>
|
*if (rc =3D=3D 0 && ...)
    is
 else
    es
 <+... when !=3D rc =3D x
*if (rc =3D=3D 0)
    is
 else
    es
 ...+>
)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> time /usr/bin/=
spatch --no-loops show_questionable_condition_check_repetitions2.cocci =E2=
=80=A6/Projekte/Linux/next-analyses/fs/smb/client/smb2inode.c
=E2=80=A6
warning: line 9: should rc be a metavariable?
[no diff output]

real    0m5,863s
user    0m5,728s
sys     0m0,122s


Regards,
Markus
