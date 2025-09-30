Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4056CAC5B8
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PpluSChczr8BaGSG5s4VrAsAMr0xyrz2rcrPAwRdOn8=;
  b=O9dIV7nn7n2tpNc23VVB6lo7SMNmjDOm+DmIHoWP2v1nA2UKROMfqmh3
   V7MUs26/0CIltvEZsnC7z0o51yLnHAadeQIYbJquHK1RDcKnD58np3q8f
   ecFcvvw/ITsBJ1dYD6XPd2NvKbZ0hOyo4i8AFnKpQtubR2QFqFCsHvEQX
   c=;
X-CSE-ConnectionGUID: CXadE/EXT2iNgx9GM+gbvA==
X-CSE-MsgGUID: fJv/7GgiTi2HhmzZ98ijwQ==
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
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241841571"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:45:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83C61E0C55; Tue, 30 Sep 2025 19:45:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BFD6CE0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:45:24 +0200 (CEST)
X-CSE-ConnectionGUID: F57jiNtkSrWuUx2VdD/O8g==
X-CSE-MsgGUID: 89Sb7ilHQLWx4BbBXkptcg==
IronPort-SDR: 68dc1734_tN7apX0RkNNokvwc6KSVf0ZAA8Ymxr42p5u4bGWWPkRRmm5
 JWgKRFxV1wDfKs0gIFUSX1Mrh+wgh44mwadsiiw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EIAABIFtxogAQP49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/ZR0GVDMEC0kEhFGIHIc0giEDh?=
 =?us-ascii?q?DuYCoFVFIFpAg8BAwENRAoBAgQBAQMEOIQ+CgKMRgIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTpEAgEDIx0BAREmAQ8fAQUCEQ4HAgJWBgESAgEBg?=
 =?us-ascii?q?n4BgiIBBhABAzUHDblagTKBAYIMAQEG2l8fLCJZgWQDBoEbLgGFbIJkAYVsO?=
 =?us-ascii?q?wmEMycPgVVEgTwLgQmCLYN8gQaDHIJpgiaBFnU/VY4ofY4ZgUocA1ksAVUTF?=
 =?us-ascii?q?wsHBYEwMwMgCjQxAhQcARIPBBYyHXMMKBKDbIENhB4rT4QOdD5ag1Mkaw8Gg?=
 =?us-ascii?q?RWBG4JABQGJSyAPgQ0CAQttPTcGAwsbBj2YeINGgQ4sgkqTB4M9Aa9rNAeCO?=
 =?us-ascii?q?IFngWQMii6VPgYTL5dSDgaTBS6HZZBzIotsgXqbOYFoOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iE+g3WEYIoqAbkpQTUCOgIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 l44jhAniryPUYVvCp//dpQJPDQ6VZ/i8xM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H/9Ii6uBOoVDnStgjXQL8woE7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHjJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniEhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:X3SLLG8HFcxEgygRAP+Vv2BJRcIkVGHe923vPnKoU1hlZPqyGVDFrQ==
X-Talos-MUID: 9a23:gkGeQgR+H9xhONzFRXS81Qpoa8Zsw52KN1BRu58si8qcKSd/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126969767"
X-MGA-submission: =?us-ascii?q?MDGGSDRcNKjUrquOkdvcYQpQJzrvFmcypnLCAy?=
 =?us-ascii?q?yRpGIBtoAWHXFVeCfeQs75yxVYx0ScWi8tUz9VyGiejOUFQMp1bFEnFb?=
 =?us-ascii?q?fj4nkNsnFe8qxpqpBAYZ5Qsoeh5YgxCLfwLlABTEc0j0d7CMyFWYOtZy?=
 =?us-ascii?q?7em+vYJduiE1K2GLBPz3vWiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:45:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759254323; x=1759859123; i=markus.elfring@web.de;
	bh=PpluSChczr8BaGSG5s4VrAsAMr0xyrz2rcrPAwRdOn8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f+bucK+kxjCzCPLmmanf8wvB6zlT6NEhkeJAyx4elkexNb0v3n08EbfpHv8Wbf78
	 ArUBExMCFPzPfFrB71dUlSIqAmYn8S7HOw+bX8uwxdxlZgXvlnVrsAXuwftkA5epH
	 Q45cIFoI4sruFr8h/zbyFGo6yNnCyaPlbmAY/KIrDDjQdRpXjcaXcJrNiP9uCEUl0
	 v4APPBx8p963bxd4og6aGbwxTLU/ixtOLe2hPHhiifAf+P9dDmg3KRBvtTyEUlgFC
	 FwkRxPQob6rAWVa7k6+lKrmF8yCZQUrYalrn3keHKkA8vNjplvhmA0ygYFLHMZamX
	 MVXwHQ20Gf/11sgVHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1uYB4I2ag9-00pLm8; Tue, 30
 Sep 2025 19:45:23 +0200
Message-ID: <dd0da1bd-12d7-4820-9513-4a04cc13d8b8@web.de>
Date: Tue, 30 Sep 2025 19:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJ/o8DVDoTEOzTMY9AJ4yOYEpGfrCYyo4LGOm8Y8hWzqDcHMW3z
 dDE20KJlCsgtmSaK9o9qBmo3Up23duAXDz6CNSSd8rxEBuBdj32beY2k0jgEkW54OeC7xcw
 HcV/YYO/uQUZVQLfVsQot5CEmEmfwr+m/U573Gt82t/CaZyiSp2Tn5di/SS/El0ZPd7IXh8
 t5E5cx5m+3Q6UoclxA+CQ==
UI-OutboundReport: notjunk:1;M01:P0:o3h7lwKwQHk=;xLzMuzKoeTJTZT2Ss/ow/Nb8v8G
 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
 HNJyi21ADGl/67Jb0d2NIFW3XA=
Subject: [cocci] [PATCH 6/6] Coccinelle: ptr_err_to_pe: Distinguish
 implementation details better for operation mode properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3062
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/dd0da1bd-12d7-4820-9513-4a04cc13d8b8%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 18:24:19 +0200

The coccicheck operation modes are connected with data format requirements=
.
Take them better into account in the affected SmPL code.

* The mode =E2=80=9Ccontext=E2=80=9D works without an extra position varia=
ble.

* The other two output modes should not be mixed with data according to
  =E2=80=9Ccontext=E2=80=9D information.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index f0bd658c7edb..fa93a6f2e3d2 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -12,13 +12,20 @@
=20
 virtual context, report, org
=20
-@r@
+@depends on context@
+expression ptr;
+constant char[] fmt;
+identifier print_func;
+@@
+*print_func(..., fmt, ..., PTR_ERR(ptr), ...)
+
+@r depends on org || report@
 expression ptr;
 constant char[] fmt;
 position p;
 identifier print_func;
 @@
-*print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+ print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
 @script:python depends on report@
 p << r.p;
=2D-=20
2.51.0


