Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32785606A330
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=oifZaluj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=nie98FWDqN9gi2xgJoMHipVQYiig9NK4TUDtric5vU4=;
  b=oifZalujJcGcJ5DDMnQpU9RJiegc0jJ4X/VgKTdkyAfU6Y75bHlyOefb
   mE5yiYtuycaOsstXFv4oO96uPmAZd5AKJqw7hF6PiWzO8amGQvrzle3aj
   LLYLo+MYwJcR/NIkmIOVqbwmStj7th4ovZWw1+hAjyigKkGlkLpvCqH5r
   s=;
X-CSE-ConnectionGUID: rA2QW/aaR2mcsOQVKrkGTw==
X-CSE-MsgGUID: bSbfimTFQOqdvq69Mw4rKg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323525"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D1E4F8169F; Sat,  7 Nov 2026 11:59:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A97BF821BC
	for <cocci@sympa.inria.fr>; Tue,  3 Nov 2026 15:24:11 +0100 (CET)
X-CSE-ConnectionGUID: 3F1CDNl1RTeBAeqNfXrqqQ==
X-CSE-MsgGUID: h8lueLDDRd6Ure0P+w/XAg==
IronPort-SDR: 6ae9ee8b_VuCPkafqKDaQZDs4AmKYB9o4rXmhigYI5vLgoAbJPOA1qLd
 KjMu3hPM3S4xSXe1uQrukEQdAmIofbRONuqEbBg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAADu7OlqgwsR49RaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBC2A0BAtJhFiIG4c4gXQtk1CIfYFVgXwCDwEDAQ1KBAECBAEBA?=
 =?us-ascii?q?QIEOIQARo4fAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBA?=
 =?us-ascii?q?gQDAQEBAQIQAQEBOgcOO4ZPDYwTgSyBJgEBAQEBAQEBAQEBAR0CDTpGJwQZA?=
 =?us-ascii?q?QERJgEYHAIYDgJfFAEBgn4BgiIBBhABAzcHDaAInB5/M4EBggwBAQaCa9gAH?=
 =?us-ascii?q?ywiXYFrAwYVgQouAYVxglEcAQVvhUAJgz96Jw+BVUSBPIJMB4NQBBiCEy+CY?=
 =?us-ascii?q?IJqgiaBDIgajniBShwDWSwBVRMXCwcFgWgDKi8tMjwyHYEjPhcvWBsGBYEdg?=
 =?us-ascii?q?R6BEoEHXYErKF0BIYEIgXYCglGBJVsCAUlBDgdFUwklQxJHJCIIEgkBExosC?=
 =?us-ascii?q?oEaNTwJJgQ7FQxmCxoFYQgCDQx0ORAwHiQvBRwmQBBtPTcKCxkEPZMDgm54I?=
 =?us-ascii?q?z9GNVJ7L5MCswY0B4I5gWmBZwyJCoEmlT8GEy+XUw+TDQGZCCONZ5VhhVmBa?=
 =?us-ascii?q?DqBXDMaJIM2UAMZD44iGYQchGDJJkYyAgEBOQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wICUo6t1qr1uWTzWPKsRpU4o7skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: 9a23:qk1zFWOjDAJrAO5DAwc+32IyHpkfTnD35XrJBUGIE39wcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AbnwEJQ3xy7eTspfQZawG7QKn8jUj4/SqFU0pvbk?=
 =?us-ascii?q?8t5e5LyEoA3SCywSeTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="161627254"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEDSf9pXt5j/K98LR6u1M3JhtAiKaZKEzMyj8?=
 =?us-ascii?q?NPY7+RIoU0NlFYY9JAhmPZph8tqeggNkWHilVNpRk9tiBdIEVkfmSiep?=
 =?us-ascii?q?yatN2gei32KAjtnUJszDHuHS63nMyoi2liRujUhvgw9GLKOzcCz4gzh0?=
 =?us-ascii?q?0ARFAN/HZcJ3GArVTdR6Ujyw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:24:11 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1x6a3S1ALA-00Yila; Tue, 03
 Nov 2026 15:24:06 +0100
Message-ID: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
Date: Tue, 3 Nov 2026 15:23:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, tools@kernel.org
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2LDeXWUFgmyKDJfO8OLnATJI3uY/MdjXzbdTUQUD1ESqsxzPDLB
 HhGh5mPTlDPi+3HVD1f33JyC09RbvOtRw3JqJqzySsmNlwxN8jRG6qC0hI3PdGkGSDBwQkG
 TawUY9dGytJWEZOnDnjU0nb/GU+/6H3OYZyDYUeuZNHaEbkNRFlRIHWFGqmRi88kc2bxSt1
 iRbx5D5dyAofIHew9kx1Q==
UI-OutboundReport: notjunk:1;M01:P0:SiR72DuQUQQ=;CkNSSXQGasztztB6fglZ2qbVUSE
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RFC] Replacing special goto statements by direct returns?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3776
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/g3hjQHBODe3bYVIC1qnEaQ>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

The documentation for the Linux coding style contains the following inform=
ation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.4-rc1#n526

=E2=80=9C=E2=80=A6
The goto statement comes in handy when a function exits from multiple
locations and some common work such as cleanup has to be done.  If there i=
s no
cleanup needed then just return directly.
=E2=80=A6=E2=80=9D


Thus it seems that the following script for the semantic patch language
can work to some degree.


@replacement exists@
identifier label, var;
@@
-goto label;
+return var;
 ...
-label:
 return var;



Unfortunately, patches would be generated then by such a simple SmPL code
which would still preserve return statements that became unreachable.

Test result example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-allow-inconsistent-paths fs/xfs/libxfs/xfs_btree.c =E2=80=A6/Projekte/Coc=
cinelle/janitor/replace_goto_by_return2.cocci
=E2=80=A6
@@ -1735,7 +1735,7 @@ xfs_btree_increment(
                --lev;
                error =3D xfs_btree_read_buf_block(cur, ptrp, 0, &block, &=
bp);
                if (error)
-                       goto error0;
+                       return error;
=20
                xfs_btree_setbuf(cur, lev, bp);
                cur->bc_levels[lev].ptr =3D 1;
@@ -1747,8 +1747,6 @@ out1:
 out0:
        *stat =3D 0;
        return 0;
-
-error0:
        return error;
 }
=E2=80=A6
real    0m1,074s
user    0m0,995s
sys     0m0,071s



How should such a source code transformation approach be improved accordin=
gly?

Regards,
Markus
