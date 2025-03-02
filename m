Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C40C282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fpiJeKuvGtt7uxh2hFS+dsziMi5lwoHgf9YFZ4de7gM=;
  b=Y3wYTdEVDTX2JCaV7bJ2EA9RKG+QapzmpUEHvOT1jw3SEidn4Ynff6oo
   XNLHLfPRxLMZDMCx8/TKZ9q4BQLV0yN3CY/Cd+M3pfGhJoOoq577Vm4BN
   BOZuIoYYqpBD/MbD5w+IVoDPEeDQ7XQyphVwr5WgZBCcja5S7wgH320yz
   g=;
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
   d="scan'208";a="211068511"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DBBBBE0D3E; Tue,  4 Mar 2025 10:58:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D351E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:17 +0100 (CET)
IronPort-SDR: 67c48234_kOv6C6/Bg9jkLnVws9Y82p0DmkSUEvu7bspkq3R1LQlWcsc
 xcsyARzynEqRXeXwAOI0ut51qCZrPdnOwspw9Aw==
X-IPAS-Result: =?us-ascii?q?A0EKAAAngcRn/6Mwd6haGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHjE0ggV4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMPAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZW4InAYIwAQEBMQOvK4EygQGCDAEBBoJQ2C8EChoNgTGBIAmBGi4BiE4Bh?=
 =?us-ascii?q?VIZg316JxuCDYJQgi2CH4FrEIQEFoJTgjOBaoM9mgWOWgdhXhwDgW4XEoF2A?=
 =?us-ascii?q?4EPgUVEN4JFaUk6DzeCHoMnhE6DHYF8LwMDAwONABSEQQICg2uDL4I6VAwLb?=
 =?us-ascii?q?T03CC09CEIdEqB1OoQ6BwGBDTAdLmBlCymScYNQAa97C4I/gWaKeJZQTZdTk?=
 =?us-ascii?q?wOIMLRHAYU2YIEOBDKBWXGBbQkLGoEbTwMZD44hhC3II0UyPAIHAQoBAQMJg?=
 =?us-ascii?q?jmNLzSBSwE?=
IronPort-PHdr: A9a23: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
 t/ImuT/JWUamzo71dARA9TZLs6AN3RnPRe7QVbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iFqoiKB6wTvRwqDlHemt55DYdb4zR+YMi2TDGXocdfUzSL3+qy
 nOpoV+6faQslwssR4b9+xoVJPqfZqYz/5ICOoqTNKftWvd2VdARbsKhbcKgQeQeBEWkNQtt5
 uIGJIQNDSfNzVHsfo=
X-Talos-CUID: 9a23:HkdgkG7fm1ggWSP9INssxkkrAfw0Ulzm9X7CIk+YK0xXEuGnRgrF
X-Talos-MUID: 9a23:MGSx6Aa0XI5q7uBTj27vjxJwGOxT+PqpVmwKjYgbl9C1HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743790"
X-MGA-submission: =?us-ascii?q?MDFBfDKb8jpna/j+8PIUt/yqOnKKbjTpZq64b8?=
 =?us-ascii?q?csqSdv9PHWvsNAnM8ILeNkqVXD/Y4tRAGNW0eLWOOgVRj4Ph3EWYLj/q?=
 =?us-ascii?q?SmuY3TWFMxh/0UsQVOfkydhqiWlk4klaayCCUgvSfo2yqRcQmpOKtEhz?=
 =?us-ascii?q?TLWAH4ux6UODxS/sCy5WA5Ew=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:17 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpiJeKuvGtt7uxh2hFS+dsziMi5lwoHgf9YFZ4de7gM=;
	b=k54U/7DdT6xtoAVoeM2idgM1EIL6B5xU5Evn3d7IbnrfCB2uh2H/qmdz55n6qzYx70t3uH
	0p35FZeateL7Ag1b3jOl59aFVU3uNUOoOaGtOoNKxNo3iH9LD7LNawzzrdlfxamMZoAHC1
	T4vS4zw8LYD9l4XzCHBQ9dNgv8JAvXRo428TjONJUaI0xQTyFQMJX+VS52vdyUL23crlYb
	+J4Sv/UqlrVYkluFgPUsjHozs8BE3AiLiM8Q1M8DmCmIduSNhFqN/T0n9qRtUf54yqrNCd
	+sYwCjsV5cLzQ5txbqd95Gy8aMLJSbY4fHiroYyecsj9apwFsLeTUQqV7hOD+w==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Christian Hopps <chopps@labn.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Date: Sun,  2 Mar 2025 17:06:46 +0100
Message-ID: <20250302160657.127253-9-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 10/11] skbuff: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2495
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-9-cgoettsche%40seltendoof.de>

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
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b1c81687e9d8..7ed538e15b56 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1566,7 +1566,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, size_t size)
 	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
 	struct user_struct *user;
 
-	if (capable(CAP_IPC_LOCK) || !size)
+	if (!size || capable(CAP_IPC_LOCK))
 		return 0;
 
 	rlim = rlimit(RLIMIT_MEMLOCK);
-- 
2.47.2

