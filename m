Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3AC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 13:29:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CC6207D3
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmBP15RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CC6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SDTP24004820;
	Thu, 28 May 2020 15:29:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 795BB5D47;
	Thu, 28 May 2020 15:29:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5200C3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 15:29:23 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1033])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SDTLg7025460
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 15:29:22 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id nu7so3195890pjb.0
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ybrw4d0qDrvTtH6DtVXlHFKkdQmZlLr8NfVR0nG8lk=;
 b=GmBP15RZP8dNDfsFtFdmNdCl+WMTZuYp+6Q6XeQQZcAmjsXb+cFnPj+PckohUCGYx6
 MsOgeBBJIIolQ4d1yQCp1jHR6CJOLcNoGCEkJZSrivH+QoBDWj6U1G4mlLc1han0ZhP/
 1yZfUQ+f5wQDbc0IfJREFS38B4Bq1RtkeiVGz2/ALmf4y06QbnuE29HeZoUzFyYat1iz
 uZ/fah7+a8dKZ2ht0aCRt5CTADl8jpfPi9aMhwkLoX9V6fnGVhhrSMNkKsSaCQgPXNxA
 /eLsfIg98nWfzmwCaXkX3hnKq0b+2AkQokEhYrkxTHQy2/ezaH6YK1ryJoRbNIxm5b2u
 mYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ybrw4d0qDrvTtH6DtVXlHFKkdQmZlLr8NfVR0nG8lk=;
 b=E+II7u7EDMHVZ/WoZfhT4t12sSJ8JisA89HP7p1EAViduWH86/xIK0adygLPFsjsz4
 MS1IHfESJy0/Xbl+d5hAoF6f4n/eoTSaox3liOINuiG/Y8YI/Fn0ggjmT+7CKuoIyOwp
 bdRlXWvqrTofiTKrkpEAeoUUjpmOP6cEbmdFbEpF/8mRrEcQa9IuM/48+G+NhX2hYlZ6
 nhMblhAa9mzg88stIevHFFHTLEL/f3zzLYOPafoXKQhvqsWxBw+C5C0SyCZFuiOK6her
 sWxYLRD6PpoPkvDFeL8BgMs3rAk2QFWOrl+XM9PzAFT7Wv2yankn2gH0IC28doLhPupg
 tgOg==
X-Gm-Message-State: AOAM533c01TsqHW1VPKP2gnnyW3l++lD+0hpTQVtI7BsQkvapgJ7RkHT
 YKjvDBwPsUGPTVnPtyUWYEk4Vp/v
X-Google-Smtp-Source: ABdhPJxyOanuzVl3ul25CHykua+eGvKazg+6n3Uvgvp5BFlRRKVnU4lH4Qq854Ka4uwLZXK468i8tA==
X-Received: by 2002:a17:90a:4f42:: with SMTP id
 w2mr3915125pjl.74.1590672560621; 
 Thu, 28 May 2020 06:29:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id b19sm4688422pfi.65.2020.05.28.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 06:29:19 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 18:59:06 +0530
Message-Id: <20200528132906.25492-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 15:29:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 15:29:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 20/25] parsing_c: parser: Place parameter
	attributes in C AST
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

Parameter attributes are needed so as to not break the nocast test case
when attributes are fully supported. Add parameter attributes to the C
AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
Changes in v3:
- Remove the "attr is ignored" comments in the declaratorp rule.
- Place the attributes from the "declarator attributes" production
  in the declaratorp rule in the C AST as well.

Changes in v2:
parsing_c: parser: Add attribute production in spec_qualif_list
- This patch applied on its own causes a build error. Fix the error by
  removing the let binding for abstract_declaratort in the type_name
  rule

parsing_c: parser: Make abstract_declarator pass attributes
- Reflect changes from the above build error fix.

 parsing_c/parser_c.mly | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 57528dfc..b7e74506 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -857,7 +857,7 @@ new_argument:
      { let ty = addTypeD ($1,nullDecl) in
        let ((returnType,hasreg), iihasreg) = fixDeclSpecForParam ty in
        Right (ArgType { p_namei = None; p_type = returnType;
-			p_register = hasreg, iihasreg;
+                        p_register = hasreg, iihasreg; p_attr = [];
 		      } )
      }
  | new_argument TOCro expr TCCro
@@ -1447,23 +1447,28 @@ parameter_decl2:
      { p_namei = Some name;
        p_type = mk_ty NoType [];
        p_register = (false, []);
+       p_attr = [];
      }
    }
  | decl_spec declaratorp
      { LP.kr_impossible();
        let ((returnType,hasreg),iihasreg) = fixDeclSpecForParam (snd $1) in
-       let (name, ftyp) = $2 in
+       let attrs = (fst $1) @ (fst $2) in
+       let (name, ftyp) = snd $2 in
        { p_namei = Some (name);
          p_type = ftyp returnType;
          p_register = (hasreg, iihasreg);
+         p_attr = attrs;
        }
      }
  | decl_spec abstract_declaratorp
      { LP.kr_impossible();
        let ((returnType,hasreg), iihasreg) = fixDeclSpecForParam (snd $1) in
+       let attrs = (fst $1) @ (fst $2) in
        { p_namei = None;
          p_type = (snd $2) returnType;
          p_register = hasreg, iihasreg;
+         p_attr = attrs;
        }
      }
  | decl_spec
@@ -1472,6 +1477,7 @@ parameter_decl2:
        { p_namei = None;
          p_type = returnType;
          p_register = hasreg, iihasreg;
+         p_attr = fst $1;
        }
      }
 
@@ -1483,12 +1489,13 @@ parameter_decl2:
 parameter_decl: parameter_decl2 { et "param" ();  $1 }
 
 declaratorp:
- | declarator  { let (attr,dec) = $1 in (* attr gets ignored *)
-                 LP.add_ident (str_of_name (fst dec)); dec }
+ | declarator  { let (attr,dec) = $1 in
+                 LP.add_ident (str_of_name (fst dec)); attr, dec }
  /*(* gccext: *)*/
  | declarator attributes
-               { let (attr,dec) = $1 in (* attr gets ignored *)
-                 LP.add_ident (str_of_name (fst dec)); dec }
+               { let (attr,dec) = $1 in
+                 let attr = attr @ $2 in
+                 LP.add_ident (str_of_name (fst dec)); attr, dec }
 
 abstract_declaratorp:
  | abstract_declarator { $1 }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
