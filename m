Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D61C77B61
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b9Q9S7tdP5cjEtPbhVsILOdzQFZbo6WcHOmjl/OPgM4=;
  b=K7XxDRoTRG6okX7HwfYQic+f9/NyUgWkz6DtKzYo8dJ6TRS5y95A3Tfj
   zmQQEGelSX3opi53oSs4t6zzfYljaxHrVxG/uo2USOVUnxMDDqNvnHmwm
   YNrNEKzJ6/1XIgYZpFV7WHP9kYAUY9t5Aufjc8bbSh42v02mdA1kQOiQ2
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271068"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:30:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8D2BE033A; Sun, 16 Apr 2023 11:30:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EBA20E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:30:34 +0200 (CEST)
IronPort-SDR: 643bc03a_puDEWi3z2PIvyzrHGjksj1wktt8Uxipt5ucZEb6i3N7zB5s
 JfU3uZhsZy3TzB6w2bDRxgm1MdblZmiPvKtAt7g==
X-IPAS-Result: =?us-ascii?q?A0EDAAADvztkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHohkMYQwhy6HPohqgVYUg?=
 =?us-ascii?q?Sw+DwEDAQ1BAQIEAQEDBDiERwKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkc+AwMjHQEBESYBDx8GAhEVAgJXBgEMCAEBg?=
 =?us-ascii?q?nqCKAEDMQeuAoEygQGCCAEBBoJjmSgfLCJUgV4JgRQtAY0KhDAnD4FVRIE8g?=
 =?us-ascii?q?0KDfYEGgxyCZ4lrkGuBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUljT?=
 =?us-ascii?q?IF7BAIURA4dJQQOAxkrHUACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4B?=
 =?us-ascii?q?hs0EQIIDxIPLEQMQjczEwZcASkLDhEDToFHBIEJgQEGASYknyABgQ7GMzQHg?=
 =?us-ascii?q?iuBVoFZDJ8NBhMvg32TDA4GkiWXdyCCLqVRgWM6gVwzGiSDNk8DGQ+OIBmED?=
 =?us-ascii?q?I8JAT4/ND0CBwsBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 hNk0mOWjswy+T2q71plfzL3
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:4yNhFaoxs/RarkWWA3mxYOEaV5r/eYIsimQD101hICG9vPbo8P
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3Acn3wUGm4cTbQo3qNmHVxtvB2fSLXOSzwyy3BGFe?=
 =?us-ascii?q?VM2BsFOKsSgHB4K9HqvM7zg=3D=3D?=
X-Talos-MUID: 9a23:Uo7ClQQvUdqjMMuSRXTcihp5ZOJGzp+AN0kuzIQpsZm+N3xJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271067"
X-MGA-submission: =?us-ascii?q?MDGDv/zoxofriDl47tlO7/DwvD81PyvU60r/ke?=
 =?us-ascii?q?SmCoZ8g3Mgzg+/K/8PrhF7EDs49izp9xWj4UtWD8otH38GyXkFHxPnHz?=
 =?us-ascii?q?uRgBW6SmCzi2a0zx+bBtd83KRif/X+Rf0FNv2bB7C3atDHiQJJC43yBW?=
 =?us-ascii?q?m372NCf259xdOUCkBdXMQ5Sg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681637431; i=markus.elfring@web.de;
	bh=taXUqh59A6s5jLK2AMqvzxLyUAQof+foOlZbJMHpMq8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=p9kfvogrpzQcjehpgr3vP9DNvYmhJg8KnjpHfTbqiHUTG3YxRhyZRsKC8nn+PNh+C
	 IgctmtE7Yj2+U6GP1vj1ORTpV9MQdIRBGP58JhboY8McSsnaByroM1WKqxYp0dcq/l
	 ioUtOmWPjfJNPg67h03/J3bcoXa404RRyr7Vvo/fbat9lMrSpNfb9BymbDCKeZcMIN
	 nrjLU8Wm1fGHnQzpmhycjOnlN5pp3AUuuLgnCnGE31FaB11k4/0MWc1XES4tr2WnIy
	 YTUgB55TX6YiYI1E1towlw2ha1uZ5NgQG120BsOdO70zIXgnTPyKohZcR4sxGZGPjX
	 kRfJC40Dj0i3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1q4xdN0mZ8-00IAk1; Sun, 16
 Apr 2023 11:30:31 +0200
Message-ID: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Date: Sun, 16 Apr 2023 11:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iw+v+aCnrNtx+5y/6kxjkN4Kl9V8fZd2CmNmbqSHjI8zITy1Dor
 mtT4EPmX04v67L/2/64dI2v9e304IcgaVfVslHTvtnl9ifXrlbphIXi+qVRda/UUCGKRLb4
 Dv81299GNFZMUAqzqwVIiR9pOeRdpk0+qqY9WtkH0E0yV0HEZvKpdofwKlUPV1700fVGAbb
 09ujBRsH5FoaJkta6rswQ==
UI-OutboundReport: notjunk:1;M01:P0:zua4EbQXjH4=;7ZivMlPiTYDvOkou6nAEnvn5XvN
 eCzlVuZ63BrSP26RHrwBjVTrIPRXMTJVKHPt6nodf4EJVysz/O0JDlUs5ryIP7suVXI66vT0P
 KE4rmIfU8/Qn5BcOK22TmQ5dLNgRERfTjFBf1smW5JaERJGZm6MaMVjPk4roM6+ASlyAPGfi5
 lj+/6BNg+U/Vb1kVmaHoxdrE70JAtSUei/TePlpCUoQ65B82N12Mnzi9rq8mf+QVdFMB7liz0
 l6Bqp2srEG595VAXjSmMDfsDrylb4gF2oGVzY/AwInkGTCXAfSEDQppCtPCUPhCGQ6Y29XrZL
 xg3BmmhY2aHLuyhuySou35Qf28K9LvUjFKRA+PBJi6I88zhaTFi+NJZVaGZldp07B13ztW6w8
 Hj4EP7SKEFLQBeyqTm6hKd0mHL8x9hT3EC4SR4Z6mRl15RT1p0UzUO6VxLdCMEB5h9xRfRQhV
 5e47X1dIJ5CGGjrWPVjO9WFtoMzf2GjehoPKE/Z5rwNWZH6Zw0/5071afdjKVkZpsUh+8DhYw
 QuELHn/+vKtoxiXLfUgepzJGd5LSjTHGvyLYgG7VDHG+EBKgDwrpz+87tDUvwAQgsYN2MWz/R
 /W26T4hI8XhnLAxhs13bsDPf/USwhQGv/TUx4U/jOGN0c/BYAjwao9yXEOlIUKPiuGXj+2ZlZ
 +GlBDqRnsaHS6xRfd3Rr//uL0eCuiTa1VRVqzqv8y6OSqSc9UXy7JB9r76UJ1eN5Y5UwUhyKd
 9vw762GQnv66SXXDwojErJHAhST7zHUZ2cswJf/3DjchBoKo1rvv2IbY44+5aMf9uhWANDOIw
 tXqJSQ8YD74MlrIxjoDrbza+aAWJDjEYNgN9N7zUIbaxuZNevtaVq3fZaGrD2oodIbY8rjEZc
 uJoDtz36I5hUuKb2rdrxsmN9z+uDZ8vpK2uT9Szt6rF86Em19WoT2Ug9g
Subject: [cocci] [PATCH 0/9] GPU-DRM-nouveau: Adjustments for seven function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1060
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/2a746461-844a-2ad6-7b52-03f13fe1b9bf%40web.de>

Date: Sun, 16 Apr 2023 11:22:23 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (9):
  debugfs: Move an expression into a function call parameter
    in nouveau_debugfs_pstate_set()
  debugfs: Move a variable assignment behind a null pointer check
    in nouveau_debugfs_pstate_get()
  debugfs: Use seq_putc()
    in nouveau_debugfs_pstate_get()
  debugfs: Replace five seq_printf() calls by seq_puts()
    in nouveau_debugfs_pstate_get()
  power_budget: Move an expression into a macro call parameter
    in nvbios_power_budget_header()
  clk: Move a variable assignment behind a null pointer check
    in nvkm_pstate_new()
  pci: Move a variable assignment behind condition checks
    in nvkm_pcie_set_link()
  pci: Move an expression into a function call parameter
    in nvkm_pcie_set_link()
  therm: Move an assignment statement behind a null pointer check
    in two functions

 drivers/gpu/drm/nouveau/nouveau_debugfs.c     | 19 ++++++++++---------
 .../nouveau/nvkm/subdev/bios/power_budget.c   |  3 +--
 .../gpu/drm/nouveau/nvkm/subdev/clk/base.c    |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    |  7 +++----
 .../drm/nouveau/nvkm/subdev/therm/fanpwm.c    |  2 +-
 .../drm/nouveau/nvkm/subdev/therm/fantog.c    |  2 +-
 6 files changed, 17 insertions(+), 18 deletions(-)

=2D-
2.40.0

