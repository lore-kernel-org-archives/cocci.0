Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28115C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=V6yWmc7NtllNxgy20rZrN2wB6braMAV6QvojRfAkeBo=;
  b=dkx9ur3h+JsI6FbKFipJUF26pHpBa4qPpiNC62gUJq+lDhoUMxK+LB4N
   FCK+g3x5WYJJpF0XvPkD2sdOVy6s04Com/in7dK4D2RrdDr+awoAKR7PM
   qSHWki1EtGfGxP2GdAuCtveH1dajRF8HsSatEr8HwggPEQrlDXnOW76DB
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419794"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:12:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79B99E0D1F; Tue, 18 Mar 2025 10:12:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3967AE0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 19:44:49 +0100 (CET)
IronPort-SDR: 67d86da0_AtvTOmoZpVsCow8bMoYfyUKffO2oqumexv0Dia0KQuRCkHs
 oesBOQPw2fp9KdsIGXIQX7A+LjKTKxZfg/3q5Og==
X-IPAS-Result: =?us-ascii?q?A0EPAADXbNhnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIjHNfhlSUcItIgX4PAQMBDUQEAQEDBIUAiyECHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CDYEAPgYBATcBgTyDFYJlA61igTSBAYIMA?=
 =?us-ascii?q?QEG3CCBZQmBSAGFbIJjAYlpgSEbgg2BFYE7iwWCL4IzRYRiiU6IVJdkgU0cA?=
 =?us-ascii?q?1ksAUsKExcLBwU5KIELA4EPgUV6gkNpSToCDQI1gggTXR+CKIRNhDyDL4EQg?=
 =?us-ascii?q?WWDa4IRggWCMYUTgWiEYS1QgTgdQAMLbT03FBsGo3eFUYJLWKJ2giCLdJUSh?=
 =?us-ascii?q?CWBY6AyE4E4lXuTES6YUKkzgWc6gVwzGggoCIMiTwMZD44hDA0JiGu3AiM1P?=
 =?us-ascii?q?AIHCwEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 ijftNhjpxehiObdklJa
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:n9Up467G6CSc6YS72gPXwNvXdLJyesId70hD6qm+c31om+ij5q
 STdZUgpHrJYVMqNU3I9urtBEDtexzhHP1OkOss1NWZLWrbUQKTRekIh7cKqAeBJ8SRzIBg6Z
 s=
X-Talos-CUID: 9a23:jvflIW7aSNMnxF0aWtss+GskJ591WCThnVjvf2O1UyFsF+KfRgrF
X-Talos-MUID: 9a23:nIRiwQRnB2PTldMQRXT2qQN8P85E0Z6CI1sku4xbnNSkZH1ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="111821900"
X-MGA-submission: =?us-ascii?q?MDH7aW3BlzK10AScYPmVADSCNElqXJ8mljSCyh?=
 =?us-ascii?q?Nu9eWCSR/YLuFkvIjj4Iov1pIi0YP3QHuWw/t+K3Uy6USLCcUJAnceWQ?=
 =?us-ascii?q?N+mBJV+3Dmoh3iTza292fQNHvdT2b5ErMnGZ9zx51jQVIHhAQ1cRacvD?=
 =?us-ascii?q?yQ50gfzfRvnKPRjjMURncx2w=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 19:44:47 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EB981A48CA3;
	Mon, 17 Mar 2025 18:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40381C4CEE3;
	Mon, 17 Mar 2025 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237086;
	bh=Wu2QLw3jkffW9yn9lwjJGgdySr+Ugj2dLLTwl72nDUM=;
	h=Date:From:To:Cc:Subject:From;
	b=cm4Uw79jpt6OAqWkuQ3I+1mkDnWBjxe4iOB86vO4Qnl27wNviOR8fpKHZl0FPSWGW
	 VIlfAE1SC6MLSK2y45fBFQ2uV9djeUMNmVFuc4Pr2mJ82sOgJa4AA8jhEaIIdXRQ3O
	 MJQqpcQUGglPKwFUW148pvkLK/ilmyAwUdAvysV9hBhx7LcRoQ+TDBKJ6yp4np/fks
	 1IGgMydbFdN9jjngpgFbPUTvjSHX1ynSvN1dbDRf6Y6rnx6MqHfCTNnr6UCXpuCnvA
	 w5FbbnFerZ4d2JzwzHWyy5tmVFklpfgXfiLFSDdR3ofgApnvbzdrRc2eGGZvVkEKZ4
	 GMKGjKLgi5UbQ==
Date: Mon, 17 Mar 2025 11:44:42 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: "cocci@inria.fr" <cocci@inria.fr>
Message-ID: <202503171135.B1CCC51FA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2603
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503171135.B1CCC51FA%40keescook>

Hi!

It seems that the mere presence of the "__free" attribute breaks
matching:

$ cat test.c
static void why(void)
{
        u64 *rates_64 __free(kfree) = NULL;
        rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
}

$ cat match.cocci
@replace@
expression THING, COUNT;
expression GFP;
@@

-       kcalloc(COUNT, sizeof(*THING), GFP)
+       kzalloc_objs(*THING, COUNT, GFP)


$ spatch --very-quiet --cocci-file match.cocci test.c


Which doesn't match. If I comment out the "__free()" it works:

$ cat test.c
static void why(void)
{
        u64 *rates_64 /*__free(kfree)*/ = NULL;
        rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
}

$ spatch --very-quiet --cocci-file match.cocci test.c
--- test.c
+++ cocci-output-1466652-b8a5c5-test.c
@@ -1,5 +1,5 @@
 static void why(void)
 {
        u64 *rates_64 /*__free(kfree)*/ = NULL;
-       rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
+       rates_64 = kzalloc_objs(*rates_64, count, GFP_KERNEL);
 }


I have tried adding "attribute name __free;" to the rule (which didn't
seem sane, but also didn't work). I have tried adding this line to my
standard.h:
#define __free(x) MACROANNOTATION
but that didn't work either.

What is going wrong here?

Thanks!

-Kees

-- 
Kees Cook
