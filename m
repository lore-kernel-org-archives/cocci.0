Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9CEC25B74
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Y8MZD7xt33kGVDYfwikRRN3MzeXkU6FUy1ojKrFFYlE=;
  b=PhNlkm90emVDoChaoJyfNEZa6NXXG0exykcGu17jGxNSPREtPsDQZJ0Y
   /0N9cqGxuT1KUOYhHXTYHju95Cn0NkLMDuPo2qiGXejZJNS8uYXqYm5BZ
   mTBmTaIbiZy3QWhQcQNcdtF20Fy+X2pVSwv3rPP/dsU1gRQpj1MP8rH3U
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="164742873"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 21:31:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AE62E0CD4; Mon,  6 May 2024 21:31:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F3C5BE0133
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 19:53:11 +0200 (CEST)
IronPort-SDR: 66391907_qxP7yBrAW3g8kR7vY1wtzvK5I25eX2xIIFO4GaKyK3Mj0jW
 S+bkzcy+1R5mwn6pUZYAxuRlXvsuwca+QcOg8mg==
X-IPAS-Result: =?us-ascii?q?A0EJAABfGDlmkPBO31NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYFxUnxXMwcISJdUnQuBeQEDAQ05CwQBAQMEj?=
 =?us-ascii?q?S8CHwUCBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBIB4QDieFdA2CZwGBHoEmAQEBAQEBAQEBAQEBHQINgTw/cRslDAGDEgGCZ?=
 =?us-ascii?q?AQDAQy0GYE0gQGEetk3gWUGgUgBiC0BiR2BRhuCDYEVgnKEf4Z+BI9Eil+NT?=
 =?us-ascii?q?YFRHANZIREBVRMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGBlkgFgkEIwMIB?=
 =?us-ascii?q?AMQNAMgbxEDBBoECwd1gzEEE0QDgTiJeoM9KYF3hCBLhHaBeA5ihzwdQAMLb?=
 =?us-ascii?q?T01FBsGoXyDPXoJNrMulQOCPYFggWGKLZU4M4FNqGeYYiCNVJsTgXskgVwzG?=
 =?us-ascii?q?ggcFIMjTgMZD5cumDNBNzkCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:W7oMo6g27KBOUr26vV9gLSgrvnBQXscji2hC6mlwRA09TyVXra
 6TddAgpHrJYVcqKRMdcL+7VZVoLUmxyXcX2/hzAV7BZmnbUQKTRekIh7cKqAeAJ8SRzIFg6Z
 s=
X-Talos-CUID: 9a23:YIV6t2DftWidZtT6EyBV3mowOesmSGDU6lv9IxCUNFtTQaLAHA==
X-Talos-MUID: 9a23:mgOmbAtdtYJekLPv182ni21YEN9E86+XLE1TqK80u8jVESFTEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="164736606"
X-MGA-submission: =?us-ascii?q?MDEaiiLxrxaJO49OmAUt4PtPC6fJoj256F16hg?=
 =?us-ascii?q?2gmDuQuftXy2Psh7gEU8qdqZyVWTVwjpGmk6AR+UEkmV4cdXXeGbOXmm?=
 =?us-ascii?q?cqwIhoG8cdWo2QoXZcahsjCbQEO42E+pOv9H84ORCFWFL53tVm4TXbuu?=
 =?us-ascii?q?XCs1OkJYMvwQ/k5YBFPVhYVQ=3D=3D?=
Received: from bmailout2.hostsharing.net ([83.223.78.240])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 19:53:11 +0200
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 43F06280067B9;
	Mon,  6 May 2024 19:53:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E7C5AEB3E; Mon,  6 May 2024 19:53:10 +0200 (CEST)
Date: Mon, 6 May 2024 19:53:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <ZjkZBvuXlZAodPAU@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] coccinelle matching of identifiers
Reply-To: Lukas Wunner <lukas@wunner.de>
X-Loop: cocci@inria.fr
X-Sequence: 1708
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/ZjkZBvuXlZAodPAU%40wunner.de>

Dear coccinelle maintainers,

Linux kernel commit 5c6ca9d93665 ("X.509: Introduce scope-based
x509_certificate allocation"), which is queued for v6.10 in this repo ...

    https://git.kernel.org/herbert/cryptodev-2.6/c/5c6ca9d93665

... triggers scripts/coccinelle/null/eno.cocci:

    ./crypto/asymmetric_keys/x509_cert_parser.c:69:9-15: ERROR: allocation function on line 68 returns NULL not ERR_PTR on failure
    ./fs/gfs2/inode.c:1850:6-12: ERROR: allocation function on line 1842 returns NULL not ERR_PTR on failure
    ./fs/smb/client/cifsfs.c:1186:6-12: ERROR: allocation function on line 1173 returns NULL not ERR_PTR on failure

The first of these three errors is newly introduced by the above-linked
commit, the other two already existed before.  All are false-positives.

I would like to silence the newly-introduced false-positive and have
attempted to do so using the small patch below.

However the result is that *only* the newly-introduced false-positive is
found and the other two are no longer found.  So the other way round than
what I'm aiming for.

I find this bewildering.  What am I doing wrong?

FWIW, coccinelle version is 1.1.1.

The newly introduced false-positive is triggered by the statement:

    assume(!IS_ERR(cert));

Which is a macro that expands to:

    do { if (!!IS_ERR(cert)) __builtin_unreachable(); } while(0);

The macro gives the compiler a hint that variable "cert" is not an error
pointer, which prevents the compiler from adding an unnecessary check
for that condition.

Thanks!

Lukas

-- >8 --

diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
index 7107d6c8db9e..79112d51bee8 100644
--- a/scripts/coccinelle/null/eno.cocci
+++ b/scripts/coccinelle/null/eno.cocci
@@ -26,10 +26,12 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
 @r depends on !patch exists@
 expression x,E;
 position p1,p2;
+identifier assume;
 @@
 
 *x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
 ... when != x = E
+    when != assume
 * IS_ERR@p2(x)
 
 @script:python depends on org@
