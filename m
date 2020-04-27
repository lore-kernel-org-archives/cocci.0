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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D8C7C8A6
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C473D206E2
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC1P9nbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C473D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9VBc005423;
	Mon, 27 Apr 2020 14:09:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 048B07816;
	Mon, 27 Apr 2020 14:09:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 92D3B7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:29 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9RU7004735
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:28 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id w65so8899516pfc.12
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j1X1BGRFEACGTmkgMLbAYX8AfqdFOueU9TLXrHGZrhc=;
 b=gC1P9nbKWV7TftXMyzOgcakYqTjZppJKuiUonrjLPGvdP5yKWjckaNf9toqKm5gaHa
 LDwNVG9bDh8Zb8KyKGNOrbaQsKo04nWa9+5Ioge63akSyEQEf/nUU0l/WijbArWf/2/Y
 loyEiqe3mCqClLDmQ3RnZouSHNtM90zKMsrjKihCgFz8IQceLB1H9DSrwGJljQi9cxXX
 PBgjdEuHPDcymfRQVzzXqb7Krucfw2RGA0iGw4W/g8wd17FPHnp/ddLGNjB9j9YVwCbT
 w0TSqRPraPBUUEplEjwA2v57N78vtESg3yR860JGeu7aEkdXt9Kciml/V4M6pH8fxUSn
 LkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j1X1BGRFEACGTmkgMLbAYX8AfqdFOueU9TLXrHGZrhc=;
 b=gEt2CErcxXyL9L8Jffdl/APH0mQFkhXe6do3OyT59BkF4ycoIEfhUJwUWv4sZBOfIA
 hZdvu6tPejJAfBbJkhEBfh6zhBvz//cr4h/OiAPHJZSExSvYf9Fdsr2qcGGxViRCh6aY
 7Vt58n8JWMmckUSJeLnG6fXOrCHEaCwzXkunAlOJhQBU6IiE84YNs4Rc3Nh3reRYw7Fx
 X7/cQ4fI6ctEgeDYGwRezj4W3riPEPV7M/vmIGeDdudVD04aNsreUe9UPpRNi719dzTF
 cD6lSeRkOS60k5Pqo9kS6tjrUGim0vo0658uaty1gJPEC4knzUOV7fQF0E0AC1sxSVGe
 lvsQ==
X-Gm-Message-State: AGi0PubRuTtafQ8Qq8tyl7BnQM3saWzI7pxoSo/q56xfkknGQ/5HO/65
 w1E8YSuFQnScNGBvZFxx/E6JIuK0yYQ=
X-Google-Smtp-Source: APiQypKkic0dpqhJ8rytHQQhi0em5iQAMux0paFOLyBaMVuszsT0WvKu+PeqSCTVAAa1TKoMP4CMTA==
X-Received: by 2002:a62:2c92:: with SMTP id
 s140mr12042167pfs.223.1587989367033; 
 Mon, 27 Apr 2020 05:09:27 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:26 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:21 +0530
Message-Id: <20200427120834.380-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 10/23] parsing_cocci: iso_pattern: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
iso_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/iso_pattern.ml | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 9df21fb9..09a39bdf 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -1165,10 +1165,24 @@ let match_maker checks_needed context_required whencode_allowed =
 	if not(checks_needed) || not(context_required) || is_context p
 	then
 	  match (up,Ast0.unwrap p) with
-	    (Ast0.VoidParam(tya),Ast0.VoidParam(tyb)) -> match_typeC tya tyb
-	  | (Ast0.Param(tya,ida),Ast0.Param(tyb,idb)) ->
-	      conjunct_bindings (match_typeC tya tyb)
-		(match_option match_ident ida idb)
+	    (Ast0.VoidParam(tya,attra),Ast0.VoidParam(tyb,attrb)) ->
+               if
+                (List.length attra = List.length attrb &&
+                 List.fold_left2 (fun p a b -> p && mcode_equal a b) true
+                 attra attrb)
+               then
+                 match_typeC tya tyb
+               else return false
+	  | (Ast0.Param(tya,ida,attra),Ast0.Param(tyb,idb,attrb)) ->
+               if
+                (List.length attra = List.length attrb &&
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
