Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB291D58D6C
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e3xkA6/OPtNWl6A170imeRaHJSFeFAlcMrS6betDjBY=;
  b=C/s5+rQgNoYkdE+mzODUCl36CrNTejTciBC34vs0qt/YB3mdkfSxLEtK
   nTy16RkuJajmGx0S81VhnLzCJA9mWW9c+gFWfplka+23OnbW59NRvTaXJ
   b3OQfR4Ry32AGhdnjJEni+3Bc2c76NMvgRL+yUINeZiLoLYobF8P/TpOq
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724351"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56C0AE0D96; Mon, 25 Nov 2024 17:57:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4B25E013D
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:45 +0100 (CET)
IronPort-SDR: 67445425_HXnIYcRSnUcpJI5v10PUJKdU9OjJAhsgHvkwxHeFVrf2QKY
 aZA+Im3ZMbCEcAC4D0lGbRekuToQ7iAud1rzAWA==
X-IPAS-Result: =?us-ascii?q?A0EhAAC9U0Rn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIw8BDQEBNwEPIAUCGA4CAj0BG?=
 =?us-ascii?q?BmDAYIxAQEBMQOvdIEygQGCDAEBBoJQ2C4EChoNgTCBIAmBGi4BiEsBhVAZg?=
 =?us-ascii?q?316JxuCDYJQgi2CH4FrEHaDDoJpgkSBMYNeJYU3g0mbMwcHYV4cA1khEQFVE?=
 =?us-ascii?q?xcLBwWBdgODRoE2KIEpgxFKhQxGPYJKaU03Ag0CNoIkfYJNhRmDRoEjZS8DA?=
 =?us-ascii?q?wMDghOBK4YGHTcJAwttPTcIDBsGPQhCHRKgG0aDQQcBgQ0wHS5gcCmSboNPA?=
 =?us-ascii?q?a9sC4I/gWWKdpZNTZdRkwCIL5BMo3IBhTVggQc9gVlxggEagRtPAxkPjiGEL?=
 =?us-ascii?q?ccURTI7AgcBCgEBAwmCOY5NNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KIdWO6AeN2HAHE7lHemt55DYdb4zR+YMi2TDGXocdfUzSL3+qy
 nOpoV+6faQslwssR4b9+xoVJPqfZqYz/5ICOoqTNKftWvd2VdARbsKhbcKgQeQeBEWkNQtt5
 uIGJIQNDSfNzVHsfo=
X-Talos-CUID: 9a23:diliyG5dRFT/zr2mrdss0EMxNfsgQlfmi3rePmupIEh0b5mSVgrF
X-Talos-MUID: 9a23:l6mliQYGsYi0yuBTkhm3uB9OG95T/IuDJUVdz5han9vdDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628631"
X-MGA-submission: =?us-ascii?q?MDEu5JyfGe14WSQFrnbAjbWp/0hZdWczwHdJvH?=
 =?us-ascii?q?bwSfzGPF0N7WWe801WccdaWHjJ7QmThEjyL6J3534cB5QwkUTDIUiNDD?=
 =?us-ascii?q?Lkov+czHpTZHMve/YItlo/plnTzAS+5rA77Y2IAx6HlLJNnyhYmasJhQ?=
 =?us-ascii?q?w1NGdQf0p0cPiW1TO/n7Y7ww=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:37 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531236;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3xkA6/OPtNWl6A170imeRaHJSFeFAlcMrS6betDjBY=;
	b=He/Nsu8T8nvfNlUyWxosD+aqdOqwmX/wEHaa2TjwySQRhsy3y5mTIIxk/xGqu/tcDJ5953
	ZnRNBzqyhJWSs4bdvRWugPMdaEsZwP1EY0ud9vuXGWC4i3ViL8z0nnFQIVAsnam3OKt7my
	K2Ca6NHqvTfAEibYKAzLnT1cErwF54vzr0x0gtB5XB/U8Jumi5mAICsd54kb+UqDr39vt6
	jctvGmD/eh545sdjY605727XRkT0xXG6+ZLYPvzo7Bw//DkeQH4/XwiZL3HYSTqumPksvy
	biWPeTD9ZM37zKthExv/H7ZnuC3e8ZPnbE/4hQKbh6oXoC0j3uLMOb2YBU12kA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:40:02 +0100
Message-ID: <20241125104011.36552-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 10/11] skbuff: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2112
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-9-cgoettsche%40seltendoof.de>

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
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..8bf622744862 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1656,7 +1656,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, size_t size)
 	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
 	struct user_struct *user;
 
-	if (capable(CAP_IPC_LOCK) || !size)
+	if (!size || capable(CAP_IPC_LOCK))
 		return 0;
 
 	rlim = rlimit(RLIMIT_MEMLOCK);
-- 
2.45.2

