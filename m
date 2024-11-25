Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2155BD58D6A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7wVOSUhPMHDDdyWhZb1LxKVvZ0vAeRZe7OwxlJZ3FIg=;
  b=pT5pxtoEBxYAcL8aEv+kN63E4H80T2gAk8KYteafsPULi8pPwzEBfr+t
   S2+WyVE+f28pLYWPn2iir1Z5i+4LsZS+coPwP5Z1kti+OIxO6HmV9xIWZ
   djD7saZ4B0HX1CzA215AapKUES/O4yEaN06YVG24/qIx8U+ittU7c8Osw
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
   d="scan'208";a="195724168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3717E0D48; Mon, 25 Nov 2024 17:57:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 51480E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:33 +0100 (CET)
IronPort-SDR: 67445420_3wp3HIOGaik2j4UT/xef2a7FYOdUGr/w8pnbA+KHC+GSdR2
 LWFjuqoVVwHvvmN7ac8mNYvXrl+wjkYRVnr88Cg==
X-IPAS-Result: =?us-ascii?q?A0EhAADMUkRn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3J/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EfYIfgXt2gw6CaYJEgTGDXiWFN4NJmzMHB2FeHANZIREBVRMXC?=
 =?us-ascii?q?wcFgXYDg0aBNiiBKYMRSoUMRj2CSmlNNwINAjaCJH2CTYUZg0aBI2UvAwMDA?=
 =?us-ascii?q?4ITgSuGBh03CQMLbT03CAwbBj0IQh0SoBtGg0EHAYENMB0uYHCTF4NQr2wLg?=
 =?us-ascii?q?j+BZYp2lk1Nl1GTAIgvkEyjcgGFNWCBBz2BWXGCARqBG08DGQ+OIYQtxxBFM?=
 =?us-ascii?q?jsCBwEKAQEDCYI5jk00gUsBAQ?=
IronPort-PHdr: A9a23:KPC/ZRXVCRdqM+tBGawqoc5sUqvV8KwKXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtydt68P0rSe8/i5HzBbudDZ6DFKWacPfiFGoP1VpTBoONSCB0z/IayiRA0BN
 +MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj5ZuJrw+xxbJrXdEZuVbzn5sKV6Pghrw/Mi98ZB//yhKp/4t68tMWrjmcqolS
 rBVEDspP2cp6cPxshXNURWB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw7Viis4
 KltSB/zlScILCU5/33Nisxxl61UvhSsrAFizoHOYYGVMP1+fr7Bfd4fWGFMUNpdWzBHD4ihd
 IYEEfYPMvhEoIn8v1sOrAWxBQ+wBOP01zREgmb60bAm3+g9FA3L2hErEdATv3TOtNj7NLkcX
 P6owqfGzjvMbf1W2S3y54fUfR4suu2MULFqfMbN1UUjCwHIg1ONooLlJTOV0eENvnCF4upgT
 +KvinUnqx1woje1wMcnl4jHnoQJylDY7iV23IY1KsOlQ0N8fdGkH5xQuD+GN4tqWcMtX2Fot
 zghx70dp5G7eDQKx4ohxxHCbPyHdIaI7gj+W+mPODp1gm9ud72jiRio60eg1vH8Wdeu0FZMt
 idLnNfBu3ED2hDN5caLVuZw8Eiv1DuM1w7e6v9JLV4pmKfaK5AvwqI9m5oOvEnDHCL7nFn6g
 qGWe0sq5OSk9vjrb7P7rZGfL495khzyP6Utl8ClHOg0LwwDU3KU9Om/zrHv4Ez0TbtMg/Yrj
 KTZtI3aJd8HpqGnGQ9bz4cj6hehADq+ztgVm2QMIkhfdxKdlYfpPknDIPDmAve7hFShiCxry
 O7cPr3/HJrNNGTPnKn7cbZm9UFczBYzws5Z551JDbEBJ/zzVlXsu9PGFhM5Mgq0zPj7CNhly
 48TWGGCDrWEPK/PtVKE/O0iLuqWaIMIuTvwJeAp5/v0gn84nV8dc7Op3ZwSaH2gAvtmLEKZb
 mTwgtcdCmcFogo+Q/LxhV2ZTzFTY2qyULw65j4mD4KmConDSpqwj7OfxCu7GIZZaXhcCl+QC
 Xfoa5mEW/AUZS6MOsNhiCALVaC9S4890hGjrAv6xKBpL+XO/i0YsYnu1dl05+3Wjh4y7yZ7A
 96c02GLVWF0n3kHSyU43KBluUB90EuM0bBkg/xEEtxe/+9GUgAmOpHAzux3EMvyWwLEfteRU
 lmqWNSmATcrTtIw2dACeUh9G8/xxizEii6rBaIF0qeGD4Eu877Nmn32K9t5xl7Y26Q7yVorW
 M1CMSuhnKEszQXLA5/1lBCSmLStc6kH9CHK82iHwG+HvUUeWwl1AovfWnVKTUvMrM/l50rEB
 5AwFag8OQtMgZqJJaxHdsHyhlVLbOzuPMjTZW62nGn2CRveleDEV5bjZ2hIhHaVM0MDiQ1Gu
 C/ebWDWZw+kqmPaV3l1EE73Jljr6a94oW+6SUk9y0eLaVdg3vy74E1dnuSSHtUU2L9MoyI9s
 3NsBl/o1N3RBsacvAFhcY1HbNch7VFL0mXX8QBwbdS7N643vlcFaExsul/2kRB+C4FOi88v+
 XglywduNbmT0F5pbD6cwZ32NrrQJC/+8UPncLbYj3fZ1tve4aIT8LI4plHk6RmuDVYn+m573
 sN9yHaG+JjQVFBUSp/1Tksx+x99qffWb0HR/qvy0ntheemxuz7GgJcyAfc9jw2nZ5FZOb+FE
 wn7F4sbAdKvIaokgQrhaBVMJ+1U+KMuWqHuP/KbxK6mOvphlzO6nCxG5o56yEeF6yt7TKbBw
 Z8Ex/iS2gbPWS37iR+ttcX+mIYMYj93fCL3wifjCZJNfaZycK4QBGOyLsu7wdJwwZLgGjZZ+
 FOlG1IayZqxYxPBCj61lQZU1EkRvTmmgX7hkWwyymh46PbPmnWQmLeHFlJPIGNASWh8gE25J
 IG1i4tfR020d00ykwPj40/mxq9draA5Lm/JQE4OcTKlSgMqGqa2qLeGZNZCrZ0ytiACGu+zZ
 l2GVqX2oxYyyC7nA2ZYyDc8eXemt9+q+n4ywHLYN3t1oHfDLIt7yhDS+MDHTv5c9iELQDV1j
 zXQAVb6M9TjrrD239/T9+u5UWymTJhadyLmmJiBuCWM7mpvGRSjnvq3l7ULCCAC2DTgn5lvX
 CTM91PnZ5Xzkr+9KaRhd1VpA1n174x7HJt/m80+nsNY1X8fj5STtX0J9AW7ed5U3q/icGEGR
 TMj2NPR/AXj1EpkIDSFysr1W26czc1oe9ShKjpIimRktpEMVPfSteIf1SJuxzjw5Rrce/18g
 isQxbM15XgWjvtI8AshwyOBA6wDSExRPCjijRONvLXc5O1cYGeid6T11VIrxI7xSujb80cAC
 DCgJMxxeE04pt9yO1/NznDpv4Tted2LKMkWqgXRiBDYye5cNJM2kPMOwythI2P0+3M/mItZx
 VRj24+3uI+fJiBj5qW8V1RTOTr4e98I8THgpb1Tmtqb2YyoGZsnFjhBD/6KBbq4VSkfs/jqL
 VPEGzI7p2uHArHfECeE5UN6onTDFJelcX2abip8r50qVFyWI0pRhxoRVTMxk8siFwyk88fmd
 V9w+jEb4lOr4gsJ0O9jMAPzF3vOvAr9IClhU4CRdVAFi2MKr1eQK8GV6fh/Wj1V7oH05hLYM
 XSVPkxNHSlMU0iATTgPJ5GI4t/Nu6idD+u6dL7VZKmW7PdZT7GOzI6u1Y1v+3CNMN+ONz9sF
 a9z3E0LRn1/F8nD/ldHAyUKiyLAadKarxag62V2qM646vHiRAPo48OGFbJTNdxl/x3+j72EM
 qacgyNwKDAQ0Z1ppzeA0L8EwFsbkD1jbRG2HK4euDSVFuTLl6tLAhgXbCR9csdFruo90gRLJ
 c/Hm4b127p/3ZtXQx9OUV3snN3sZNRfej/tcgqeVQDXZPLfe2aYpqO/KbmxQrBRkuhO4hi5u
 DLAVlTmIizGjD7xERamLeBLiiifeh1YooC0NBh3Wg2BBJrrbAO2NNhvgHg427ox0znBOmkRL
 SRneENAhqad6T9VhPl4HGIH4ncvfozm026JqvLVLJobq64hGiNvi+dT+2g30ZNO4TtaSeYtw
 m3Jo9pyrleqle6BjDZqGkkryH4DlMeAukNsPr/c/59LVCPf/R4D2m6XDgwDu9pvDtCHU0F40
 dXViq/pcG0E6N/Q4cYaC8/TJoSLPSh5WfIGMCXZCBcISzKsMm+Zi0EPyZl6E1WOo5wmp57gn
 50ADLNWBgRdKw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SSgSlKzyEZOpBufzjkzZKrPwLb1zdoMgy1knxilNoNJuHvBw8P
 re+8jztCWE7Ar5PUtLpTnuAse9qB/nnqKdpLNwAV7AZniChILLFuBfBOLZqlXd8m/Fh41gPM
 FbAspD4bbLYmSS4/yW3DWF
X-Talos-CUID: 9a23:rr+OTWOARwwRkO5DchBc0GUMBNwfLV7n8Vf+ERKJO3dzV+jA
X-Talos-MUID: 9a23:KTleGwXhbpSRaYrq/Ce8nRFPP9dw2KSJNXoSrLUCkPOVFRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102546525"
X-MGA-submission: =?us-ascii?q?MDFmQR61IwUkK57HbatbrxKg6i0PuzGuMFTiML?=
 =?us-ascii?q?ApfKauSS1yTh/ZjNx5gpCEJHJkNLROD3TQztDVSSSfByDEGY2y8ZWwjX?=
 =?us-ascii?q?UfsPHUvrxG/u5x3dMliJnV2JfpIPKsyYLZM9z9Keev5cHRqpdvYUOdt+?=
 =?us-ascii?q?xYqhgvwM4s1sXPm15d+1yLFw=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:32 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531232;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wVOSUhPMHDDdyWhZb1LxKVvZ0vAeRZe7OwxlJZ3FIg=;
	b=E5uuCsWLjd+f5UuRf0P4XipqTBXRFNmMzjfboQYwQD7a/vLFsAnUw1bZ56W3QjCp1wdjVM
	OQqtKYGM/yAjFf3k+3k1jtPdsniFUNb11UryVGQwNUTop3xUf7ZVrtrQIjGWtilvfkdwKr
	f5CG7nKKLyLEXJFWK+BEEtF1j1ADNYhVn9diBKye0NPtrUUqKFn0jTJ5XhnaMFybt60XFV
	uhN5+nVRzW98zFouj+AP1ej6JEOdLWJAVW5VkO4tgX3YPw80iAP6cfcRI6i4Iann0ici2p
	95U/wJpEbE+4mWtxePvaBHXM6KM6ysgwRRr0AE5h1TyAgH1Xmd3ufqAcedwbtQ==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:59 +0100
Message-ID: <20241125104011.36552-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 07/11] ipv4: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2106
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-6-cgoettsche%40seltendoof.de>

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
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..bd3d7a3d6655 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3406,8 +3406,8 @@ EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
-	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
-		(sk->sk_state != TCP_LISTEN);
+	return (sk->sk_state != TCP_LISTEN) &&
+	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 }
 
 static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
-- 
2.45.2

