Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A95C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EAF20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFDVE2r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EAF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADwND006490;
	Mon, 11 May 2020 12:13:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 024E93E6B;
	Mon, 11 May 2020 12:13:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CF8DD3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:56 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADtrP002265
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:56 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so7622454pjb.3
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xr9Q/5CorFjVOqOySFb3h8LfcOwM0kMg5W/Qt/usuXI=;
 b=hFDVE2r4JI1sIJ0k1DZZzWuG15R/8UKyQLIGNw+iO56ULJlijVwZmFgrIwEmKzcAX/
 0PyQeN5WuaQoatVtCzqpdEfcgRTMlANbO+NQgX1uvQYmmqQ91N2TsNLsSnwhlfoG//QE
 5d4SAL691vYFKRFgW8T/IymZOtTo7RiBm1G9U2McG8DbfupMXpLgx5qs0S+Aj2rUyD5j
 NawVJPJCQaxaxjjQ3XUW5ypGloFmyeiljcRJZmXgUhtHUaWif517jR9jEq/WrUX2SikS
 FOByQfC7d8T/diqJQWMrcgIDLGVfkfTljADym6b7rASKd79I9uTfdHoia65Qrkux6MhC
 OUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xr9Q/5CorFjVOqOySFb3h8LfcOwM0kMg5W/Qt/usuXI=;
 b=WX+pJGN9igvJTTLI0cUNHjb2DPMpWSxOsDUYr+ye0eN7ymROv6qRntiofE+FMngW7G
 5tB+zOBI7/yajQ7GeggHDOmv/Z801ecqHoeAFtLncjRqaw8T94Bfe9IZbvK9V7SXCkEN
 4obXWv5Z6+pcstUXICxJqLWWvuZrnHVmVo+eIo4d7A3i6zby6WKOWyg7JdlENIG1AFta
 T1+AJ27362LKru6CdHd/n7aylZhHfDBZq682Tu5Ak+TFMjwZtDybZbKaacQpBpeIynDH
 HrfhY4552We3qGi1SHGcCe5by5bVOnvOtHGmSEG41TVkEenmSpr4eSp9A6D9yzDs9jze
 MOAw==
X-Gm-Message-State: AGi0PuYtqvHLRUmU0JfGTQixxW4b3ngFVTAJUetUTfvHiqZzGhkJ+NaA
 msrxfVjCOUQiV3mNeETV9vgUQlSmxN0=
X-Google-Smtp-Source: APiQypLw2Wk8E86ebjVmldmg3y4xEreqh4k04FDDP/PW2AEPgwn+MTBmR92MjTg8DszIIC31ZKJZEA==
X-Received: by 2002:a17:902:7082:: with SMTP id
 z2mr14037704plk.317.1589192034431; 
 Mon, 11 May 2020 03:13:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:54 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:47 +0530
Message-Id: <20200511101300.11101-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:58 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 10/23] parsing_cocci: iso_pattern: Reflect
	Parameter attributes
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 9df21fb9..b751f3e8 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -1165,10 +1165,22 @@ let match_maker checks_needed context_required whencode_allowed =
 	if not(checks_needed) || not(context_required) || is_context p
 	then
 	  match (up,Ast0.unwrap p) with
-	    (Ast0.VoidParam(tya),Ast0.VoidParam(tyb)) -> match_typeC tya tyb
-	  | (Ast0.Param(tya,ida),Ast0.Param(tyb,idb)) ->
-	      conjunct_bindings (match_typeC tya tyb)
-		(match_option match_ident ida idb)
+	    (Ast0.VoidParam(tya,attra),Ast0.VoidParam(tyb,attrb)) ->
+               if (List.length attra = List.length attrb &&
+                 List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                 attra attrb)
+               then
+                 match_typeC tya tyb
+               else return false
+	  | (Ast0.Param(tya,ida,attra),Ast0.Param(tyb,idb,attrb)) ->
+               if (List.length attra = List.length attrb &&
+                 List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                 attra attrb)
+              then
+	        conjunct_bindings (match_typeC tya tyb)
+		  (match_option match_ident ida idb)
+              else
+                return false
 	  | (Ast0.PComma(c1),Ast0.PComma(c)) -> check_mcode c1 c
 	  | (Ast0.Pdots(d1),Ast0.Pdots(d)) -> check_mcode d1 d
 	  | (Ast0.OptParam(parama),Ast0.OptParam(paramb)) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
