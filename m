Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DC2C6FD20
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9HX/ixphtRN0z6U8DnTbitK6gExvexMIdXq1DgfGmuY=;
  b=GBjClO9r8i2oiZ7TKk7u/OqGlqYwXlWzFViV8syXoVB57Kv9aZqjF+H5
   f3zIowls+B1oICGB9OLrjEE3YXVZgR6ys/TbA8rJLQ5yRwMVQdigT1+cY
   stptxQIVEIu7RCliOseipNGE5REObJnwk8t6kSLWHJ782+VXCRnXd8Xe+
   0=;
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
X-IronPort-AV: E=Sophos;i="5.98,287,1673910000"; 
   d="scan'208";a="98924926"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 12:44:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82381E0D45; Fri, 24 Mar 2023 12:44:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 44770E0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 12:44:33 +0100 (CET)
IronPort-SDR: 641d8d22_3of+xR34uGd8dWsLr55CTIoFIO0Si+MfwjnlOr+iuJtUQtu
 dWjl7+dnBy7h+IeShdftdZG686bT00kkuAK9rng==
X-IPAS-Result: =?us-ascii?q?A0FgAAB0jB1khwsR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEOIFTgnMCh?=
 =?us-ascii?q?TkCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsnN/M4EBgggBA?=
 =?us-ascii?q?QaCY5knHywiU4FeCYEULQGNBIQwJw+BVUSBFSeDQYgcgmeCKodWhwaIKwqBN?=
 =?us-ascii?q?HWBIA6BPYEEAgkCEWuBEghrgX1BAg1kCw5vgUsCZExnJQQOAxkrHUACAQs7O?=
 =?us-ascii?q?j81BgMLIQZYawIJIxETBQMLFSpHBAg5Bho0EQIIDxIPLEMOQjc0EwZcASkLD?=
 =?us-ascii?q?hEDUIFHBIEKgQEGASYkmkoCAYJoAVIhGhQ4JoF3DZJYCQGObINKng40B4Iog?=
 =?us-ascii?q?VWBWQyfDAYTLoN9kwsOBjGRcQEulzwgp3qBagopgVwzGiSDNk8DGQ+OIBmED?=
 =?us-ascii?q?I8JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 sqpA7Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:L6BxF6lqQrPKFVSCEKRCpDAG4YHpDfIk3DAbv31ZSRFFG/Fw9v
 rCoB1/73SftN9/YgBCpTn+AtjkfZqxz/FICOoqTNWftWvd2FdARbsKhbcKqAeAJ8SRzIBgPT
 0JScRD4dTLfDxHsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,287,1673910000"; 
   d="scan'208";a="98924920"
X-MGA-submission: =?us-ascii?q?MDEtCo66KYFRb6l/imIj8C3XLEJZcbha1WCtSA?=
 =?us-ascii?q?LluBGFgBQ7cmv7kdM1QMONT5OltgD2BuJqJDfRwTnkh7zhPoZ/A8Z3q4?=
 =?us-ascii?q?murYLJb1/ruDe7xk8oToaoQDrUc5tYeKKHFtg7NVMrkbrp5qc8G9zvBY?=
 =?us-ascii?q?FdXgtoNr6HrTyQFJDEna/MbQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 12:44:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679658217; i=markus.elfring@web.de;
	bh=iIIjkkj5zsgHcyK/SkHC2txHgNytJUePpreIxINWrxQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=JoGP/3XneA0pZLJCKktx6syZf9hmWFt6eVL7pvXBwFbupWJcAwdATz1TlIdectyJt
	 Txpu5nJnrifl2z4ODJMdHqJro6tm3Xs+WNw3d0em/7eYbu8pTOhN5a9/44Nyf/TZTh
	 JY69kv+agtoeupYNf2tjzfU1A+k6CcKHoIPkjwsVmtX5uAOSfpYnC4MLxMSE56+BDO
	 vsdad307Df4qx+xyA18ZH14PZAJU+DqPVjAYS7D5IWWA8iJZqer4QVnMY76ACSwAAf
	 XO5NSnB23VcOSxouB1N3RcbQMKga6YeoPiE4eDcAPKupFLOfbTI/5R471/jh+FppzT
	 A3mu8DozfD8Pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1pXyjN0u9E-007mAt; Fri, 24
 Mar 2023 12:43:37 +0100
Message-ID: <407a4e0c-891e-2b81-c478-99ab3f05f610@web.de>
Date: Fri, 24 Mar 2023 12:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@arm.com>, Jin Yao <yao.jin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria
 <ravi.bangoria@amd.com>, Sean Christopherson <seanjc@google.com>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d/Y4tqpas1CG18+dK/3RivBj64esXdvGii/lkeinN/c8ij4ohuQ
 i/dSBc0r3bpqesmGgw9QK7zRCWzvG+c1eUVp5JJPkwN6a9YvNJFLQcz4FpwkSJn6DB/bpcc
 dUiU1SjCF9UdHyJzwndVxyegjVyTPvZHZBOYpvUnRD6cxDSDh5L4iz3Qk7HLGArzYp7HOTI
 v+XEtxkyZHVkpS6Kx8mXg==
UI-OutboundReport: notjunk:1;M01:P0:D5LV2aXa+98=;lHmdR1bd/v0VxIHO8Wpwi/U4Qw9
 k8CbNNQdCgT2IHmBrXCdWU9jREYFlkK7DmAo7q/QCuNrjHSeU3OZLOg0hKaBBaDrp8qwQJ03U
 F+BLSd2EfUToY9nVI4kq4T2hR/bNpieSULmJbDOhpQWIIa/sIEKtP13SkG+X05I2p5LHkLmvO
 SCTZCBcL1RwxZJwFIP3yDRdkX/BFe74bhxd7hgHuKagXk4I+CzbjJlYJjhVB+p+naFZqksd2x
 3da98QgiB1dqQyyHmiFPL30Z63L8HXh6H+YBYerebR1kFDXtZqfz4FfjKLbPCG/OrTSRN3fcN
 LPCtJBVzqlSozaXKc4J6F0phQaPsbgLgPPRNGRVZdvzF6LWnBp0EjXcKy0KJ5MN2GyjNg1WfY
 Vx92LoAtB+eKMSWkpDstXdiuj/K6E4DCenGKtLmWnCff/lXhRGe8o/iuF9Q5Qjo2vbVAxL5dN
 IfEc9q0FCxD5AKSSINo6hz9Z7LrX/DwQasvkk62swa42r6TWC3yaSq29EFt7E+BSTuXWWzxic
 4LOgvsHxk1cP66hdMBxPzgYLu/SUdMrDEILo6f7TKozHjxZ8aG5hkIePGRGs8zfwV6RzzzTc/
 Zt32dPYLKWeRFXfOEIbs1UprwX3Ci67qcG+WxYVnr/HHYowf6o/8o8hHvxHNA+vVbEXmZRd6b
 a/7uuW1a6omy0uynOybwM96NVBtiO0+rIK7CZKSj+xMFUb9z6oAPFCyFo7sYbMeUAHqP/gV2o
 e5hh64kuYOTAqr4MlvUoDa0JNu5U5B0yzApeam9XHYkr5r3eLSQBTKW/mboT3WwzAHZt0rpbe
 Gcxo0xJSEV7jRHL0ycfvc96fXQH5/GzR+uSv+RdZSAiV7Wb0ui/lMByHIUIaBso/rVax6pTUi
 mgr8jCK0Pjk+TcPcHOH192dDN0toPzv0sDkYFO6cLg9E2qb/EMQTtu5QX
Subject: [cocci] [PATCH] perf pmu: Improve exception handling in
 pmu_lookup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 915
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/407a4e0c-891e-2b81-c478-99ab3f05f610%40web.de>

Date: Fri, 24 Mar 2023 12:15:24 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cpmu_lookup=E2=80=
=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cstrdup=E2=
=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 13d60ba0738b0532edab3e1492b2005d36ba0802 ("perf pmu: Add PMU alias =
support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/util/pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c256b29defad..aafda41b6fe8 100644
=2D-- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -896,17 +896,17 @@ static struct perf_pmu *pmu_lookup(const char *looku=
p_name)
 	pmu->name =3D strdup(name);

 	if (!pmu->name)
-		goto err;
+		goto free_pmu;

 	/* Read type, and ensure that type value is successfully assigned (retur=
n 1) */
 	if (perf_pmu__scan_file(pmu, "type", "%u", &type) !=3D 1)
-		goto err;
+		goto free_name;

 	alias_name =3D pmu_find_alias_name(name);
 	if (alias_name) {
 		pmu->alias_name =3D strdup(alias_name);
 		if (!pmu->alias_name)
-			goto err;
+			goto free_name;
 	}

 	pmu->type =3D type;
@@ -930,9 +930,9 @@ static struct perf_pmu *pmu_lookup(const char *lookup_=
name)
 	pmu->default_config =3D perf_pmu__get_default_config(pmu);

 	return pmu;
-err:
-	if (pmu->name)
-		free(pmu->name);
+free_name:
+	free(pmu->name);
+free_pmu:
 	free(pmu);
 	return NULL;
 }
=2D-
2.40.0

