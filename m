Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD05BC19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t03/rLM9FaNUTzDcuwCiZRSRsDm9yDnbuOT4YqKcuUI=;
  b=fbUsxsTEtY0iowlRxOmZNlURQn+V+Y6pjx0COrd5ODD1sFjOdakj5Ikf
   0mG0ozBEgYncj9yJi+1N+6eYlU9M8ZcbZHqlrlHdT//9Jy2JBVu2u2VdW
   xFJHwwlaVk5aRlag8vKaQ+E4RdtgFo2TYjuoT5AK2dQwGk154TFggqdzo
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210755844"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 21:30:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2543EE0264; Sun,  2 Mar 2025 21:30:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B182E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 21:30:32 +0100 (CET)
IronPort-SDR: 67c4bfe7_n/0PNhWJfOTmJTf3KjleYvs2QEognOhWovxVbSgPTeifKSU
 tAk5/PSKuL78uihJNEftoRk+Be+SlhdUiIqoGLg==
X-IPAS-Result: =?us-ascii?q?A0GMAABnv8RnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYnUzBAtIhFaIHYcygXQtA4Q7hzuMQoQGgVaBfg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVSCdAKLFQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDgkBMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDI?=
 =?us-ascii?q?wQZAQERJgEPHwEFAiYCAksLBgESAgEBgn6CMAEDMQevLn8zgQGCDAEBBtpcH?=
 =?us-ascii?q?ywiV4FlCYEaLgGFa4JjAYVbS4Q8Jw+BVUSBFScLgQmCLYQKhBSCaYQdgz2oW?=
 =?us-ascii?q?IFNHANZLAFVExcLBwWBOTgDIAo0FAQZAhQdDwYQBGp6gkVpSToCDQI1gh4kW?=
 =?us-ascii?q?IIragQFg1uEPYRAgj9RgkKCEXGBF4gCgS2Eah1AAgELbT03BgMLGwY9oW46g?=
 =?us-ascii?q?09yAVI7TDCBepJvsyM0B4I4gWaBYwyfXgYTL5dFDgaSfAEuhXSBcZBqIqkPN?=
 =?us-ascii?q?YEyOoFcMxokgzZPAxkPjiEMFhaDdY8KAbk2QjU8AgcBCgEBAwkBgVWDcAEBi?=
 =?us-ascii?q?iA0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:CWhPba6br6lfdnGfGAPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HIoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhXotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AmjgrmGu5irsP22wQa0TDca2k6IsPYljT50aJf3W?=
 =?us-ascii?q?ISmdYVrTLShi/8q17xp8=3D?=
X-Talos-MUID: 9a23:G3vlZwvUWLC1a//BMM2nuC1bGsY4/pqUS2dWqadXmNGnJS8tEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="110436943"
X-MGA-submission: =?us-ascii?q?MDGrG6EFJaotyrcQ1KMw9yHu1dSb292CpEycng?=
 =?us-ascii?q?1rglUrVw9UHtKxboG6U+vHyz6ric7e2rPalbvu7Gp7R+jYmWIKHVtXFH?=
 =?us-ascii?q?/5BvLL3yAj6xQUCq11y04qwI/N3fIYo1vZOT/+QuHPn0T5pojZdH9dpq?=
 =?us-ascii?q?L71w5G/gX3qfhIiDnzw/2K5A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 21:30:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740947430; x=1741552230; i=markus.elfring@web.de;
	bh=t03/rLM9FaNUTzDcuwCiZRSRsDm9yDnbuOT4YqKcuUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KjHb07zsBfKJpgfl64Y7NEN2CovaV+QPdTEU3U5b8HypgSfj/LY1GmhfBqm1U2Od
	 Q+CZVrXWjRGvt+0Lrq/cmXontkm5Xm/+zgMeotWeBWGITbZrvLNLFD67UfYe4PJfs
	 fXvUutsoj13p4l6Qj/TJ7kx/D9edZWZut4SG/D10Lxosg5nJ4RIt44Jl2vKt3KdZA
	 IJq4hIn1GZEBOJ6d5qHQohUp1Gb4g3zekpuYCy40x0/QeMstPIaVZSpNZjL1XwG1s
	 bVx42f9+UiC/EhWxidBedJ1zceEWKPtdPXqcLwMDHx9UbgyKQubJZx5egdpuOWfWe
	 STH2lqbmZ9c3ZbAbVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1tdb8T1ROh-00Uw3f; Sun, 02
 Mar 2025 21:30:30 +0100
Message-ID: <08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
Date: Sun, 2 Mar 2025 21:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tuong Lien <tuong.t.lien@dektech.com.au>,
 Ying Xue <ying.xue@windriver.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <624fb730-d9de-ba92-1641-f21260b65283@web.de>
Content-Language: en-GB
In-Reply-To: <624fb730-d9de-ba92-1641-f21260b65283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/FibXadHneYGmAU6eIftjav2n1PX9JJV/0o1094/4mzs4YX73ZT
 RGDGo8GNthY0AZ8lx8FIHi6QHRC/guk94wbYT6BXKibSlqnB6AoZviyXW4tvaywOIzIXZfG
 FtG59s7INUZYU+nE6n5o548/Qmj3uN//G2fzNVngxWNNRJcMf1vlVohaGe642J0H90g+28u
 zAFXpRpACnEKLFSZgJY5Q==
UI-OutboundReport: notjunk:1;M01:P0:HfsN25LJsaA=;VIrrRgS4ncXO7iy+hD6iUtBt+bN
 BUe1tb8yhRkBVWsE8D/CuIWzfW1zSZQ0RcExrmpuBHM4ZKOH6lIkq/yYujLP/wAruqJ7eHRiX
 2duxGSXMYciSixYEG73TCtvxMMfKcBsxNKCVM7AVQ9EYgOxKLskUA0ah+LSGhUGPSM8I4vuLz
 Q73MjDowI4jFHWD37W6zC/QfDivAyWPL/sOkKzOleWZ52TkfQTn4smEpidzsQVrfBpIbWeBJ1
 9SFTt3713LPLRXnBA8vglR38wWI20PDlSLqEvMr7uYwt5B/yFhwEO1t5eXps2IvxrnHsvDo7R
 nFuSrcnNJpBCH4WyvpAyr9f6XbumAbgnPQci3RIrGMlX+c4eoea8jK7zQmKYrSGL0xoJEhqB8
 7Z1af6JDSMUKzQkPONBvDm5F5G+Qk+UPbOUso2T55MLzM9pBbOZzSYtxSQOr8ejbnPllGoMd7
 D56PYHHFdkrN4CxTZ0Nt2gHR2RV249BvcRhI/NA7G5xOmwTBzNTDor9fz0d+7oOLLBhiORj0d
 oJwONMxqg4Aqj9clb5R0su7jd8S7MEBaNqjJGWYAEApB4qEsvIo4NjE+oz52KpSvZL12ROjz+
 9CKcuRycUSXcpqaMcHU4FLEwAQKey/XVKNAjwq2at7LnvI8/ADlUuycOXmoWS0X0u5iXl6D1N
 emFVvN8e5bJUmmgGBWCR2TJ3/w71ZmreC16T6t6DVok8zuoEQCunliY8v1uYySa8+ylBXI7Ue
 /b+RpX7oVqRA8Bhp2AXXtuBTstPpzmUmDC3ObfvLpTRLWGqEIDRzbD1+A/0HuRpaYm7eskikZ
 uXek1qEgN/JpUqZit7eZM5y4ts3DMR2Tl6gnGrXtq1WgXaseBwWPUcYkLkCwN+wECm2p+8IB6
 5aBthztPX2MWRYfUDejWEhlkUnCeQXczvy+Z3B9iR1qWJJUNGz0WPHctm7hC1BZaTqvNvXlWy
 g3OcShZigPrxrXXvcT2s2uyamUnHxAHrKjFKHVcPGNG3T/g+UFc5SxDd4Kh9qoksdALBBKOsz
 mzB7qZfPo8zyBydGhe6a60Tn4O2HEZ2PRyKLgfGYqgp99lQpb5J4T5s/oYdF9lb20eu8dykCF
 Q8NBcjX9hbUM3qz9IfaF19KCnuXQVOxecGrscPRbo9wMwWvC4TEjxnAa3+Z+qwbE371MwrMtz
 R/R+A2amH5pWDC+a5zt6BlZGhs6zqlkUVRrRuBJNbnXVsQhVRU1LbURl+j4ij3KVn/Wh8o+YW
 UnPxrN2PL1U7crglFAS/tZzE7RLUjWI1HMlPo1BWDgp8REKeUCZnYpks5PAmFNONZWs6kLBUG
 Y1MSyuzPvwMh3VAUgvlD5zwdgXdrmcv0SNjQsOd+tzGPGLKjSXMr2noo/PVwomcgHonbi3hle
 PN9FR0h276FnYqe0bby0PGGStSD1RqJiu1oQRJfajILkAUsSm0vFCM9F/OJAcSk81Qdb8eX9e
 biNvoqhd3JcmXpE1UQIIRoB4ZPj4=
Subject: [cocci] [PATCH RESEND] tipc: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Cfdefq=E2=80=9D?= in tipc_link_tnl_prepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2472
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/08fe8fc3-19c3-4324-8719-0ee74b0f32c9%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 13 Apr 2023 17:00:11 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ctipc_link_tnl_prepare=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the definition
for the local variable =E2=80=9Cfdefq=E2=80=9D into an if branch at the en=
d.

This issue was detected by using the Coccinelle software.

Fixes: 58ee86b8c775 ("tipc: adapt link failover for new Gap-ACK algorithm"=
)
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index b3ce24823f50..5aa645e3cb35 100644
=2D-- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1973,7 +1973,6 @@ void tipc_link_create_dummy_tnl_msg(struct tipc_link=
 *l,
 void tipc_link_tnl_prepare(struct tipc_link *l, struct tipc_link *tnl,
 			   int mtyp, struct sk_buff_head *xmitq)
 {
-	struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
 	struct sk_buff *skb, *tnlskb;
 	struct tipc_msg *hdr, tnlhdr;
 	struct sk_buff_head *queue =3D &l->transmq;
@@ -2100,6 +2099,8 @@ void tipc_link_tnl_prepare(struct tipc_link *l, stru=
ct tipc_link *tnl,
 	tipc_link_xmit(tnl, &tnlq, xmitq);

 	if (mtyp =3D=3D FAILOVER_MSG) {
+		struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
+
 		tnl->drop_point =3D l->rcv_nxt;
 		tnl->failover_reasm_skb =3D l->reasm_buf;
 		l->reasm_buf =3D NULL;
=2D-
2.40.0

