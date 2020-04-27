Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D074C5519C
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB4D20656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHWORw8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB4D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC93Qj018567;
	Mon, 27 Apr 2020 14:09:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF7C0784A;
	Mon, 27 Apr 2020 14:09:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D6BE37842
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:00 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC8xom009165
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:00 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id z1so7231746pfn.3
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wngLDj53d40UAfdANhcc9OYS/iaJ7M2lYJl5+hepAbA=;
 b=SHWORw8A+X8MbykBOpeWbwOVXnMRr5fajTUNRT7aoC5wrob22en+gjPSB2qzBCWB5Y
 sRyfOSXLQMbHMF1SGKzU7MubTTDlvXhnhHYRc6rqHgXHl/0I0AsKVxRpajolNlErk/PI
 NJDGMWCdrL5PvpJdhvKlIDbT4xT9Fsw7Y25UpUlA5+SRTh9gbvTiBlFFZQNQwLTp3wSE
 Cc45kx1Kn/5o8OzO5tqBoeg8VgBTxlQuwY7ENEivgA2yEWRt205o+ECLAOg6BQkgyuUu
 jcWv+y5xzzXqP5I19CHk6BgW4t2NLNWJJVJQl1diH6rv5V5c0DG+FgPgKZumm7GRF1Qd
 ieXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wngLDj53d40UAfdANhcc9OYS/iaJ7M2lYJl5+hepAbA=;
 b=qoiy2ZWdz5dOZDkuLTxZIQq9/s+4SAS/mWEUqmJ8/yQoB0TKm/cTX0diYSy0ZWiD7i
 q+zRwBhiQhZtJXeGg8zOogzhiJZO1QYWq5NyhXLvaCZaQCGHZZtusfoj83qxL8veaudG
 Trflv8Ilmkpzipckiv+pX/w2poq7sH0mplcZOwAKEjLZq+DV/htDYgj/NsFSz2fWgL+j
 1auSn2/+k8/KMZPdhMjgfUQatsFheORRUd4CvCyacYmgNxCdiGdgx4sg01I1oXmZhcrN
 ItjgW4on8xAfQyXkUIFodd1V6PVuKFw5a+vAsdVdL6AyZ1jS4/kcTytohJgr/lJ6/nt/
 SbLg==
X-Gm-Message-State: AGi0PuavDjJK0cHz4eMAxjn/a7e0yCjt3nlUasSr5E1Ei7nX+iE+yiZ3
 FzwWQRUhILqKsi4hqZAbs0Ze5k1aqO8=
X-Google-Smtp-Source: APiQypKv63AQTek8l5LmtHZ62UfZtsz/4MO6iymzhS3CdL/AE93h6+5GNGaPCydxB2uNJTL/Pde93w==
X-Received: by 2002:a63:1c1:: with SMTP id 184mr23605882pgb.203.1587989338140; 
 Mon, 27 Apr 2020 05:08:58 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:08:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:14 +0530
Message-Id: <20200427120834.380-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 03/23] parsing_cocci: visitor_ast0: Visit Parameter
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

Parameter attributes are added to AST0 of SmPL. Visit these attributes
in the AST0 visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast0.ml | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index d9e340ed..d6feccb7 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -826,14 +826,18 @@ let visitor mode bind option_default
     let k p =
       rewrap p
 	(match Ast0.unwrap p with
-	  Ast0.VoidParam(ty) ->
-	    let (n,ty) = typeC ty in (n,Ast0.VoidParam(ty))
-	| Ast0.Param(ty,Some id) ->
+	  Ast0.VoidParam(ty, attrs) ->
+	    let (ty_n,ty) = typeC ty in
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+            (bind ty_n attr_n,Ast0.VoidParam(ty, attrs))
+	| Ast0.Param(ty,Some id,attrs) ->
 	    let ((ty_id_n,ty),id) = named_type ty id in
-	    (ty_id_n, Ast0.Param(ty,Some id))
-	| Ast0.Param(ty,None) ->
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+	    (bind ty_id_n attr_n, Ast0.Param(ty,Some id,attr))
+	| Ast0.Param(ty,None,attrs) ->
 	    let (ty_n,ty) = typeC ty in
-	    (ty_n, Ast0.Param(ty,None))
+	    let (attr_n,attr) = map_split_bind string_mcode attrs in
+	    (bind ty_n attr_n, Ast0.Param(ty,None,attr))
 	| Ast0.MetaParam(name,constraints,pure) ->
 	    let (n,name) = meta_mcode name in
 	    (n,Ast0.MetaParam(name,constraints,pure))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
