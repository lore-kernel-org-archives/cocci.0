Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C49ACCF9F8
	for <cocci@archiver.kernel.org>; Sat,  1 Nov 2025 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rDtsQXGPyMLri87V0fvSXcf2oqKNzDo7OvfiTltv6ro=;
  b=SlQ362L0i2BkUzLle51ryPq8t96lrr5/jhDw6KnAufJQnOhCSLmbse3s
   iQR+8VouS+yCdoHz43LOO5GzjlgROOPQLd2I5277O20UVB4c3xUVBGXBc
   kpXVXJCkAuHXY1mMBDGjKRWdAbrBykg0gx+aAnC24Gh7uX3yZyJFfQ72i
   g=;
X-CSE-ConnectionGUID: jdn15UtXQ/m5AvhkZAhiUA==
X-CSE-MsgGUID: qS/kKv9ZTkqUtgVB6ZN59A==
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
X-IronPort-AV: E=Sophos;i="6.19,272,1754949600"; 
   d="scan'208";a="247096707"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2025 13:43:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EB7FE0172; Sat,  1 Nov 2025 13:43:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92ACDE0171
	for <cocci@sympa.inria.fr>; Sat,  1 Nov 2025 13:42:59 +0100 (CET)
X-CSE-ConnectionGUID: GUeb7M7BS7i2/KeGBUzXnw==
X-CSE-MsgGUID: 8pKBHN5BSUy8iJNLMg5YNQ==
IronPort-SDR: 69060053_Nl6W9SmphISgVQ+9wyxTpZIxn5oLtaRrp7AM5e+Pti8gUcs
 9+k3D4pwY4Qp2SGoX3SD9k3mU69y2QL3rviL/ZA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FrAADN/gVpeAwR49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZXszBAtJhFWIHIc2hl+HPIdViHmBVYF9Ag8BAwENTgECBAEBAwSCDIJ0j?=
 =?us-ascii?q?FUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?UMOCjGGTw2CW4EsgSYBAQEBAQEBAQEBAQEdAkdGJx0BAREmATQCJgJfFAEBg?=
 =?us-ascii?q?n6CIwEGEAEDNgexK4EygQGCDAEBBoJp13YfLCJZgWQJgRwuAYVsgkoaAQVuh?=
 =?us-ascii?q?TSDQ4EhD4FVRIE8C4JAB4V/gw6CaYImgQ6GJ5JlgUocA1ksAVUTFwsHBYFjA?=
 =?us-ascii?q?yo0LTI8Mh2BJEEYcT1Xg0khaA8GgRKDUQaJIw+JRgIBC209NwkLGwY9lFGEC?=
 =?us-ascii?q?wGVfCizATQHgjiBZ4FkDIkIlmQGEy+DcZNhDgaTBAGZBiKjRhOFRoFoOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiGEM8tPQjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23: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
 PzwgLMeNBjA
IronPort-HdrOrdr: A9a23:WfpzKqmu2YrH8kKJGWQ+mrlC4BbpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQ6VxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObOEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:gUPMcG6/BiNmej04N9ss23MZEJ8ALVfmk3aKZGy1JkxUWo2TVgrF
X-Talos-MUID: 9a23:3+L6UgjFvD7+a7JF6Wvvn8MpZN9LyYSIVWo2rIRWuuuiEQl/Zga7tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,272,1754949600"; 
   d="scan'208";a="247096704"
X-MGA-submission: =?us-ascii?q?MDEtfApJPAbIG9VIYJWixQMMW2ACUSAKQY7YDc?=
 =?us-ascii?q?HwEwtXSCLmpWccpaRslng185HBnn8ZMC4u+8tWFgqm8BpbnNPPqkMrK/?=
 =?us-ascii?q?CI1wV7G4ommt3z4yC34gd0cn7E8gTlEMH2qNgAkAVqyNt+0SgEHPNtv3?=
 =?us-ascii?q?Wba43/BlcyKbQ7BoAOExkRYw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 13:42:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762000978; x=1762605778; i=markus.elfring@web.de;
	bh=rDtsQXGPyMLri87V0fvSXcf2oqKNzDo7OvfiTltv6ro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JhzwNVNgzDdKb/1kP/OR1L2PZTA12KYum1+Ovkol3O1zN6RYV9ScvGlNMGIE/ZW1
	 9RfX7y77ZGW9DK0grnAP5flb+MAHMsa3Gf/RcbbOMNYsNFyCr/WNxAP+LAMdxjyBr
	 QwK3SyhdEjjnIw+ga2dGvYVWdCweqDK+mAkHK932qtItR5hJvKkrXBB/DVr+eQq6K
	 I3nB8JvAMIIpaOrGxHd2aIGG8GvIBueEw9+Gg97U+1mNaGqyjS+yptkmJK7vM4QTb
	 u4pwcnsNlDN7+p6qBYTbzmRdGwNOwfeq33lI4UazEFz+MJFZUaUZgBHhIExufux72
	 Sh8WC35W3soAVERriQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1vmrrw17EE-00m324; Sat, 01
 Nov 2025 13:42:58 +0100
Message-ID: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Date: Sat, 1 Nov 2025 13:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:USpDIOU0dB69LNgSEuPV+jqgMgPhiPW/CQZU2wUaho32lyC9gb8
 8BfwJ1stb/PuC4N4H2n7PIXywLp1Udx+r4wmkCc7A7pT9/OK1qMXb0GovaQwO7X8kFpAWs8
 ikf4OkirxDbRVn/84FolhHaIGT113Gq3N+LgzcEklLV5CicQJ76UCxEx1b9ebtZCPKw0aWd
 6DGB/52MgUGBzgmzqzqMQ==
UI-OutboundReport: notjunk:1;M01:P0:OpkVSMgbTHY=;tXi1eEEwrei+L3SYvaA062S2L9l
 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
 HCKx1/bG8gZHXfTAG3JHNj3OR/BPASWWSqA=
Subject: [cocci] [RFC] Detecting missing null pointer checks after memory
 allocations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3135
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/52e58416-d75f-4a47-9555-88a99d664069%40web.de>

Hello,

I got into the mood to try another simple source code search out which
can be achieved also by the means of the semantic patch language.

@display@
expression size, source, target;
@@
 target =3D
(
*kmalloc
|
*vmalloc
|
*malloc
)(...);
 memcpy(target, source, size);


It can be determined then from the generated diff file that mentioned
implementation details can be found at 11 places (4 source files) of
the software =E2=80=9CLinux next-20251031=E2=80=9D.
Will such analysis information trigger further collateral evolution?

Regards,
Markus
