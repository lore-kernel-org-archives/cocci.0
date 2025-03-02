Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2AC282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XAjxnHbZt7O2sowQljNKhNG6jmP0PgDVtJXqvuqsprc=;
  b=Z+xY0Y6ga2XYRZzoSYpRZ+ibN9VNCj0DVScv+hfvrnfTrixcgZWOkBWW
   sNCKK5k6N9yuzowhH+2q2TkGqSm5l8fvOAVA4I1C/HNkCyYTGSCzEHkOl
   CYvlc+LZiLkTog6b2t1NCeHpW7ruLDBrYO5aHikXXrq7GDj+wkxuElzt+
   4=;
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
   d="scan'208";a="211067727"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4A147E0D25; Tue,  4 Mar 2025 10:58:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 37A60E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:07 +0100 (CET)
IronPort-SDR: 67c4822a_kSMS8UKVLjp5zueW/V+J3TYjRR0yzASRyynEaYjkK9qQYdX
 PXIm2jVun9VJ/iOHgSeEX72DMSRJzOBITl7jt+g==
X-IPAS-Result: =?us-ascii?q?A0EKAAAngcRn/6Mwd6haGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHjE0ggV4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gBQIYDgICP?=
 =?us-ascii?q?QEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJgRouAYhOA?=
 =?us-ascii?q?YVSGYN9eicbgg2EfYIfgWsQhAQWglOCM4Fqgz2VDoR3jloHYV4cA4FuFxKBd?=
 =?us-ascii?q?gOBD4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DAwMDjQAUhEECAoNrgy+COlQMC?=
 =?us-ascii?q?209NwgtPQhCHRKgdTqEOgcBgQ0wHS5gZQuTGoNRr3sLgj+BZop4llBNl1OTA?=
 =?us-ascii?q?4gwtEcBhTZggQ4EMoFZcYFtCQsagRtPAxkPjiGELcgjRTI8AgcBCgEBAwmCO?=
 =?us-ascii?q?Y0vNIFLAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:M/MkmKrlO6+Sqi+BgPL8WT4aV5oqeYIsimQD101hICG9vPb1qy
 nIpoV96faUskd0ZJhEo7q90ca7L080maQf3WBVB9eftWrdyQ6VxeNZjLcKqgeIcxEWtNQttp
 uIFZIOauEYZmIUsS+V2mSFL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3AQiApXmnnpYkms2mIqVjaA5wIUKvXOXfa4XjpG1f?=
 =?us-ascii?q?pNWIzbuKJQ0ahv6E6g8U7zg=3D=3D?=
X-Talos-MUID: 9a23:tLml3Ai6xNehnSvcojvmzcMpOdh6+62WB2U2vogpi/ilKhBvPC+lg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743768"
X-MGA-submission: =?us-ascii?q?MDG/C50VT04MxaRHNm9lrG6n2k3tFOGicm8hUm?=
 =?us-ascii?q?i2sWXrzIWCwDZtRi2I2e9BjqGutn2it9QX5KuwT0s1BmgkQpwCqhk4F2?=
 =?us-ascii?q?8JgebNpsTve1wZmDbWlHqsWXTzjX1DPdNkn99rN79HAs0pVlYF4yBzKZ?=
 =?us-ascii?q?ZEq+6Lhr4tp/XlJ3LfW0XDMg=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:07 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931626;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAjxnHbZt7O2sowQljNKhNG6jmP0PgDVtJXqvuqsprc=;
	b=pNCwjOEAHKlzf0wE7LNZ87/QTHMW/pzQfLR1ATk2Ir4ezHhvcADFFZmbdNhV22pWG8HcCD
	UIAFzWvW6DIsCoOJwqRdJqoRALQz/oK7FqTQ6CdEk66UJOSU9wGQsq2k3QRI2b4wiWlu55
	GFSk8k+/WGXnC/W7V9dk0Rd2SyJ7OzobelL8Ji4fIrW3inxWGmd6FFLzjXe919hLwq1Ew3
	4mEuWbkAZEHR0Qv4Uau5S7L3j2BDRtDKnqxdlalvkAn1m5b0W/fLyfrN+bIqPK0Ak8owJ4
	eQ6R+8OH5yX0cUFj2+Q8VLilquxrIiyYKu/4dnHoZp9pPXT2kSnEhyaUn+Tw5Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Frank Haverkamp <haver@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun,  2 Mar 2025 17:06:41 +0100
Message-ID: <20250302160657.127253-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 05/11] genwqe: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2490
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-4-cgoettsche%40seltendoof.de>

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
---
 drivers/misc/genwqe/card_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 4441aca2280a..77b2d191d21c 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -461,7 +461,7 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
 		goto free_dma_map;
 	}
 
-	if (capable(CAP_SYS_ADMIN) && (vsize > sizeof(dma_addr_t)))
+	if ((vsize > sizeof(dma_addr_t)) && capable(CAP_SYS_ADMIN))
 		*(dma_addr_t *)dma_map->k_vaddr = dma_map->dma_addr;
 
 	pfn = virt_to_phys(dma_map->k_vaddr) >> PAGE_SHIFT;
-- 
2.47.2

