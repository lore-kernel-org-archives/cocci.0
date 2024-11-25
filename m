Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE26D58D6F
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P6AGqeaWbUDe9y5vDnfY9zmRKUFqqfOHVoZc9OQ1JdE=;
  b=en/Dl9Fz+uhvdcQGvakpoZx78yTJUE6MQGn1mT2RpUcUwt/4hg7AFF9s
   XX330dBH9rFcHvAL53w7qIylIozBDzzRqVrGcYu69f31MtXH8K+wC48gj
   /GGP8GKSl0gHCEbjXfOi7dbuWV9H732bgVQmpVdk5q17baKiYRYIdtTS8
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724302"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EEE99E0D8D; Mon, 25 Nov 2024 17:57:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 068ABE0D1C
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:46 +0100 (CET)
IronPort-SDR: 6744541b_BXBaBDoyv89nK/rU/7hwoI2Rq/kwcHdJ5tnogxHcpvvdN+7
 GL0Y0AbVfkhRKwK8Ps0KbA1K3vonEnpY4xptq2A==
X-IPAS-Result: =?us-ascii?q?A0EhAAC9U0Rn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3R/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EfYIfgWsQdoMOgmmCRIExg14lhTeDSZszBwdhXhwDWSERAVUTF?=
 =?us-ascii?q?wsHBYF2A4NGgTYogSmDEUqFDEY9gkppTTcCDQI2giR9gk2FGYNGgSNlLwMDA?=
 =?us-ascii?q?wOCE4ErhgYdNwkDC209NwgMGwY9CEIdEqAbRoNBBwGBDTAdLmBwkxeDUK9sC?=
 =?us-ascii?q?4I/gWWKdpZNTZdRkwCIL5BMo3IBhTVggQc9gVlxggEagRtPAxkPjiGELccUR?=
 =?us-ascii?q?TI7AgcBCgEBAwmCOY5NNIFLAQE?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tm4A26rliGIyuuFpnB7M8mcaV5oqeYIsimQD101hICG9vPb1qy
 nIpoV96faUskd0ZJhEo7q90ca7L080maQf3WBVB9eftWrdyQ6VxeNZjLcKqgeIcxEWtNQttp
 uIFZIOauEYZmIUsS+V2mSFL+o=
X-Talos-CUID: 9a23:tgmWHGEG1KkT+qRMqmJM00geGMAMMUSN5yrRPGWoFVkzVpCsHAo=
X-Talos-MUID: 9a23:rq/EZglzZFE2/aHKW04tdnpuJZZkuLmuWHxTqrwFosy0CyZUJh6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628557"
X-MGA-submission: =?us-ascii?q?MDGR8vvbKJ1VPtJqImjkgWmnm+kek5xnqcsrr1?=
 =?us-ascii?q?v2xKrg5qOStqG+dMApUqrbd2PCJ9/YwNB7IFE7fPKSrYvN+8BP2+G4rV?=
 =?us-ascii?q?tVpj8U+whlzoYuF+w9jN2JDe/wSY17g1Y7WPQJaADY6EvBX8N35takO6?=
 =?us-ascii?q?eWGXizXyV3wYXajtjccnGqSA=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:27 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531226;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6AGqeaWbUDe9y5vDnfY9zmRKUFqqfOHVoZc9OQ1JdE=;
	b=fj/rRme9yehwZA25c2Ni1/9tPmwADULk1KpFn/cVxyAjjBhxyj8Rg7aA5iUrANhXFj3LDF
	EVEGpnqH2qxuU7xy7zbZVAr4PN6VXR1u6SaguSc7GBpAUwBFP2HQJcV/7rETu2atweRoUA
	DK3HuU8potvt0ji3IF7E3NaCAPi/OzmAMILLwPVEudy8K/V1Sdv63rqOny0qQy7l6LvQi7
	Qnx0BqyipTaX8aKvcgEzC2iX2EuYf59bvAQ8Qid3xQZb/Mswa40vldOlKBAAKO8BzLXU81
	uOeCjHBIVLuJs5xjOP6IrtRBAxUkLS0+WGDcxbdL3NWIKBOcibJLOqsDLIBdFg==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Frank Haverkamp <haver@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:57 +0100
Message-ID: <20241125104011.36552-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 05/11] genwqe: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2111
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-4-cgoettsche%40seltendoof.de>

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
2.45.2

