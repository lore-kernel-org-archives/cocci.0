Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876C7C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KRfdkDgvTkBq7bn29Gpn8MyAqWDeCH+tjzpw5UYm82I=;
  b=TIRx6sYbg9w6Egg02tcWWsEuKO+NNCCGIlvm1hNUNw1NP/4LIUnp4Seg
   5uO7UXUmH8XQn7cA/j50oFdZSWMj1LCMm22mnkWvDJOgkpiTEPzaV4P88
   SN5jufqo0PQVNum7ABYbYFyfnrWUIL1bod9D4PV5YF6BFD/sF94FXwGIW
   w=;
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
   d="scan'208";a="211068287"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A583BE0DA8; Tue,  4 Mar 2025 10:58:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 991FCE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:15 +0100 (CET)
IronPort-SDR: 67c48233_nKSWeGogTlNanHN146ZbK0bgH+FbrAA8rSiJNDaLLaEF2YT
 DNaEp0VUBfF4qISocxsOJYa30/Hk6+TttVWTRqA==
X-IPAS-Result: =?us-ascii?q?A0EFAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUADAQEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHj?=
 =?us-ascii?q?E0ggV4PAQMBDUQEAQEDAQOFAAKLFQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gB?=
 =?us-ascii?q?QIYDgICPQEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJg?=
 =?us-ascii?q?RouAYhOAYVSGYN9eicbgg2EfYIfgXuEBBaCU4IzgWqDPZoFjloHYV4cA4FuF?=
 =?us-ascii?q?xKBdgOBD4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DAwMDjQAUhEECAoNrgy+CO?=
 =?us-ascii?q?lQMC209NwgtPQhCHRKgdTqEOgcBgQ0wHS5gZQuTGoNQAa97C4I/gWaKeJZQT?=
 =?us-ascii?q?ZdTkwOIMLRHAYU2YIEJAziBWXGBbQkLGoEbTwMZD44hhC3II0UyPAIHAQoBA?=
 =?us-ascii?q?QMJgjmNLzSBSwE?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNhq6N/Q4cYaC8/TJoSLPSh4WSc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:f/ZBbKl0Wg1H8ECUZJjEpMsWzLDpDfIN3DAbv31ZSRFFG/Fw9v
 re/sjzuiWZtN98Yh4dcLO7Scq9qBHnlKKdiLN5VdzJMTUO0FHYSb2KhrGD/9SPIUPDHiQ079
 YFT0C8YOeAamST96zBkXCF+41L+qj+zEjt7t2uskuEiGlRGsddB8MQMHfhLqWwLDM2f6YEKA
 ==
X-Talos-CUID: 9a23:jfdrGmCy454la9P6ExFhr2gyJeAeSyTyl0mNc1WfNGR5EqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AsmY6/A35lhRgusxMFTNA5hRVhjUjpKn2In0To4U?=
 =?us-ascii?q?9q5eEKB1VNQ2b0SmSe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110429644"
X-MGA-submission: =?us-ascii?q?MDGSsbwfzbAsRN3LXS/6isiJlUxvrkvR387uVG?=
 =?us-ascii?q?mQqasCLvHcvIKRBE+K+nEPQs4bCj3ya57uGOaGn+3ABK5N7MKD1vdGe2?=
 =?us-ascii?q?DO2j99ZW7MA+sTucqTUKMDQLps4xFklGWtvRK/a7J0WU6TkflkQsgjvZ?=
 =?us-ascii?q?Su6hcsm4dL68vivsF8QliUUA=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:15 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRfdkDgvTkBq7bn29Gpn8MyAqWDeCH+tjzpw5UYm82I=;
	b=msLWUylxKZrkZloeSFN5bZFcbLSbFE1cttvSkO/sbcFYzOZMJ7QrfX7q/KeJKDTCCqgTwE
	Cmy7gxyKITqqPUSpsCS7G1MqMRTPEE0rGESChTm4bdOm11qcFfU19VdeWkGdCDRk2erDxx
	kDdrSiGJC8bqVFfFWelDM4gaS0EX1FJAHjToIV4v7qro8N7Udd/eU2b50vvHw4+nCCyDVp
	iMV4JdyinVFOmyN1MzYoME93xKcoQ8EPz6PyS8U/d1Bw/PaS5g5Ib0iiqfD+QrZDeUyCFv
	aH0d4JvaWftIryzqqBPR8zUxtU31fm2LuQe5b2oX22cLwFz/FOLen82uN8NLOQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Date: Sun,  2 Mar 2025 17:06:45 +0100
Message-ID: <20250302160657.127253-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 09/11] fs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2494
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-8-cgoettsche%40seltendoof.de>

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
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 3e092ae6d142..5b77b38f0510 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -303,9 +303,9 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
+		 !has_locked_children(real_mount(root->mnt), root->dentry) &&
 		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
-		 !has_locked_children(real_mount(root->mnt), root->dentry))
+			    CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
 		return -EPERM;
-- 
2.47.2

