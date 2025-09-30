Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB27CCA470
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xi9GiPTBBhlYeNFPNwd77JG6ckuL4jiUtpxRsGJ2sSU=;
  b=YJoOXN2V1xPCC4ACkN/jt/g8Ox84pKJYAShHobDljGO5XXZqOIY3SgA7
   zSCbwtzicPpHlyp+ha6LT2Pi46J3QUK2CrnBZ6Q+L8c2xc+je6BwFbfHy
   DTXAYVy6BeBXHDZw1ix406Ocgs7E2bbGA8LH48/+q3ZHQMIetJUELyf0K
   o=;
X-CSE-ConnectionGUID: 0O/QQhKtSTSXUtlCL7TP5Q==
X-CSE-MsgGUID: 1mazV9eBQpKChL50VRJNDg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241840898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:37:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C9DFE0CD5; Tue, 30 Sep 2025 19:37:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 57058E0172
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:37:18 +0200 (CEST)
X-CSE-ConnectionGUID: hJWV40KpT5+1YXe5VkDhtg==
X-CSE-MsgGUID: utqOukaATbCgBiRNC18Jlw==
IronPort-SDR: 68dc154d_s0Ta+LXyC1Z/qJ7xgoAfH/hrIk0L68j+U8Iva6BNbgzqLVq
 UnVMe8VX9Jjl5rdHc5scHZKz+vMAdmM12VHkVCA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EIAADtE9xogA4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/ZR0GVDMEC0kEhFGIHIc0giSEO?=
 =?us-ascii?q?48RiHmBVYF9Ag8BAwENRAoBAgQBAQMEOIRIAoxGAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINOkQCAQMjHQEBESYBDx8BBQIfBwICVgYBEgIBAYJ+A?=
 =?us-ascii?q?YIiAQYQAQM1Bw25ZIEygQGCDAEBBtpfHywiWYFkAwaBGy4BhWyCZAGFXBA7h?=
 =?us-ascii?q?DwnD4FVRIE8C4EJgi2ECoQUgmmDPJAxfY4ZgUocA1ksAVUTFwsHBYEwMwMgC?=
 =?us-ascii?q?jQxAhQdEg8EFjIdcwwoEoNsgQ2EHitPhA50PlqDUyRrDwaBFYEbgkAFAYlLI?=
 =?us-ascii?q?A+BDQIBC209NwYDCxsGPZh4g0aBDiyCSpZEAa9rNAeCOIFngWQMii6VPgYTL?=
 =?us-ascii?q?5dSDgaTBS6HZZBzIotsgXqbOTaBMjqBXDMaJIM2TwMZD44hPoN1hGCKKgG5I?=
 =?us-ascii?q?0E1AjoCBwEKAQEDCQGBVYNwAQGMIjSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LO4Wmq70FKwxt6zSjwPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:g7NRB28GZ01zSCOmtMqVv042Jf55Kl7F8CqTen6IBDtXS5GVVVDFrQ==
X-Talos-MUID: 9a23:nEZg1gQcpP+OxXrXRXTxmChFKcRhypikI08nkK8gkJDUFyhvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126969166"
X-MGA-submission: =?us-ascii?q?MDFHRW4PbOvwLYg/dB/FaprNAje3V/9aD/UXoc?=
 =?us-ascii?q?5ed9lsbeWvpiC5IRrd2t6QGyTDBGyYtAdh0bTuUG2aASCGMijA9m2lo3?=
 =?us-ascii?q?8UWJn0u9FW3UufyIVXNAnW41GHJvnfWTL6MfcYTUDE2iQDZ8EKXAK0py?=
 =?us-ascii?q?aOZuT5iVtta9kQtkm1pyjHbA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:37:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253827; x=1759858627; i=markus.elfring@web.de;
	bh=xi9GiPTBBhlYeNFPNwd77JG6ckuL4jiUtpxRsGJ2sSU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dhwQgOzJufI2+MXbLeOkKGQ5Z7k5FXzJDcAI0tQ3gHLvoA2qjQP+sDwO5raLqHGL
	 enGtd5L0fIamT0ZH90wy2QNY2byloReQDuQ0Mb75r1vyifgEYLAcB1HNgpSqntCzL
	 cYiK8C7nGr+hlNFxSicKwt9aiYyhi5qbH7pO0eCRpzW7Q6pjV4WHAmXdkRInY5yPj
	 oaPgel/Qez5mQnMJ0HrCFLK0B6WwUosKuYC7RCIVZCxdqEieQDWQJYjXq7Mvf2Fvu
	 CuZt3SLNF7xDOZLWXxIdCj/Bmr/u9i6gs5S8NMFpYTHqVORaLifW6R4H635qnYzdV
	 enIV5eaZYDpX64Q14A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1uNysl0XCi-00fgBI; Tue, 30
 Sep 2025 19:37:07 +0200
Message-ID: <b411c283-9430-4949-a6ee-bb8ea9febcaf@web.de>
Date: Tue, 30 Sep 2025 19:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k3EkLB9qu2BOQA23380kZ7XhRGtFs1YYkOodspawFefJo1Ntc8N
 myySCEgLm9+wUVNp62zrGBBf+JkOAGl5AkVnCP8LdzGJLc8iA2F5CBbkQJtieTzAEOBUEST
 UsEdtvGuSW4Va0/oRZD2bIHPUfQ22z1hR8PQ5E8A8D7N44xovchqBytD1IPHnIOrOqqsg4B
 RmFCng8CIF7YuReFz9hBg==
UI-OutboundReport: notjunk:1;M01:P0:WuT2TIEqz0Y=;fXUEds/GG7BzIL1Iet6Jxjs0msW
 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
Subject: [cocci] [PATCH 3/6] Coccinelle: ptr_err_to_pe: Restrict the
 metavariable type =?UTF-8?Q?=E2=80=9Cconstant=E2=80=9D?= for the usage of
 string literals
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3059
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b411c283-9430-4949-a6ee-bb8ea9febcaf%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:28:20 +0200

Refine the metavariable type =E2=80=9Cconstant=E2=80=9D with =E2=80=9Cchar=
[]=E2=80=9D so that only
string literals should be found for the desired source code search.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 26888d2c9c83..fb4b5bf91081 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -14,7 +14,7 @@ virtual context, report, org
=20
 @r@
 expression ptr;
-constant fmt;
+constant char[] fmt;
 position p;
 identifier print_func;
 @@
=2D-=20
2.51.0


