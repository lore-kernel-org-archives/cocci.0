Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86336C46CCD
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P61WaTBY/o9k7HG1IRLAAj4BWYnN7os4SZ7DfiW2/nM=;
  b=kyQuMgQm0ugtS69L1jbEtZyY3vV24AQx0VSbYas/owiUlR6LAqSS8OCv
   T96llAd53xJoeIs9YvyNDZzQOIyK6e1NPksCJQex8kMSJrXRoMxq+NCdy
   VrO+eBWMV78qyYE4zQWQmF5DMlzmPAyLyk+kE+df50G3O5mvcwxtRw/82
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143478832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 09:55:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28992E0CCF; Thu, 21 Dec 2023 09:55:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 455B3E0AF1
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 09:45:11 +0100 (CET)
IronPort-SDR: 6583fb16_SIshTwKxmx8FaHLldsbxP00eH1fbmXqMoq83/om566MzEST
 pRKY+CIHuwza+3aMpWzOXUHItDRdABPWKn8o5mw==
X-IPAS-Result: =?us-ascii?q?A0ExAQAr+oNlmB+IhoZagQmBT4I5gVExBAtIlBSgJoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwSMNQIeBgYwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAQEBAQEBHhkFDhAnhWwNglWBJFgHCTYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEUAg1cAUwTBgEBOIRQgmADrX6BATOBAYIJAQEGgmWwFgmBS?=
 =?us-ascii?q?IgbAYpJgiiBFScOgkUBhX2FdokbB4JPg1CRfH1GcBsDBwN/DysHBDAiBgkUL?=
 =?us-ascii?q?SMGUAQoIQkTEkCDLwp+Pw8OEYI+YTYZSIJaFQw1SnUQKgQUF4EPbhsSHjcRE?=
 =?us-ascii?q?BcNAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwBQ0cAhAsJwMDE?=
 =?us-ascii?q?kkCEBQDOwMDBgMKMQMwVUQMTwNpHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkF?=
 =?us-ascii?q?gQ0EQkLKAMsBjgCEgwGBgleJhYJBCcDCAQDVAMjdhEDBAoDFAcLB14DCQMcE?=
 =?us-ascii?q?ANEHUADC209NRQbqVOBZqJLonMHhBQFoRMVBC+qDJhNqGOBYzqBXHCDN08DG?=
 =?us-ascii?q?Q+OLA0Jg1aPe0IyOwIHCwEBAwmFRgEBg1qBQQEB?=
IronPort-PHdr: A9a23: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
 V6m
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RigJdaBgKNmTIcrlHeml55DYdb4zR+YMi2TDtnoBMCC9F/byqy
 nApoV56faZskdyZJhCo6HnBEDjewK6yXcd2+B4UdeftWLdyQ+Vxe9ZnO7fKnrbdBEW8NQ2uM
 kAT5RD
X-Talos-CUID: =?us-ascii?q?9a23=3AaxR4GGueh24CbJ8Dj+XOGlOq6IsJX1LC6C2OP3W?=
 =?us-ascii?q?iLml7Z7urcH63wapdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ao0Ri7gwx0kglfR2gQ7TX9Q+Qfm+aqLm8UlIti7J?=
 =?us-ascii?q?agNeZLBRKCzutvBHsRpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="75041633"
X-MGA-submission: =?us-ascii?q?MDGIYM9Ax6+m9PkswwnXowR8XZL1/Bwe76ogCI?=
 =?us-ascii?q?bcQusVQ0FkfUitGCb438XJHaREYRQHgjtVcAXuvsl/2ZbuCh51CMQUTK?=
 =?us-ascii?q?epG9ZsbIXVZjlp6GmTIwh6QxsFy+GMPQWEgWMI5un4GIX2vAI6Gb7dEJ?=
 =?us-ascii?q?cfxnzny91V2WHMe+/84Bb6rA=3D=3D?=
Received: from mgamail.intel.com ([134.134.136.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 09:45:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703148310; x=1734684310;
  h=date:from:to:subject:message-id:mime-version;
  bh=CRHtH+8pM2nQFkDzU9tjDc0H0thmzzLEk/b6iMHgphE=;
  b=f+X1i1YvOwi3bSZ7w5DAVZW269BU4usRj839fgHY3IQ3LD0eaiSW3LSI
   Q1+8Rl9p8w41QeS8CGcQkPRnBQUk8wjj1VhL4dW0Ojn/QQoYvDjoTLLZ3
   4BgqUD6Jgi//IRTHCSiIdKbDSj71DB8yTiREika/XHH3GKpsq/2+2Kidx
   7Jn39TCZP3UYY0CsLvX5bkBVshtOyzLcdh1hqtsgSEQSOVpEKAN/dsn9Y
   h49dOeIGGuDnWfKzz1Az9hx/+eVqNbnD7LBoDDyrxFTfvNTChtBtzBsam
   Qivk48CwKpqLzEmEzgrvxoK8oEYFMBTNzgRf9ATAlmk7C9O9mFmYJyoFj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460280933"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="460280933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="867241384"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="867241384"
Received: from mmzakhar-mobl2.ccr.corp.intel.com ([10.252.51.198])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:45:05 -0800
Date: Thu, 21 Dec 2023 10:44:58 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: cocci@inria.fr
Message-ID: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Spatch corrupting struct variable
Reply-To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1352
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/db0e2b-9ddd-542d-5a59-ed15ffd594b8%40linux.intel.com>

Hi all,

I'm at total loss what coccinelle/spatch is trying to do here:

@@
struct resource *res;
expression size;
@@
- res->end = res->start + size - 1;
+ resource_set_size(res, size);

Spatching against Linux kernel tree results in this corruption:

HANDLING: drivers/bus/fsl-mc/fsl-mc-bus.c
diff = 
diff -u -p a/fsl-mc-bus.c b/fsl-mc-bus.c
--- a/fsl-mc-bus.c
+++ b/fsl-mc-bus.c
@@ -736,7 +736,7 @@ static int fsl_mc_device_get_mmio_region
                        goto error_cleanup_regions;
                }
 
-               regions[i].end = regions[i].start + region_desc.size - 1;
+               resource_set_size(regions, region_desc.size);
                regions[i].name = "fsl-mc object MMIO region";
                regions[i].flags = region_desc.flags & IORESOURCE_BITS;
                regions[i].flags |= IORESOURCE_MEM;

??? How did that [i] vanish from regions? Why spatch thought . and -> are 
equal?

$ spatch --version
spatch version 1.1.0 compiled with OCaml version 4.11.1
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE


--
 i.

