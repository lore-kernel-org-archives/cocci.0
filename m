Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA107C282D9
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lrrmxCSXObAFhEIo/8fh8weOhY7nqO46PR4GZl5VqBk=;
  b=VQkF4NAlBmHBV8mrce0lRiX0Y++rLQtzWAkFYvpfuj27FyIMJYORlRtE
   G+YCQD9zJV5OXHYH07ku9ESoAin5K6ILm0PL3q9KCRqX8c1n8btoEXwnD
   LF4DI8HtwRhbKSCE020QuMfdt0ZICDBOzfFX5ad+Wj/6mTmgsjBYssmZb
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211067774"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 88AF0E0D6A; Tue,  4 Mar 2025 10:58:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 42F78E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:09 +0100 (CET)
IronPort-SDR: 67c4822c_hNXCzi6z4ABnFcKdNtfgJ1E12btejElmdUqFE5binbYFkHi
 S2I7ClohwkDRbGML5OJP93fDYVmFHaZjfacQTyQ==
X-IPAS-Result: =?us-ascii?q?A0EHAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUECAQEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHj?=
 =?us-ascii?q?E0ggV4PAQMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gB?=
 =?us-ascii?q?QIYDgICPQEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJg?=
 =?us-ascii?q?RouAYhOAYVSGYN9eicbgg2EfYIfgXuEBBaCU4IzgWqDPZoFjloHYV4cA4FuF?=
 =?us-ascii?q?xKBdgOBD4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DAwMDjQAUhEECAoNrgy+CO?=
 =?us-ascii?q?lQMC209NwgtPQhCHRKgdTqEOgcBgQ0wHS5gZQuTGoNRr3sLgj+BZop4llBNl?=
 =?us-ascii?q?1OTA4gwtEcBhTZggQ4BNYFZcYFtCQsagRtPAxkPjiGELcgjRTI8AgcBCgEBA?=
 =?us-ascii?q?wmCOY0vNIFLAQ?=
IronPort-PHdr: A9a23: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
 daJmK+hcF+qFvrP8M8ACs7YL8WJdnYsY0KBJQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gZOAeKFk9HyNMs8gpLqE6ceALOsnbusQ8zAXPo5KJSC9Ffbo8P
 xG/c5rsSMc7Qx6ZJhOo7690cW7Kk80sKQU3WBzB8bGYOCFggqVxehZhOPfKn/bak7DH4hmpM
 VdmsNFZ+EYY2IWsfrH
X-Talos-CUID: 9a23:OFrcBG6dDku3FTQ5C9ssrFZPFuwsaFbkyFTyImCHB1tWVY2WVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3An3FQVg23Urr0V7XDA94pkjX/YjUjuqL/NhhUk88?=
 =?us-ascii?q?9gMy8Oi52FhWGlCTue9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743773"
X-MGA-submission: =?us-ascii?q?MDF0VySrrTohM7lAT97NG/5oYJN6dQrK5bDT2G?=
 =?us-ascii?q?PQTGYYVLRg0inDORMnBOCgBwLtcWJiFI8rro9PBu9D41cGOkW+GHNg7/?=
 =?us-ascii?q?GIIp+RxzxF9CeUhccJaCvqhiyBdbsBUKmI5ZrxFb44hoVeTBc1VDJzb1?=
 =?us-ascii?q?7xGVUlicabow2xkP+TRTAVeQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:09 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931628;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrrmxCSXObAFhEIo/8fh8weOhY7nqO46PR4GZl5VqBk=;
	b=SJbl8DHfCbWjEsjgne1Kob32i8p6jeDt6GHFv4OHAtoWeQ3lqXQcKH4uFnMbjiXjMxOD6a
	0yRMpAHp77D88bW+DSL4gMGtBcz/cn0z41hBCSIhjBCucvOxUc1Ibv6JN4PdD4Dq6KUXPl
	ZaqJkLCDLg8IMc7i9s1tWJ3YLbESgH/3IhrQqjeQVb15+7Cxff/WR+OmoH+76vSvXTLDJy
	ShYO5VNs0yw2fJWUyo1hI+voMdz6a1l9KdGkua3ARXCyFgGYAy3FWIW2apEV5XIgWzPAPq
	VFeNDqXGoXU2MmvoP06ER9PS9efSClP7dAz0a9k4nAWEOazqkc6cMGnVZqroFA==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org
Date: Sun,  2 Mar 2025 17:06:42 +0100
Message-ID: <20250302160657.127253-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 06/11] ubifs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2491
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-5-cgoettsche%40seltendoof.de>

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Richard Weinberger <richard@nod.at>
---
v2: split into two patches for each subsystem
---
 fs/ubifs/budget.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index d76eb7b39f56..6137aeadec3f 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
  */
 static int can_use_rp(struct ubifs_info *c)
 {
-	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
-	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
+	if (uid_eq(current_fsuid(), c->rp_uid) ||
+	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
+	    capable(CAP_SYS_RESOURCE))
 		return 1;
 	return 0;
 }
-- 
2.47.2

