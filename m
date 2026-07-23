Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F86C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gvjX2o7DFFzayFyUFs0i0LzhZ1PMgAv+++MqFVj9d/o=;
  b=tbRVcdyJmYdMAdQ1SD9fa4JE3WOjT8kTXtKqxooz33DrzgT429prBcmp
   XbdlU1rSs1CrDJBZGHChEEkEAa982jo98tXdavrqh1GpCDeskCdmxvyrU
   KY5yNRQYP2GO94nA4g7hYxVOdPaRSIgGa1MAdarbCp0BQpX+OYFs+UrBR
   o=;
X-CSE-ConnectionGUID: PWuFjG5aRLGlQobY5FId+Q==
X-CSE-MsgGUID: mIZxcRl6QkST+BrMvQobHA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733386"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:07 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 779FB803D8; Fri, 24 Jul 2026 10:54:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C8A8C81331
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:29 +0200 (CEST)
X-CSE-ConnectionGUID: XR9Lww7kQLeO2FngcK2gDg==
X-CSE-MsgGUID: gavNxCsVQre2ta+gLWfiSg==
IronPort-SDR: 6a626185_0wciBQBMqnm+1TjFRxptrIMag8qojFVbM+Dj8zqZvQNJ9sZ
 Ar5cSqu3Lj+Vn7y5db0tjS1FSAnhAOMtVQAYoMg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfDbYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEiABDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMUgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQgRWDaYIfgjmGMASDLpIqAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMgC?=
 =?us-ascii?q?gsSDwMNBgUVAQEHBgICAwEEAgQMAgQFAgIFAwEDAgQGBAMDBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCI?=
 =?us-ascii?q?QQdEQgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkID?=
 =?us-ascii?q?BcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFA?=
 =?us-ascii?q?gIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDB?=
 =?us-ascii?q?AECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDF?=
 =?us-ascii?q?gYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwoCAgYDAwMCAwMFAwMHAgQCAwYDA?=
 =?us-ascii?q?wMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFA?=
 =?us-ascii?q?wMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGA?=
 =?us-ascii?q?gMEBQUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDB?=
 =?us-ascii?q?wMDAwMDBAMFBQMCBQIEAwUDBwIDAwIBBQMBAwIBAQQFBAoBAwMDAwUFAwICA?=
 =?us-ascii?q?wMEAQIEBgMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDB?=
 =?us-ascii?q?QIJAwMJAwMLAgIDIQIFAQIDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFA?=
 =?us-ascii?q?wYBAwIBAwMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABg?=
 =?us-ascii?q?Q2CFBU2gRsBAQGkTqAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCXB?=
 =?us-ascii?q?QIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD5Ijjz0BvFc1NT4BBwIHDwKBc4N2i?=
 =?us-ascii?q?SqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 bnTq0khh//RBL8L
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:d86ZJatj7c2eAybUWKEoq4ZK7skDUtV00zEX/kB9WHVpmwKj5q
 WTdZMgpGLJYVMqMk3I9urwX5VoLUmslqKdpLNhRYtKPzOWwldATrsSi7cKqgeIc0afygce79
 YaT0EXMrzN5DNB/KLHCWeDYrQd6ejC3qTtq+m29RhQpMJRB52ILT0VNu/iKDwOeOCOP/QEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3AQyqyAWvnNsNemVOAdQKEit176IsVSCz502iPIHa?=
 =?us-ascii?q?cBEEzZruaQnzK949rxp8=3D?=
X-Talos-MUID: 9a23:feCgZguMWBVkrHGXjs2nizh8EtdD+JqXEk1XjZxFtO27Oy1LNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815264"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGH9YRLChlAK2Oq8e1b6p1oNIkiZ8sUu/xl1R?=
 =?us-ascii?q?lSHTqRzG0B2sgmkZmYg80qIfGqOyGURBL3JO6U7DZf1PZcG29la6KJva?=
 =?us-ascii?q?20amyqMrUSV0IJ73HTJ0r8Oxx9M3N82eR4IbpfbwoHri2CcoQ+I/R4cv?=
 =?us-ascii?q?JC6ki9bCY2mUP9xLlj/cZ/yg=3D=3D?=
Received: from mail-pj1-f54.google.com ([209.85.216.54])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:29 +0200
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso809023a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832387; x=1785437187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvjX2o7DFFzayFyUFs0i0LzhZ1PMgAv+++MqFVj9d/o=;
        b=p9qS7H9XFaIKmEx10luhJcjJCL+ucms/iozYUp+Wf3/c/j3OAOm5XPNvHNaELPOHDg
         bkK8hrSW82147uSPLuPEwWt6PdPXB5somRzBBmNF9FWv7onhxrL+OEteLGTJ8ebUTT2L
         sqVuAg4STB4uQLqWUNMa/X4uX1hM2MtJeVD3XHJHJWe/dniE8w+impLJ9o5wP4hmZ03k
         al4hFZrSIFFBDpc6lgm7Qz9O9RtSLhOdy9WO/p+SxL8t41dIpeFYS1T4bjmBwBpTbJWP
         mm5zjh5uI3yjt0zqHKINitseU3KSnciO7UvKc8y5SmmKmOta8IGr12Ew5ru/a+7yHu0J
         fIRQ==
X-Gm-Message-State: AOJu0YwdgdyhQ2rPlY09VLiV+v7IEK30QhIqG9xwno4CXJPgap8lXTLU
	ssODUNnKLYEJ08rmyK8Cw1wv+7yMP25Ug5E3uJX5Y4CA7nn4lPYOcIdD
X-Gm-Gg: AR+sD138LDTNqHl7GFrFQQezaOso/R8a7QbGRR/iNddC9tUB1qdZlD6sMfCv+igTeYP
	44h/q1iFuhaJd89Mt1DiVqGHPznYnPK+9gNXoIgT1ZudXgwLJhSCEgILii+fOhaeLavYkKm9rX7
	nLeESK/qKqPRhKXdjkuqZfWcxHCEBOH4AJ3ORWZ2PTBCse6D3jFBsdyAM6aMZteycg2vZClxSQj
	ud2ELeho4caBr37FG9VRwJBAyaufVBynRPxjS5F2bpXPMl1k2oolUoMFzxsp11W7W6Hy/IZXeGK
	RU/7Q7yftB9mBl+XqCpT13x7RXZgjjCbea7jlT7fhkB/WA2SL+BSghOZ6aINbJRvxONBn7iojdV
	H/gpsHwAlOZvt+OdOH/ssHPu07L4RHf17wM3iJpY3VFm9z+E9qgjkGRYXFdHP+RUj1V1aWFRLFK
	9c8o5CmJ8=
X-Received: by 2002:a17:90b:3ccf:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-38ec6a5115dmr4284232a91.25.1784832387385;
        Thu, 23 Jul 2026 11:46:27 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:26 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: cocci@inria.fr,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>
Date: Fri, 24 Jul 2026 03:45:13 +0900
Message-ID: <20260723184538.3888637-12-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 11/36] ipvs: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3608
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/lhSWAWxaDAlwc5aEsEUx5w>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 net/netfilter/ipvs/ip_vs_sync.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 93038abbf5e0..bd4f7e906cf7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1603,15 +1603,10 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 {
 	struct msghdr		msg = {NULL,};
 	struct kvec		iov = {buffer, buflen};
-	int			len;
 
 	/* Receive a packet */
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, buflen);
-	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
-	if (len < 0)
-		return len;
-
-	return len;
+	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
 /* Wakeup the master thread for sending */
-- 
2.43.0

