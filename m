Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B44C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE09206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4N0QYGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE09206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLDnw012845;
	Sun, 24 May 2020 19:21:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 49E6C3DC8;
	Sun, 24 May 2020 19:21:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 20C7F3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:11 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHL9KB013253
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:10 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id x18so5512689pll.6
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RFL0vX57JLjJtDttGGTwt7+T+8bNhaJb8FQN4BlYQM8=;
 b=N4N0QYGXp7CjNO8TigNGJm2MTSwDmwer7hm/Y1XrdUg6PTF8YG5/Uqhq4vWMp3b+5q
 IKHX6Cbqz0FchzRVABghxU2ciav9C52C8SkBsNnGL1esqhP1OThC0O+FXjPt7eDPaVfx
 RRYSxZ0o+4bn05xYTpF2i4RtyjLxd1SPkYtHyCiQ1vsggYcsbTbD3ZrNDPhtgCc8HK2f
 37xNdXFrxh/tmUJUxqxwpKGguTDprbE8twKsqImY27uOUuTQWUCNkEGxjniYUWvU5TxW
 Rr793l6rY1fbzbQJ78J/D7vOEGMOkpqjGORQsdjCwts4arIzRRlYwXk/pmNN4ltGL+p2
 /QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFL0vX57JLjJtDttGGTwt7+T+8bNhaJb8FQN4BlYQM8=;
 b=brtyxciIivHe7n8D2hdfEXRMvdzb1e6+vpmKnvJjy4yXABOXlSmsBALNre/Vbcaqxk
 0mMI7QEHyTl95OigqmP2k3pvxhJMp4cf5+LU+mOlvgvtlynI4FLpiHhy6LPuVRvpDAm+
 RNjy58YBt12ivar1fiDBnkOP5u27lgugyVEDit+L6aZaz8ugNd3m0JWTxg0STVpIcF2z
 vOf0gQ5Pkkn512h+k25v75oTWbVolWpkVP2watXb5wkj3/jfOQh0ipf8NEmlmvugOc4y
 fLvIUaKyuAv8dpsibc3tLigc7cOWI27zQgERus7KeJ6ygo1pUjyzAeKHU1QBYcbvFUdf
 wsxg==
X-Gm-Message-State: AOAM531o328NOIHT49/uA86WpEdsn0J7QLr8p5Qilm6eRJ5ojWvtIoBL
 MB7sWT5O95vgz0oHVxiV5rwAf0NwaJ4=
X-Google-Smtp-Source: ABdhPJxolzVHTASGt8dbLXaG4SNKgboIkw8mOcKdcMepLrqUar5kwsYRrXflmOmOEVJo5u5ABrYNzA==
X-Received: by 2002:a17:902:7c05:: with SMTP id
 x5mr25121785pll.278.1590340868729; 
 Sun, 24 May 2020 10:21:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:18 +0530
Message-Id: <20200524171935.2504-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/30] parsing_cocci: ast_cocci: Reflect Macrodecl
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

Add macrodecl attributes to the SmPL AST. This is a list of attributes
in the Macrodecl type of the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml  | 3 ++-
 parsing_cocci/ast_cocci.mli | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 9b147e5c..87bd017a 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -399,7 +399,8 @@ and base_declaration =
   | TyDecl of fullType * string mcode (* ; *)
   | MacroDecl of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
-        expression dots * string mcode (* ) *) * string mcode (* ; *)
+        expression dots * string mcode (* ) *) *
+        attr list * string mcode (* ; *)
   | MacroDeclInit of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) * string mcode (*=*) *
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index c56bba88..5d04430c 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -381,7 +381,8 @@ and base_declaration =
   | TyDecl of fullType * string mcode (* ; *)
   | MacroDecl of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
-        expression dots * string mcode (* ) *) * string mcode (* ; *)
+        expression dots * string mcode (* ) *) *
+        attr list * string mcode (* ; *)
   | MacroDeclInit of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) * string mcode (*=*) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
