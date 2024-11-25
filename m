Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C09FD58D6C
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uXJbjp9TEMr3wvQ+2vZpGMNVJ7tkSZTdw7fouyXGnz0=;
  b=ZdE6FjkboarVH6nKvyWKkH/E5+xKMO/EI546lKV25qgdHPM11K8yQvnO
   oUSeSG6Rw6Ad4mvmqH2FLfSdjFDpIhgIy7EDBvL21VDx89uz62Tw+RAC2
   HVjn8RUgLdJ2l143vuIOQKfMIoNA4feFNbBwgvn16QI/6gL7gxoBLZb0W
   A=;
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
   d="scan'208";a="195724119"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D421E0133; Mon, 25 Nov 2024 17:57:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 00C81E0133
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:26 +0100 (CET)
IronPort-SDR: 6744541a_QDl9P0Pez2ygxRCseFDHj1lCTzzVctrfaUKkhTrCzkEmj4G
 Zw6UxfqlQ45ZqVzjVfKGmVnIosgdTIBX/sgbb+Q==
X-IPAS-Result: =?us-ascii?q?A0EgAADMUkRn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2JUQORSoxNIIFeDwEDAQ1EBAEBAwEDhQACi?=
 =?us-ascii?q?lkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQKBChOFe?=
 =?us-ascii?q?w2CYgF0gSQBAQEBAQEBAQEnKwKBCwIBAyMPAQ0BATcBDyAFAhgOAgI9ARgZg?=
 =?us-ascii?q?wGCMQEBATEDr3KBMoEBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQGYN9e?=
 =?us-ascii?q?icbgg2CUIItgh+BaxB2gw6CaYJEgTGDXiWFN4NJmzMHB2FeHANZIREBVRMXC?=
 =?us-ascii?q?wcFgXYDg0aBNiiBKYMRSoUMRj2CSmlNNwINAjaCJH2CTYUZg0aBI2UvAwMDA?=
 =?us-ascii?q?4ITgSuGBh03CQMLbT03CAwbBj0IQh0SoBtGg0EHAYENMB0uYHCTF4NQr2wLg?=
 =?us-ascii?q?j+BZYp2lk1Nl1GTAIgvkEyjcgGFNWCBBz2BWXGCARqBG08DGQ+OIQwWhAvHE?=
 =?us-ascii?q?EUyOwIHAQoBAQMJgjmOTTSBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GSA+2KnzwzSE7fE6C+goq/NSSGXpDfIt3DAbv31ZSRFFG/FwWf
 rDoB19726StN9xYgBFpTnkAsO9qBznm6KdjbN7AV7mZmnbUQiTXeRfBOnZogEIcheWntK1l5
 0QEJSWbueAb2SS5vyU3ODXKbsd/OU=
X-Talos-CUID: 9a23:UIrfnm8i/m1b9tTrke6Vv3A4NMoCQnvE9lvvBnGZE08xWoeSTVDFrQ==
X-Talos-MUID: 9a23:ghZGgwuKYT4v04yE1M2nijF4D91GsoGUFWdTuL8t5+XacnNiEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102546516"
X-MGA-submission: =?us-ascii?q?MDE7qy9nvSNYMkc+tRkXFKbyCty93v1rkWfwI5?=
 =?us-ascii?q?3nXbBoON7afXvGLb83l/dPIHli9hbKNaJK45qa0gCXGpBu6nxVCNAzj3?=
 =?us-ascii?q?LEg7+4RRxrsTbMUo3c57S/nDTxRisxfgdogdAy/xVI8ow6eN+KVQq++x?=
 =?us-ascii?q?3gUIesSMdl/2aPv0tHIE4Ctg=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:26 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531225;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXJbjp9TEMr3wvQ+2vZpGMNVJ7tkSZTdw7fouyXGnz0=;
	b=Mdb4xOeLmRxHgooUx3JOijX3+LMSlj4GRxvTHEPWd1og60SnG27YZkYD2Ceyjx+7B333QM
	ZyLgYWtMHFmpAS4jQ0VS7zdfJq9cQ9qMI1VXAh2OJqLOjuiladwhEQxhs5QkMpM4d+88/j
	YY61kw6/zF9K2N5hNSbT40SYIj6CvC8CdzV+bU9xHoZrZXIDj3azO4Pssrl2ovpBnSmIzD
	Mv0etwsaWtD04zX2lsGfDFSxo61zYM7APvut1Mn8G6dTOzCPF4BW7lPtuQElc1iacTmQXf
	8qW38Pn8ScwYATLiIG45X5y8yS2CZ7A99XQg1RtL/r9qa9EeW8r4/TzXlS2Ylw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:56 +0100
Message-ID: <20241125104011.36552-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 04/11] hugetlbfs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2105
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-3-cgoettsche%40seltendoof.de>

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
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a4441fb77f7c..e4f6790c1638 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1508,7 +1508,7 @@ static int can_do_hugetlb_shm(void)
 {
 	kgid_t shm_group;
 	shm_group = make_kgid(&init_user_ns, sysctl_hugetlb_shm_group);
-	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
+	return in_group_p(shm_group) || capable(CAP_IPC_LOCK);
 }
 
 static int get_hstate_idx(int page_size_log)
-- 
2.45.2

