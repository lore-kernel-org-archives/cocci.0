Return-Path: <SRS0=AaVF=FA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE64C56202
	for <cocci@archiver.kernel.org>; Thu, 26 Nov 2020 07:58:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429FB206D9
	for <cocci@archiver.kernel.org>; Thu, 26 Nov 2020 07:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiXKaMYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429FB206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AQ7vgXq020033;
	Thu, 26 Nov 2020 08:57:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ED277779B;
	Thu, 26 Nov 2020 08:57:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C9E17454B
 for <cocci@systeme.lip6.fr>; Thu, 26 Nov 2020 08:57:39 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AQ7vbZS007230
 for <cocci@systeme.lip6.fr>; Thu, 26 Nov 2020 08:57:37 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id l11so765700plt.1
 for <cocci@systeme.lip6.fr>; Wed, 25 Nov 2020 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=AmZyur3dqLRwt7CJZ9S3po1AfiI2akYIsVedoPBwE7w=;
 b=SiXKaMYgvMErrwMXKGeTftOQWdQCu+a9i7O7lFlvF4dznPEEJ5eocPrTSm1EIfSwwm
 CAj+BKOTrwQiqpxmHIdn44ryjPBuB0vdVxBGdYGjZHtDRQuvnht1eDfZHdshBF2Ofq9U
 yKUXRRgNPtaXARZDK4hPq9erJPpJztujgA31U5Qo4DOUVted0BYXv6vJcf986vQ0RTQM
 TtLWahAJjM3lpQZkFgFEg2rXT+w6mpZx47Dx9utPY81q7MNePcFLk8poaLM03Wy+JsvC
 3l+TKUVsFNdnSuDf0XtON6y5VIwSvsBBAycCY/HHtBCwdh/q9+MFmOaCjfGpJ7MrwDxD
 a0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=AmZyur3dqLRwt7CJZ9S3po1AfiI2akYIsVedoPBwE7w=;
 b=I3eXerUQUXiCiFMbn9BBph3Kf+DaT4+oZI8Q7jxSbhn0WROgBD4REun3Iy0Abqufu4
 whzGS5kZm8yqGYLNxqhO6KhDM4jhG+Rkph/HtV7sovpNNo1UJgR9lOuxrgG7jB5aKQLC
 JLIgrXgbsCoQQMke9JVtBYYrO9bbznixhUl0sFp4GlVZOZzCzF+JFgug82k4T8377/nR
 RP8y5Vd/zJxRQ5pXilKrdHfSlJDAMXXnX4v+vI47Nm41Z23q+fXM3Kwrnl6sO/WIUCB5
 F24VbG/YwlEhBvz7RVk2Ed0c8JXzFH/kg5ZeeWTV/HqEY6/+9bAT0JUFaXgrUw4M8Q+i
 +dkw==
X-Gm-Message-State: AOAM5335LhpqiXc6PUO3d8PNWhKS8/SEqqGJ0dgXA/Fjd+1+rYBXM+Ro
 327vFVorhENm7gBLRtcpZ8A=
X-Google-Smtp-Source: ABdhPJz640wG66IGDjYOa+fF/lDDn07TkbqINzHI/+LOB8n1+kd77ugQHZBzK4TP9BeeqV3Taenmpg==
X-Received: by 2002:a17:902:b182:b029:da:d0c:abac with SMTP id
 s2-20020a170902b182b02900da0d0cabacmr1787002plr.40.1606377456773; 
 Wed, 25 Nov 2020 23:57:36 -0800 (PST)
Received: from adolin ([49.207.211.158])
 by smtp.gmail.com with ESMTPSA id fh22sm5726642pjb.45.2020.11.25.23.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 23:57:36 -0800 (PST)
Date: Thu, 26 Nov 2020 13:27:30 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201126075730.w6brpeuviefmsxhl@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 26 Nov 2020 08:57:43 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 26 Nov 2020 08:57:37 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Gilles.Muller@lip6.fr, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2] Documentation: Coccinelle: Improve command
 example for debugging patches
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

Modify Coccinelle documentation to clarify usage of make command to
run coccicheck on a folder.

Changes in v2:
- Give example of folder instead of file
- Add note

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..9c454de5a7f7 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -224,14 +224,21 @@ you may want to use::
 
     rm -f err.log
     export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
-    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd
 
 err.log will now have the profiling information, while stdout will
 provide some progress information as Coccinelle moves forward with
 work.
 
+NOTE:
+
 DEBUG_FILE support is only supported when using coccinelle >= 1.0.2.
 
+Currently, DEBUG_FILE support is only available to check folders, and
+not single files. This is because checking a single file requires spatch
+to be called twice leading to DEBUG_FILE being set both times to the same value,
+giving rise to an error.
+
 .cocciconfig support
 --------------------
 
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
