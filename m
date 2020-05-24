Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377DDC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA907206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjH5trZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA907206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLuQb023026;
	Sun, 24 May 2020 19:21:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 34ECD3DC8;
	Sun, 24 May 2020 19:21:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E7C063D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:54 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLrMf020636
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:54 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id a5so7588713pjh.2
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jz3lWMt4CYhyOafD0/4S2N0AqmLaZCBO+DnEOpOB/6E=;
 b=OjH5trZQ/Nlr8u+XaieE9cJnCFcur8YKd0LIVeWil7iEf4U/oheiSZEPG/KuuxuVK2
 w3G1eT8hWr/1c23WY6dpYJRVb2dNxiGiOIkP04eIy+t7/Hb83+U90wCsFpbzSt61PudR
 NdVpEOX5i+L/+5dygFA/JUwSniFiUHCQHuQlKFLthcw52a6zy+c4pjRVx9iSDzKVXtRj
 a4G/xTYVaeTUqEMaDgtViwOXDL3WS2qwpLd3VuP2HfUc/cY/CFtpNqFBhOfyn3rDEV/7
 2m3HFd50FZB8nfz6Q73ZHDSITfbHQOyZmqIIX3smgqnKEyZSRbvKTIRBIn5r5ee1LFOg
 E3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jz3lWMt4CYhyOafD0/4S2N0AqmLaZCBO+DnEOpOB/6E=;
 b=AbXS6pY4GMtT9/jk+g+2BSnmCvsTtf3oWIxs+4IwcXU0dra/Y/iqVTSLfuzQYJZ/IA
 zxVY5WF0VZgOeUh77Cs7laH7K+LixJBrtjDCTRfM9w6TCfqwmGyZGgsQOkLWmyq4xAZZ
 2R2CsQ4R1WUbyEd+CwOeEqTymCHwF4r8a0Pp6DEBDhBAazCaChk4H6mb6gm0RZ3nSwNn
 3hNcPEjUo4Alm4RN0ngB5IIpEhTn8UjYSlAyMZJfFveb/R3j4R11u5+vRNtSj6DGt9Rb
 yOb9pPtGCa56TFt7B8XEiJIakolm6DxBHciOq3BBvp63tkGSX3iEe+imjdZ3F7K+hVpb
 rkQg==
X-Gm-Message-State: AOAM5308EYkj4f3KgHZB9+VW++Veu3QV8mOgOG1iZmac7Qm/W4wCQhk9
 9m5ucIx31Gz+U/tV/pmtsaORcv9pRQg=
X-Google-Smtp-Source: ABdhPJx/P06ssciFFaifgHQMCkEZayOlzFB8lki51diJaIDLQ4lOG0PlHNRA3lfa6c6BlzJyzY5u5w==
X-Received: by 2002:a17:902:6ac2:: with SMTP id
 i2mr24980813plt.18.1590340912479; 
 Sun, 24 May 2020 10:21:52 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:26 +0530
Message-Id: <20200524171935.2504-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 21/30] parsing_c: parser_c: Reflect Macrodecl
	attributes
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

Macrodecl attributes are added to the C AST. Parse these attributes in
the C parser and place them in the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index aedde179..dadf675f 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1600,10 +1600,11 @@ decl2:
        match $1 with
 	 Some (sto,stoii) ->
 	   MacroDecl
-	     ((sto, fst $2, $4, true), (snd $2::$3::$5::$6::fakeInfo()::stoii))
+             ((sto, fst $2, $4, [], true),
+              (snd $2::$3::$5::$6::fakeInfo()::stoii))
        | None ->
 	   MacroDecl
-	     ((NoSto, fst $2, $4, true), [snd $2;$3;$5;$6;fakeInfo()]) }
+             ((NoSto, fst $2, $4, [], true), [snd $2;$3;$5;$6;fakeInfo()]) }
 
  | storage_const_opt TMacroDecl TOPar argument_list TCPar end_attributes
    TPtVirg
@@ -1611,10 +1612,12 @@ decl2:
        match $1 with
 	 Some (sto,stoii) ->
 	   MacroDecl
-	     ((sto, fst $2, $4, true), (snd $2::$3::$5::$7::fakeInfo()::stoii))
+	     ((sto, fst $2, $4, $6, true),
+              (snd $2::$3::$5::$7::fakeInfo()::stoii))
        | None ->
 	   MacroDecl
-	     ((NoSto, fst $2, $4, true), [snd $2;$3;$5;$7;fakeInfo()]) }
+	     ((NoSto, fst $2, $4, $6, true),
+              [snd $2;$3;$5;$7;fakeInfo()]) }
 
  | storage_const_opt
      TMacroDecl TOPar argument_list TCPar teq initialize TPtVirg
@@ -2265,7 +2268,9 @@ cpp_other:
                    ($5::iistart::snd sto)))
        else
 	 Declaration
-	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$5;fakeInfo()]))
+	   (MacroDecl
+             ((NoSto, fst $1, $3, Ast_c.noattr, true),
+               [snd $1;$2;$4;$5;fakeInfo()]))
            (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
      }
 
@@ -2295,7 +2300,9 @@ cpp_other:
                    ($6::iistart::snd sto)))
        else
 	 Declaration
-	   (MacroDecl((NoSto, fst $1, $3, true), [snd $1;$2;$4;$6;fakeInfo()]))
+	   (MacroDecl
+             ((NoSto, fst $1, $3, $5, true),
+              [snd $1;$2;$4;$6;fakeInfo()]))
            (* old: MacroTop (fst $1, $3,    [snd $1;$2;$4;$5])  *)
      }
 
@@ -2321,7 +2328,9 @@ cpp_other:
  /*(* TCParEOL to fix the end-of-stream bug of ocamlyacc *)*/
  | identifier TOPar argument_list TCParEOL
      { Declaration
-	 (MacroDecl ((NoSto, fst $1, $3, false), [snd $1;$2;$4;fakeInfo()])) }
+	 (MacroDecl
+           ((NoSto, fst $1, $3, Ast_c.noattr, false),
+            [snd $1;$2;$4;fakeInfo()])) }
 
   /*(* ex: EXPORT_NO_SYMBOLS; *)*/
  | identifier TPtVirg { EmptyDef [snd $1;$2] }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
