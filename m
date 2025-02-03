Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA9C02192
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gtZ0uRvYix6ly8XDRmesOsmv2XN8dAoX2BWiSw+KLT8=;
  b=WQ5q70cIhdlrNuCtIVQwr7gS8D5BTQVhYtvQh0+V4lb6fkYaFiMUxGnI
   R7gDdbHwgBj1zlg+aCN334Kkg4lb5wCzYs0e98pxHhUu8yM0TcJsgs8aN
   iQ2hJt6cQw5eTaIhBn2uIwnnYYTc64lo13UzMGRjCpWFXUlLq3gqFzZ5E
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392318"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2FF4E0D1D; Tue,  4 Feb 2025 00:50:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E591E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 00:50:26 +0100 (CET)
IronPort-SDR: 67a15641_xX3k6rPj+Hjrvd2QoeyCqbUeh8ALbu5coFOVQ5c/tQrRzNn
 0O8XAwYKzgFrXRqsnEwBv2J/uSVJ1/M77wBXhTg==
X-IPAS-Result: =?us-ascii?q?A0ExAACeVaFncraaTQ1aHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDfVozBwhIBIRSiB2JUxaLYJBNgVaBQD4PAQMBSgQBAgQBAQMEgUyDNIp/A?=
 =?us-ascii?q?h8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBDIV7D?=
 =?us-ascii?q?YJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBIBUSHQEBN?=
 =?us-ascii?q?wEoDAImAkgWARKDAgGCZAYCDAafUwGHYAEBAosjgTKBAYIMAQEGgmfZOIFlA?=
 =?us-ascii?q?waBGi4BgWGGbAGBbIN/O4NCgSEbgUlEgUqIC4NGgmmBFIZQmkeIGQk/gQUcA?=
 =?us-ascii?q?1ksAVUTDQoLBwVkVTgDIAoLDAsUHBUCFB0PBhAEbUQ3gkdpSToCDQI1gh4kW?=
 =?us-ascii?q?IEdgQ6EXIRDhE6CRlSCRIISdIEXgjaFTR1AAwsYDUgRLDcGDhtDAW4HnT4BP?=
 =?us-ascii?q?INvHwGBDyswICmBBE2Sbi6DbI1KoW+EJYwYlUgBMqpTLodkkGoii2mBeZZEh?=
 =?us-ascii?q?DWCGDqBXEYHIxWDIk8DGQ+OIQwWg1iFE4oqAbkYQzUCATkCBwsBAQMJhUYBA?=
 =?us-ascii?q?YEAiW1qYQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:+IpB1qupDuSgfNQ/kATrEYy97skDVNV00zEX/kB9WHVpmwKj5q
 aTdZMgpH3JYVcqKRIdcbLpAsO9qBbnmKKdjrN+AV7PZmXbUQiTTL2Kk7GC/9SIIUSXndK1vp
 0OT0ERMqyWMXFKye2mpDSiG9wjwN6ImZrY4Nv2/jNGTAlsZa0lzyoRMHf+LqQPfng+OaYE
X-Talos-CUID: =?us-ascii?q?9a23=3AyoYygWnCxC6S1q4oTKH31AEkrTXXOVHCkl2LAhC?=
 =?us-ascii?q?mMDxsRe2nFH7A6bFBtOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A4niULQ7cGMC6unaV5Foww3qCxoxVvoisJW4RwKk?=
 =?us-ascii?q?hmMCGbRRTFzqghha4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392313"
X-MGA-submission: =?us-ascii?q?MDG9GCMSottj8KpyQq3dHzlU8lzAlsl6aOOuqI?=
 =?us-ascii?q?9t25mLio7YSWEiHRHvl8pzulXTUt2UR/3KaG4JUud0iBH03IReIwmNPI?=
 =?us-ascii?q?DmFvCRCvsceSbXX1hqR1t+uQShOxmB/mx6TyVH3D0pVA8avgf83bKbYj?=
 =?us-ascii?q?S690C6lQIa84S1lNSRybDrXg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35FE8205493B;
	Mon,  3 Feb 2025 15:50:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35FE8205493B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738626623;
	bh=gtZ0uRvYix6ly8XDRmesOsmv2XN8dAoX2BWiSw+KLT8=;
	h=From:Subject:Date:To:Cc:From;
	b=Vpzh0KjOSAKXQeC03cgO2ZTKONQBCN6XsU3FjRXdjgI9v53FjtiKquz73hy/MwohZ
	 fBbkRQcqUvulJnQRpCI2+93+tSTaZ1i9fCVxDCyWUb3aJk4qWWU/5pCGnOXwh9zlHu
	 qbWUq+nGbMQtVUKyHF8lVdtdVDBJsna5HEBtUrFA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 03 Feb 2025 23:50:21 +0000
Message-Id: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1WoWcC/42NQQ6CMBAAv0J6dklbEdCT/zAcat3KGumStiKG8
 HcrL/A4c5hZRMRAGMWpWETAiSKxz6B3hbC98XcEumUWWupKadWAZT9hyD6ijZAYHuRcLsBoQoL
 0ZnBVJVVjTO3qRuTOGNDRvD0uXeaeYuLw2ZaT+tlf/SCVbv+oTwokHE2N1smr3sv2/CT/msuBb
 ODILpWWB9Gt6/oFrQTphtwAAAA=
X-Change-ID: 20241217-converge-secs-to-jiffies-part-two-f44017aa6f67
To: Andrew Morton <akpm@linux-foundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH v2 0/3] Converge on using secs_to_jiffies() part two
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2331
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e%40linux.microsoft.com>

This is the second series (part 1*) that converts users of msecs_to_jiffies() that
either use the multiply pattern of either of:
- msecs_to_jiffies(N*1000) or
- msecs_to_jiffies(N*MSEC_PER_SEC)

where N is a constant or an expression, to avoid the multiplication.

The conversion is made with Coccinelle with the secs_to_jiffies() script
in scripts/coccinelle/misc. Attention is paid to what the best change
can be rather than restricting to what the tool provides.

Andrew has kindly agreed to take the series through mm.git modulo the
patches maintainers want to pick through their own trees.

This series is based on next-20250203

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

* https://lore.kernel.org/all/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com/

---
Changes in v2:
- Remove unneeded range checks in rbd and libceph. While there, convert
  some timeouts that should have been fixed in part 1. (Ilya)
- Fixup secs_to_jiffies.cocci to be a bit more verbose
- Link to v1: https://lore.kernel.org/r/20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com

---
Easwar Hariharan (3):
      coccinelle: misc: secs_to_jiffies: Patch expressions too
      rbd: convert timeouts to secs_to_jiffies()
      libceph: convert timeouts to secs_to_jiffies()

 drivers/block/rbd.c                           |  8 +++-----
 include/linux/ceph/libceph.h                  | 12 ++++++------
 net/ceph/ceph_common.c                        | 18 ++++++------------
 net/ceph/osd_client.c                         |  3 +--
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 10 ++++++++++
 5 files changed, 26 insertions(+), 25 deletions(-)
---
base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e
change-id: 20241217-converge-secs-to-jiffies-part-two-f44017aa6f67

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>

