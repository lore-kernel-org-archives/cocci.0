Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90684C282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ci2qYk+Y1xa6/y45CJ+sIl/Sp1TENvs4r3jA8ONoz3c=;
  b=jaWuoE6XIkiGDMhQxw1iaMBE5FLag1cm5iTbbrETzbNJAmhOIRTMf5rt
   i2f3A5AJBTfJ7+VzXHWxhGkIY7xdaRfLpkZhhV0pRA3F8cbmm4jmRg/Iq
   np1qmp34L73GdfFIjAH0QXqoFHiE9Ynq+uAa/fhDyQ3DHD6gIM8dATkjQ
   M=;
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
   d="scan'208";a="211067976"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39ABCE0D5B; Tue,  4 Mar 2025 10:58:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F28E4E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:13 +0100 (CET)
IronPort-SDR: 67c48231_NnYlRrRUbBx05SAaNUTP7xJFiulz1DkGpi+42IA/VDD50Da
 2+qa1LmonVnlvtLNeN08q1GEQl0L8uRcapgWJkw==
X-IPAS-Result: =?us-ascii?q?A0EFAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUADAQEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHj?=
 =?us-ascii?q?E0ggV4PAQMBDUQEAQEDAQOFAAKLFQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gB?=
 =?us-ascii?q?QIYDgICPQEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJg?=
 =?us-ascii?q?RouAYhOAYVSGYN9eicbgg2EfYIfgXuEBBaCU4IzgWqDPZoFjloHYV4cA4FuF?=
 =?us-ascii?q?xKBdgOBD4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DAwMDjQAUhEECAoNrgy+CO?=
 =?us-ascii?q?lQMC209NwgtPQhCHRKgdTqEOgcBgQ0wHS5gZQuTGoNRr3sLgj+BZop4llBNl?=
 =?us-ascii?q?1OTA4gwtEcBhTZggQkDOIFZcYFtCQsagRtPAxkPjiGELcgjRTI8AgcBCgEBA?=
 =?us-ascii?q?wmCOY0vNIFLAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2TxNMak0catZ+/H04ilFNOQ34LbpDfIN3DAbv31ZSRFFG/Fw9v
 re/sjzuiWZtN98Yh4dcLO7Scq9qBHnlKKdiLN5VdzJMTUO0FHYSb2KhrGD/9SPIUPDHiQ079
 YFT0C8YOeAamST96zBkXCF+41L+qj+zEjt7t2uskuEiGlRGsddB8MQMHfhLqWwLDM2f6YEKA
 ==
X-Talos-CUID: 9a23:MvxmkWNG7czPSu5DXSh89V4bQvAZYlr90UmMf1GSBU9wcejA
X-Talos-MUID: =?us-ascii?q?9a23=3A8bPA8A1k2dnNmgo/Rqq6aGjIYjUj/pyHAhlSyrQ?=
 =?us-ascii?q?/ltCCPyhyGSXGoWvsTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110429642"
X-MGA-submission: =?us-ascii?q?MDGchWwa1lZ/kzqIbQSTl/+YVTD0hrGDOcZnT4?=
 =?us-ascii?q?7QZneuKLgAtYkCwlrC2rw5DxWB6UK01AwnyFPabOE/sxn7j3Xto0AV/U?=
 =?us-ascii?q?A7Md0YeqSus9kSW2dYwzoLjG0hSpxb7Yb07Qef7Hcn44HsLwQLdSPZOs?=
 =?us-ascii?q?4bM2FUeF6c6hPcZtX3jIGp9Q=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:13 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931632;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci2qYk+Y1xa6/y45CJ+sIl/Sp1TENvs4r3jA8ONoz3c=;
	b=dUvVRk5rsMES5GBkWhhKkXaw+xPN53mb+fYciIN3XGf5bDpEl7+9mczP3DBrL1InukvxKK
	b0dTreVkc3Zxdv3jDxO5zcTH1n9l8R9sY5BXlcHTtL8khofEs3ILoWQMspSNMue63EzBYU
	+YwZiQJDnQ+1PVyao3dSz3wGNpQEGWeTOgQcaAP1oVgJcWFaFgGeQO1jXp4uy79BtzcCuu
	6U7B98CQ1jWs+w8FVp+HATHqVbw91duaAg8CJoUC8yHNZfQi5bJ30eFRU3jYSb299OwaC6
	Um4+yVux8blZva5BIDm9YuDZQt9EsTVae9ZKAG2GSDJZptbEionJH8VsaJnOeg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Date: Sun,  2 Mar 2025 17:06:44 +0100
Message-ID: <20250302160657.127253-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 08/11] ipv4: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2493
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-7-cgoettsche%40seltendoof.de>

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
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 57df7c1d2faa..9828bc5712b7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3419,8 +3419,8 @@ EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
-	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
-		(sk->sk_state != TCP_LISTEN);
+	return (sk->sk_state != TCP_LISTEN) &&
+	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 }
 
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
-- 
2.47.2

