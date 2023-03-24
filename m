Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5971FC77B60
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pe04eX6ghcqGxUBXdtQKHGYj2PRSTMDRLiwE95GX5uo=;
  b=dkw3DBCK6n+1doBUU3ZqjFgGXWQ1l3m4c0XNwWtAv+ZIpB7KMCI4thK9
   tpulx3GeSFHdDhYcizAS/Fae5tmPRDAbpC95wZsBV+yx6cLjzFxfoqDgn
   8M4/I+PPNx9gAlZ96jVd0SHhuh88xidzE39A6XIg1EIPeHyWLEnyOwZo3
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98954547"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 15:13:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 10C52E0D44; Fri, 24 Mar 2023 15:13:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B703EE0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 15:13:13 +0100 (CET)
IronPort-SDR: 641daff8_n5vjz6ImcR4oY8AwtoziGGtPHgZ+iaefHODgHsjUJKjHL71
 h7xhnCYEAwgLaYUzBICfsR7EjQh0gYgq5jpKtPQ==
X-IPAS-Result: =?us-ascii?q?A0FaAwD9rh1khk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoQWPZEBLgOEL4csjCGEAoMWPg8BAwENQQECBAEBAwQ4gVOCc?=
 =?us-ascii?q?wKFOgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABA?=
 =?us-ascii?q?QEYCRkHDgULBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAwwXBBkBAREmAQ8JFgYCJgICVwYBDAYCAQGCeoIoAQMxB5ZDnBd/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULY0FhDAnD4FVRIEVJ4EVgiyIHIJngiqHV?=
 =?us-ascii?q?ocGiCwKgTR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZAsOb4FLAmRMaSUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyEGWGsCCSMREwUDCxUqRwQIOQYaNBECCA8SDyxDDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwSBCoEBBgEmJJpKAgGCaAFSO0wmggSSWBGSL54ONAeCK?=
 =?us-ascii?q?IFVgVkMnwwGEy6XCA4GkiIBLoctkA8gp3qBeiOBXDMaJIM2TwMZD44gDA0Jh?=
 =?us-ascii?q?AOPCQE9QDQ7AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H0E+EKvoAgClmRqVjQQ6b2U07skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="51161745"
X-MGA-submission: =?us-ascii?q?MDGOgEOyhkK3l9e3Zn4Wyc7Ws8YAJI23OQ4pmt?=
 =?us-ascii?q?HBlCzOcS6k5nzB7mYS1Nk5WOKfHmvR0zPGaUJoo1rdbk5sAMbru2rjZm?=
 =?us-ascii?q?lWKs8/Eg6DyDR2Ljv7cPsclWRGhVoC44s78InJCwXv9o1hn5caAwgcqA?=
 =?us-ascii?q?4LngylkfGd5e5xbq/ahpj21w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:13:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679667181; i=markus.elfring@web.de;
	bh=Y+ebYWXehNhLXVkR/6mPSDQ26sWtO+Kl2j6g0Q8WPRk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=OOKNX47zp6io5EUwyNYjcudezNCvvfYHFA6JAcB7oeYxE/0JznErU4vC7hr7mcSLI
	 Mrf+A2NpaDWRO1caacTmzNh2UiQY7sfAUjn7teBjj6XC2+VefOWMPjNM9jTDA3KkEc
	 JEbFkOqOVapEL5gtXSVk4awQCocA3VXOotaRi5/krbsZOVwxlldum8jPGZwWOmiSfO
	 7d8D20o5XS22VqgpcSSspKf068GebL5WyW/QZDugbyWzQfeNyQEYcRn6/h6qRittQV
	 GAL45ySqJt+1iEs+ON5Ei3hW+fJXT7vcLcC2/zdMIMaF5lnhkLMvCn5dRQFSurCuhk
	 ygz39+O72jOxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1pxeO73tMh-00IJJG; Fri, 24
 Mar 2023 15:13:01 +0100
Message-ID: <9e0a7e6c-484d-92e0-ddf9-6e541403327e@web.de>
Date: Fri, 24 Mar 2023 15:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i7fXMMLD5inTuOQlxjYrOYaMWHcnmdVsGGhnrL91J9Hh0GiW8K5
 CfWEhEtq7x2BJN4Lx5RQgNyEg5/uonLSAB5Xh+MzloLOdfdmGRiUURk6qkNdsOSylQJaoks
 eycVqIC3fhgjkHIye4MShiPZPf4jgf9Y49cWJmy7J9GqHUzN/Q/sC2128aDJGXGbeUYZ+5o
 zD2tuubkkbYsoKzWiphEg==
UI-OutboundReport: notjunk:1;M01:P0:yagQpoapld8=;X//uwNuoMVP3BZExYXPQxKKvFkA
 tHP/MNngbGl79AWnwEuIRu4blXmsDmihQLtNYwV/tD4Za1mmVxV/6O4kZrUBH5PEKbSdYqwZv
 8i4A7sANGxREk1RuDnOT1Rwf58bBzHDJB0lD1QGf3fnMArcfUX0npkskoyB11gqVKLOe2gaKC
 t8CJ+zd5SZG3GFTR/ACArpzIY3OM/28dBMKZDEj/xX7thWXH1Sohzv5PS6pys0HRDHn6xwQQR
 9pIIFSadjV3efYs7gYIFOvVlTAihBZDIAuKPnBGUn3bGT73e8GexBGUZbqKEjyc2jXx8GfTlZ
 9SrzBgKvd1yjZuncYA3nVtDE+RkeEfILoiobB/K0/HaP0yGeC+oL+vUoq0xHS8vy1sbGbsZET
 C4Ej9dKeoBTPBk6tgMG3MAXqEAH9RIAQ0BAiuyZs4/tB1HBoBeAY83zLo/2acvNa1IIuEUaP8
 /NTiNKJWEWsBhatW3hZTERpCIHS3kps9uttXidnilbUCWBfwVuGJwu0J7wjXLGrI/MK+X92Rd
 50CLIEplCXGE1fgvFzwZK3UkYO2hDXOkoYt6SKGYaa9LjzU9w+uApr12DV0Ff69lfq6qLrj78
 KIUQMBJUXnSAXRW8Hgm5C/U9RvggdYlVU52jVvcn9MqTSEn4631QalzK1pTXSxlf+UIGqCa/H
 pBNXI/algYjm3xM2BKWOS0xbbKaUWDk921rz7MAjQPj9z90I8KqkrKqH/VX4rIs8KJ3NHqyhj
 kIB6HCqkwZUQBYwLQt7RBCYsC0xRKnccBrTrGem3tEhj17/sN9qLuwOdQur3rwUhTvbmLuxfL
 fyD8oHVRgwRf+bd5577crGi+UfC7zH4ItIMp9P4alOMP0K8nwgFPh9ozg+dGX/am0xPM2Jiz6
 c/FJ5SkGicebl9JYJkYuO2+nAYGs5ANwaNQe48DlG+vEuwUx9yF+sr4Vd
Subject: [cocci] [PATCH] selftests/bpf: Improve exception handling in
 rbtree_add_and_remove()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 916
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/9e0a7e6c-484d-92e0-ddf9-6e541403327e%40web.de>

Date: Fri, 24 Mar 2023 14:54:18 +0100

The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Crbtree_add_and_r=
emove=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

1. Thus return directly after the first call of the function
   =E2=80=9Cbpf_obj_new=E2=80=9D failed.

2. Delete two questionable checks.

3. Omit an extra initialisation (for the variable =E2=80=9Cm=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 215249f6adc0359e3546829e7ee622b5e309b0ad ("selftests/bpf: Add rbtre=
e selftests")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/testing/selftests/bpf/progs/rbtree.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/se=
lftests/bpf/progs/rbtree.c
index 4c90aa6abddd..9b6a65712498 100644
=2D-- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -75,16 +75,20 @@ SEC("tc")
 long rbtree_add_and_remove(void *ctx)
 {
 	struct bpf_rb_node *res =3D NULL;
-	struct node_data *n, *m =3D NULL;
+	struct node_data *n, *m;

 	n =3D bpf_obj_new(typeof(*n));
 	if (!n)
-		goto err_out;
+		return 1;
+
 	n->key =3D 5;

 	m =3D bpf_obj_new(typeof(*m));
-	if (!m)
-		goto err_out;
+	if (!m) {
+		bpf_obj_drop(n);
+		return 1;
+	}
+
 	m->key =3D 3;

 	bpf_spin_lock(&glock);
@@ -99,12 +103,6 @@ long rbtree_add_and_remove(void *ctx)
 	bpf_obj_drop(n);

 	return 0;
-err_out:
-	if (n)
-		bpf_obj_drop(n);
-	if (m)
-		bpf_obj_drop(m);
-	return 1;
 }

 SEC("tc")
=2D-
2.40.0

