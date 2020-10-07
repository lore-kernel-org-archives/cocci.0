Return-Path: <SRS0=67nU=DO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A6C41604
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:21:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07E720659
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcVquq9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978LDsi029007;
	Wed, 7 Oct 2020 10:21:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5A0F3769A;
	Wed,  7 Oct 2020 10:21:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CE99D578C
 for <cocci@systeme.lip6.fr>; Wed,  7 Oct 2020 10:21:11 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978LBp2026484
 for <cocci@systeme.lip6.fr>; Wed, 7 Oct 2020 10:21:11 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id g9so904387pgh.8
 for <cocci@systeme.lip6.fr>; Wed, 07 Oct 2020 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aXnHj21ZmRdqQHlnOGk32CfFVQqD9hJbuHRNZwNWv5Q=;
 b=IcVquq9tiNM3mLjKsREiRFhZvIisIITSrOCJtY8jrZ2man5vXVeSyxu8YB/T9/Pvd5
 TwM6tuIUIZ7o8EdX39mRQQDbJY0qrWby4GxuIJDmbKwp5FuJSev9y3VmojyMMkv5cGVL
 LuHtXVLYRt+SIXS155qW6bmPBrSIKQH8rhTeF/jlSSET18x7HO4c3eTTtWEq28eWtfBn
 IK7a2kAAHnDrW4b7PDv+bNqdGL2U+iiYynHHbRR+HbtBqwATPZiguVCpAlfz2jQ1CZl9
 SNN35G4Q3hwl85DJiEI9cJ19x+nRunZTWWZyM6TNVtqOuiVHBgzd/LlHFJZ/rWUpEZ7f
 0FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aXnHj21ZmRdqQHlnOGk32CfFVQqD9hJbuHRNZwNWv5Q=;
 b=mCDf/pDvzoGmYaVSpqF51hLGk+lHWA7g1aE9HfGO2+fkX2B52VYW/V9LWPo0LURdlI
 xqxcaHbEFPhudEV3Q8LL6WGNreJl0M2FHTKNY66IEqeJe7phVooXTOAB7ptyM9GGPLRp
 hscB67oQ+HANLXkl9ZkJJ2vRYX6wnL3y8R9NiJqgm+0iRup5xm3LV0SVDBmao+TG8HGB
 pbGCwKAMLcRwkVPD3rf7fn1ztKAEea62fTCH2RSgnXVRINPVAno2dMZODZFLPmvFZHja
 cK5sa7IFoQgyWf8XeBO/SleJXAB18iK9NUqZApzIeFBU2R6X0BTUENnhjscF+A8MpGad
 tGOw==
X-Gm-Message-State: AOAM531mgnm1Ya6HeA6ZZWu0UE5TymD+FxWc5Pqni/OBiwgRZiwk2NLs
 vrDr2l4Kx8f+KQDX5zh1R24=
X-Google-Smtp-Source: ABdhPJyOkeJ3jHOKbW9nrka/ScKbv790DtBRHOuaOCYkW/97v7VP3QvoMXNO6wEFWBSJwnBLP8yu3w==
X-Received: by 2002:a62:84c7:0:b029:152:2f5b:aa8 with SMTP id
 k190-20020a6284c70000b02901522f5b0aa8mr1939411pfd.3.1602058870547; 
 Wed, 07 Oct 2020 01:21:10 -0700 (PDT)
Received: from adolin ([49.207.194.78])
 by smtp.gmail.com with ESMTPSA id o134sm1874244pfg.134.2020.10.07.01.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 01:21:09 -0700 (PDT)
Date: Wed, 7 Oct 2020 13:51:04 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <c5642af8c966e1e4bbe4158ea02009f6db0af932.1602054065.git.sylphrenadin@gmail.com>
References: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602054065.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 07 Oct 2020 10:21:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 07 Oct 2020 10:21:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/2 V3] scripts: coccicheck: Change default value
 for parallelism
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default in machines with more than 4
hyperthreads.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
	than 8 hyperthreads as well.
Changes in V4:
	- Use J as optimal value for machines with less than or
	equal to 4 hyperthreads.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..bafc55141a73 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
+		NPROC=$((NPROC/2))
+	fi
     else
         NPROC="$J"
     fi
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
