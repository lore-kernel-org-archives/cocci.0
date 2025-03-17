Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6ADC35FF8
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mbjwaoVVacXQtZw2iNzfEchHhyqc9/GDge/fK8gSGVA=;
  b=PEFHEAFgxUuKuyTAh4NwbYFrXCbGF9h0SKypSVX8OghNhdaBRpnqOyCr
   EKMaG+JwIOm3qa1ntTKi9yp+OhAp8duVzqIeI4Z4Wp7HwsjtSG7uhl+Y9
   eQNyCbqD/OiIOhCcYb2ARgreG3bz9kyxoaOibsohrCdp2ysMjoRefzYVb
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419384"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:12:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9DDD4E0D7B; Tue, 18 Mar 2025 10:11:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5310DE0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 09:00:56 +0100 (CET)
IronPort-SDR: 67d7d6b9_rJGUSWU+W205gF6XHohw4jGUkTsrMI+lR1u9yS5ktGFz0RP
 5LCmCwB9/bRDJ3i7JUTMHzGHGsjBFmA4nqTyQvQ==
X-IPAS-Result: =?us-ascii?q?A0GoAQBj1ddnjqKSqVFagQmBUwKCQn1ZNAcISIglrDmBf?=
 =?us-ascii?q?g8BAwENMRMEAQEDAQOFAIsgAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEBATkFDjuFTC8NSQEQAYIAO4IWLA03fwEHBgEBO?=
 =?us-ascii?q?FB/gwIBgmQHq1mBNIEBggwBAQaBCIFg2TiBZQmBSIVtgmMBhHxwhHcnG4INi?=
 =?us-ascii?q?QdOOIV3hXCBaqlsSIEFHANZLAFVEw0KCwcFgWwDNQwLLhWBRUM3gkNpSToCD?=
 =?us-ascii?q?QI1ght8giiETYQ8hD+FUIIRggWJLIRhLVCBFR1AAwsYDUgRLDcUGwY+bgehd?=
 =?us-ascii?q?QE6hEOBDsk/gj+BZoFjijWVMBozgUuCJYFqkWwOkwOSSoY0pEuEaIFnOoFcM?=
 =?us-ascii?q?xoIHBSDIglGAxkPjXgBQYFSgkLIWkUyPAIHCwEBAwmJAIZoNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:LM03F6EBC7sRU/vXpLqEMceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPHjP+U4ssRAb6Ku90cy7Lh3hHPFOkO0s1NuZLWrbUQiTXfhfBOnZslrd8kTFn4Y86U
 4KSdkaNDSfNykZsS+D2njfL/8QhOK13uSBudr+pk0NcShaL5pSwUNSLy6gKAlXaWB9aaYEKA
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3Abs4hsWq+659jSsuSQRTYACPmUf11WH/49kjbGnS?=
 =?us-ascii?q?9VHczUJuXc1ygp4oxxg=3D=3D?=
X-Talos-MUID: 9a23:JCXYZQv09CoPTeSSL82nvAFHP/po0ZiUOXsMnb4imPSGHHZ6AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,253,1736809200"; 
   d="scan'208";a="213168462"
X-MGA-submission: =?us-ascii?q?MDE6SYTb7TgjJXtvJMUXUpCctIxRalBrv1eiM7?=
 =?us-ascii?q?C5Wv3ZWe8UaxSpsUKghfd59vvDfFliMACxFq3WIeyA1o/HPZ/qUNLOUZ?=
 =?us-ascii?q?qu2Pn4ndjdUWEi4KkXuk4vBdnOf8I2O6POVU3pjj1msx05RUbyEfoZ9M?=
 =?us-ascii?q?bc23oY2/rTNWOJfayCodDNdA=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:00:56 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742198455; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SD8wtsKDRG5P7zEBNMQYYfdOyI7uyQA7uVnl+uqBbLC9Mvgy3Mk3f7virp1Egt75He
    J8LsvJJLVXxQ4cvsjf6R9hlxjaCWobDkd8tI6KidDw7O0YOw4De+oy9CWAupUOYOrquq
    7+8tk2O1ouSnnWOYL1lNapLZohAkfn51pmjAlHgpbkFvLbMKw3BoA72UU2UrrXtI4bOj
    VfnvMVXNt/9ZITJ6cvMOpygjLHZHjN2oXOX8JlA7YszEX9Pn3zx5Y5ht2za5tPR0t4rx
    lrnVlaOZ8BM1t0xNQiY8W0MIXpfybjEkb/YYNNMBrlujWnRd3jEnzUTwFcTIRtTmVNvs
    2Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742198455;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=mbjwaoVVacXQtZw2iNzfEchHhyqc9/GDge/fK8gSGVA=;
    b=UuhQwAmfrQSwcr0on7/WHWBLwthjZ6ZBCwP02O9EgI1QaxGi8/zfPzgG5iRrN36HyY
    079WZJnNBIIR8lJY2tFKm7S6+3cdwq4Pi1dFdh+VLieCdRyTCDt4WH+I37ljYJyMbXXB
    FwHFzFI3Byj38AK60s4dpthWrniec/DXjWFHau8SPpQKw+VwwHSLm9Tpe9UqoWup5tDG
    pOQPPAda/Njyvvt+k7C9pT/nPsd9BCh1xROnhQDtGNXMfgMw7G+ZvtNGWsmeuFq24cQR
    z+Ft3Ohi2uqGJ6igEBQgC6m/UB53mvgJgG9STDFqbPgIBSjz1ZOOzzQuciE69IDuAGhB
    QblA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742198455;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=mbjwaoVVacXQtZw2iNzfEchHhyqc9/GDge/fK8gSGVA=;
    b=hd5pRjCIbZX/oIR2+AWYIt83wB2lzhDl3dn+zBgj0pGAJlOjEc4hClDQa3UMq4727h
    FlUHKV4dGoehEdBTw2EymVPJpUUZ9zNELC/sZumXSrjzZVLkG0C9Uqhw+rFcB4Q5vcoP
    bPdgIt6RwL01ZmSWMuT7TN/m2e0c1uxF1jldIYfmXqLH4FXTFcB/DeN31IV2bF/O07qp
    EsDDdDyqv0dkd/bLmnTm6BiTQ++iTWqvidIT0k/HhbMNvnaRa68wGIXE3SXRU5IhJz9n
    SAUSNLIaacIhAA8KmVlU0Dteoap51cgopZLuhdgHPnNMm10k0pFgr8WNLOCknRqfoI6k
    DGxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742198455;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=mbjwaoVVacXQtZw2iNzfEchHhyqc9/GDge/fK8gSGVA=;
    b=IF9Dhz8KqhLn5tb82DrD6XlniG5+GLvC3940QweNmXScJG+6QrqkhYgpA9Hs+GSgtv
    FGPisnSsB2HvLVBTkiCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSVYjagMyZmkab3cQQk8ITYm/c/zHbXf6Nw2MS9"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12H80tuMX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 09:00:55 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Mon, 17 Mar 2025 09:00:51 +0100
Message-ID: <20250317080053.27298-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v1] Adjust help text for --with-metainfo configure
 option
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2601
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317080053.27298-1-olaf%40aepfle.de>

Fixes 3c20ea6f8 ("Install AppStream metadata file")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f0c585329..bc20724ea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -554,7 +554,7 @@ dnl --without-metainfo disables metainfo installation.
 
 AC_ARG_WITH([metainfo],
     AS_HELP_STRING([--with-metainfo[=PATH]],
-        [Install the bash auto-completion script in this directory.\
+        [Install metainfo into this directory.\
          @<:@default=yes@:>@]),
     [],
     [AC_SUBST([with_metainfo], [yes])])
