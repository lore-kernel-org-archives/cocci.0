Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F04C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gpd002g83eYHAwa8nXb4Tip7JW96SuuMFbMMvMgqptU=;
  b=GjPruCc1TL1H7zL5P05R44SNPbU+lNa+6wdDUmZLxqdq1dUM5UBZT/7S
   EaLprCyxY0oj8ub+drUaQf+YPd2bQaQKotxwCFBKsMDJvImhCK/1eQ64w
   xhyBPQwGISWr4O2PKJaGPRxib9T0r5DZ7jepbEV6lnCXAEHT4TeYxhCfn
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99082382"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 19:31:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8681CE0D41; Sat, 25 Mar 2023 19:31:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 92F7BE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 19:31:19 +0100 (CET)
IronPort-SDR: 641f3de1_dd26Lk9kdchu8P1Owlj+6Ya8RaxrG13bwcy7Yxgu9ov9Dso
 By3UDjlL5R4PX7OvSsy0OrOArkvvby2lRVCO1Ww==
X-IPAS-Result: =?us-ascii?q?A0FCAABBPR9khwMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4FggRMChToCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjHQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQewVYEyg?=
 =?us-ascii?q?QGCCAEBBoJjmScfLCJTgV4JgRQtAY0EhDAnD4FVRIE8gRWCLIgcgmeCKIdWh?=
 =?us-ascii?q?yWILwqBNHWBIA6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwSBCoEBBgEmJJpxAgGBdHMBUjsUOCaCBJJYkkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIiAS6HLZAPIKd6gWM6gVwzGiSDNk8DGQ+OIBkeg?=
 =?us-ascii?q?26PCQE9QDQ7AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 eOqhDZJPmQBBaNCnw==
IronPort-Data: A9a23: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
 ewjxw==
IronPort-HdrOrdr: A9a23:bl5nt6yqH591Rqp5bFccKrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,291,1673910000"; 
   d="scan'208";a="51243769"
X-MGA-submission: =?us-ascii?q?MDEQ7VNKCeoqX6aiaf+YusIQnDHQgeUz8ZMn1c?=
 =?us-ascii?q?PAf31+w1+848TvDcmUUZNABkB61FmqRY+TEJewsvqDAWLU9udrPbGSDO?=
 =?us-ascii?q?pt895f0zZAHoOdgpnPJH5krve6gXCv0J21pFafEsbudW2HdZoNVM6wLQ?=
 =?us-ascii?q?CgHovVf/5qNvqVt6kUUbO1hg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 19:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679769024; i=markus.elfring@web.de;
	bh=v+rMXJgncvNeSS/c9GxyeVsaVJFxHUrosoDsvsBMKrA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=E2ZRLGzBeWgDUjxxuDBQNzCqbzkObNJ2PQYpfhURJww+hylN8N/+Ouqj1TTy+BTOT
	 KbbxOqGmhbMKUzW0DrODYY0DpSNyvjAlZo5JB5snAXMrqmjwUvC5O/X7HhGIVkJ7hx
	 QfY8Tk4xJFvpdqiZY5oi+x6dAvscXBmijG2O7Qt4fFK4GByO5igabdQCDOLkDhsOhz
	 iWbYW3fZ9qDZD4KyS6I4pNxcfbrHVMG7qc6dPYdFlyUwKOU8F2VdV4dTE73RPtWyRM
	 8nAXhcDQKG/uA4ki9G6xPVxRcr/1646dFRU/l3HulUc7c8Hfeodny9CFUkdGi6AD7M
	 2CIyWbOgXof2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYcpr-1q1KYe3KoV-00Vmpk; Sat, 25
 Mar 2023 19:30:23 +0100
Message-ID: <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
Date: Sat, 25 Mar 2023 19:30:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Jay Kamat <jgkamat@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h18z4dZIBJTIQ6TPT3oGEZ7o5iXlXWx0RTutB2xT+a1UQZRqGQk
 /qyP1bx/IKo89hqEhWz/HyfbUh/nbMI+1K0zvotD5zKnNg2nfAmTQXvZBxquxA0pNJ99dkZ
 g+DAk9fcs1EWE5piNmh7lbGxM7Y0tmnjGEkRnt4iPIwFs/e1AOYR2sBUDNt5W2bfEwFmV39
 LqH84dG4X/a7AEXZEvJGQ==
UI-OutboundReport: notjunk:1;M01:P0:s/wtJ8pkZg8=;g+PAu3mjM4Vpcsl0C8p621g6/6S
 evIunpd0Z9Attev8KCqn+lz2DtQspTGPM47nMOGjNNhqP8HOdomV6kwkt1QAHZcyEzdxEaGjv
 fMaxIzQXWUBReCFTrBU4dnrm/vdpyvM0hdTgReO+rFa0wfHkvvCJss1c5pB31ku3wo9BhKWyi
 ORp+sP2Pesd0hFKaIBFpf5M4JrqcrePePpD7cLXw7EKGfqxRenwX1c7hpZCFB7N9ownp0wGky
 ozyQN2xiDOgyEvSgPFSQ9WmB5k738wjzc6WO793OxwQaAMNQfBx134Ks3YZdxgTr3hbe2Zj8d
 Z4nOthoPMSSLboGX6RMbynrTka89+Y/P9yn1nZIEnWKCy0McHHz/1sBWT7X1n29hzcyhvP7FF
 xL2Kc9tJXfnlUkZtp5jEh03mAXvp11ziJvANMvPJ4U+2/oWa3nmz2fzi3PtVSbOIv3qrzMcDS
 m9ix5UgBpUB97k6A7whUGAicpzeQQas9w1T+SmFlkvmOt+jvB4ozjV65E5uEoOyvsTjnn+SLm
 BPDpT02oh4IysjrMGnnFvB8OY4Gs2qknJTCnRymqXHMLZJ7gg7OmJvIGe0PAtVfX62Bstbs9R
 u60KsZGuoVBU4xs5rY+Hg+cbUTvHyGvldsU4UW2m2/dY0XFxb8cPWLUocD40VFoatZVR/KONI
 y/T4C4j6FZRt2FAk2WCXaNvP+1mh5cHn8PUleC1ZU02DpMVvIixP0k+1IiWWGP6yesSiaMBQg
 XCjQOS8E084M1KUPQMiLew+26UzhtgMepZNhib7FtX1jp7cmkz351v1uDWPIF4XOffw3W011F
 ws2TGuNDkfk2LE3yHUbBm/5yZkibfqXhF6mPP9chIPueSQ6QU8+CPgq1BRc/U2lfI+wQ4kObA
 X5D6NoROwlBSBPHhqlz5pslEUWC9dzleFCWruf4BNXj/4U32KaATYGTiV
Subject: [cocci] [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 958
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/c383bdca-6f0d-4a75-e788-e1920faa0a62%40web.de>

Date: Sat, 25 Mar 2023 19:11:13 +0100

The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function
=E2=80=9Ctest_memcg_oom_group_score_events=E2=80=9D that it was determined=
 already
that a corresponding variable contained a null pointer.

1. Thus return directly after a call of the function =E2=80=9Ccg_name=E2=
=80=9D failed.

2. Use an additional label.

3. Delete a questionable check.


This issue was detected by using the Coccinelle software.

Fixes: a987785dcd6c8ae2915460582aebd6481c81eb67 ("Add tests for memory.oom=
.group")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/testing/selftests/cgroup/test_memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/test=
ing/selftests/cgroup/test_memcontrol.c
index f4f7c0aef702..afcd1752413e 100644
=2D-- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1242,12 +1242,11 @@ static int test_memcg_oom_group_score_events(const=
 char *root)
 	int safe_pid;

 	memcg =3D cg_name(root, "memcg_test_0");
-
 	if (!memcg)
-		goto cleanup;
+		return ret;

 	if (cg_create(memcg))
-		goto cleanup;
+		goto free_cg;

 	if (cg_write(memcg, "memory.max", "50M"))
 		goto cleanup;
@@ -1275,8 +1274,8 @@ static int test_memcg_oom_group_score_events(const c=
har *root)
 	ret =3D KSFT_PASS;

 cleanup:
-	if (memcg)
-		cg_destroy(memcg);
+	cg_destroy(memcg);
+free_cg:
 	free(memcg);

 	return ret;
=2D-
2.40.0

