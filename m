Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A884C4332F
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 07:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6UfeXhqBPhCnzAVep7pncTrLl2H4zeiceXIx+IefpL4=;
  b=rMINXV+zmLot4Zg0LxhmkMyUdu8BfIzFm3O5Xi6WSiDd7igcZywdftY3
   ZugBgJ6/Z3Jjq1gtx3GEQf7isEN7fNGIGVk9t12hzqhZnlR5Q2L0lyOTo
   WJR1ydrrMr2WGupJSqHLWo9YufE7YkAvtNPxJGJ1t7tNV7byvgvNvbQlu
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@mailo.com
X-IronPort-AV: E=Sophos;i="5.96,274,1665439200"; 
   d="scan'208";a="85059666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 08:18:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E026AE0138; Mon, 26 Dec 2022 08:18:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E70CE0128
	for <cocci@sympa.inria.fr>; Sun, 25 Dec 2022 16:09:33 +0100 (CET)
IronPort-SDR: 63a867ac_nFQmo7ECHEMn4c67g2Y2XUhfZ7+o2phAarFfE6NnOSVelIN
 LzSyJIdk0yd/Qohs0IKe0siU/udc1jRyNHUsh9Q==
X-IPAS-Result: =?us-ascii?q?A0E0AADvZqhjmAw2ttVaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIsgVwvBAtFk0mCB4V9kgWEAoNUDwEDAQ1EBAEBAwSEfoURAh0HA?=
 =?us-ascii?q?QQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEBAQEBA?=
 =?us-ascii?q?R4ZBRAOJ4VoDYI4KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgJ+OQEBSxMGA?=
 =?us-ascii?q?QE3AXBNAQoIgn6DIwewUIEBM4EBgggBAQadSIFeCYFAAYxxgk5pgSEWBoINg?=
 =?us-ascii?q?lGCLIsCjDGMZQqBPXyBJw5hNwNEHUADRjIKQTUGEUsiCRobB4EKKgkfFQMEB?=
 =?us-ascii?q?AMCBhMDIgINKDEUBCkTDScmawkCAyJmAwMEKC0JIR8HJiY8B1YSKgMCDx83B?=
 =?us-ascii?q?gMJAwIfgUolJgUDCxUqRwQINgUGUhICCA8SDyxDDkI3NhMGXAEqCw4TA1CBT?=
 =?us-ascii?q?gSCFi8onQt7ExSmKp9Eg3ihI6kSAS2HIo93IKJZhQWBeCSBXE0jFYMiTwMZD?=
 =?us-ascii?q?44gGYNZimY8MTsCBwsBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:AjS4RK2N4HfanuMNjFuqYQqjBLIkLtp133Aq2lEZdPWaSK2lfu
 SV7ZAmPH7P+VMssRQb8uxoV5PtfZqxz/FICOoqTNWftWvdyQiVxehZhOOJ/9SKIU3DH4Bmu5
 tIQuxTIJnZEUV65PyW3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,273,1665439200"; 
   d="scan'208";a="43591669"
X-MGA-submission: =?us-ascii?q?MDFduhgcCGxlkaC++m3Ncc0bEgwXSTpz0AhvUQ?=
 =?us-ascii?q?+owjFo6dZhLc1Er8hSRKrwvQNs6nORw3dWyp7p08obD1/nxROCPTvy2u?=
 =?us-ascii?q?1SJKTemeV5oYpkUnhx19SzeKa4iIoqGudg2j931jUuiAYcM+GDb8ZZry?=
 =?us-ascii?q?NuuSoEliCKKTRG83Oo+XHbsg=3D=3D?=
Received: from msg-2.mailo.com ([213.182.54.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 16:09:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1671980971; bh=JbAethzpN7nG0wyvMkJzQiQv8OlJxBl91l6miBYz0Nk=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type;
	b=BV5vHNAVx1e/43nCEdOqcUs8eTIfHoxAmmzp+gTIUGqHpE7l3InpEvyE80hfV0PwH
	 aqr41iwS2IbMlBJvwNsVPBakz+BVHTX3CE1KYyBj2H+D0Eqzau/k+T2Br5vGIG56VR
	 IhsZz+L3okJuaOW0pPOONVbgbrfcjiMd6ej8yReY=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Sun, 25 Dec 2022 16:09:31 +0100 (CET)
X-EA-Auth: Grnebmk61o2Ytl3xXoo8eI+B/Z+hTR6IkbcdeL7dstezlgCqOfUiYXf7/B+fI6UnsFS+ceP+79I10fP+LlSD+n417BF7f6Ck
Date: Sun, 25 Dec 2022 20:39:25 +0530
From: Deepak R Varma <drv@mailo.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>,
	Deepak R Varma <drv@mailo.com>
Message-ID: <Y6hnpcLiHmJaQbeE@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: api/atomic_as_refcounter: include
 message type in output
Reply-To: Deepak R Varma <drv@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 786
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/Y6hnpcLiHmJaQbeE%40qemulion>

A common practice is to grep for "WARNING" or "ERROR" text in the report
output from a coccinelle semantic patch script. So, include the test
"WARNING: " in the report output generated by the semantic patch for
desired filtering of the output. Also improves the readability of the
output. Here is an example of the old and new outputs reported:

    xyz_file.c:131:39-40: atomic_add_unless
    xyz_file.c:131:39-40: WARNING: atomic_add_unless

    xyz_file.c:196:6-25: atomic_dec_and_test variation before object free at line 208.
    xyz_file.c:196:6-25: WARNING: atomic_dec_and_test variation before object free at line 208.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index e63d52408b86..bbe5b2932933 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -55,7 +55,7 @@ identifier fname6 =~ ".*call_rcu.*";
 p1 << r1.p1;
 p2 << r1.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "WARNING: atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))

 @r4 exists@
@@ -88,7 +88,7 @@ fname@p2(y, ...);
 p1 << r4.p1;
 p2 << r4.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "WARNING: atomic_dec_and_test variation before object free at line %s."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))

 @r2 exists@
@@ -107,7 +107,7 @@ atomic64_add_unless(&(a)->x,-1,1)@p1
 @script:python depends on report@
 p1 << r2.p1;
 @@
-msg = "atomic_add_unless"
+msg = "WARNING: atomic_add_unless"
 coccilib.report.print_report(p1[0], msg)

 @r3 exists@
@@ -126,5 +126,5 @@ x = atomic64_add_return@p1(-1, ...);
 @script:python depends on report@
 p1 << r3.p1;
 @@
-msg = "x = atomic_add_return(-1, ...)"
+msg = "WARNING: x = atomic_add_return(-1, ...)"
 coccilib.report.print_report(p1[0], msg)
--
2.34.1



