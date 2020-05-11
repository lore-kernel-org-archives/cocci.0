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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF4DC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4251E20731
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkIw0fsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4251E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADfEm017252;
	Mon, 11 May 2020 12:13:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A5863E6B;
	Mon, 11 May 2020 12:13:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9695F3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:38 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADa3T028407
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:37 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id b12so1826778plz.13
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XNfU37AazQTXdsm61rjVv6iRV4b1Jhh4zyg/a69swbY=;
 b=CkIw0fsBCdESUgVguqzVVIJInBp/IMIuceh6MtwQixRqyEFX8Hqm/XUN2DHvZAxoDC
 0tlGn++7EWgk6XPSRMhykvWx76yf2QuIGTSCoypH7A8PkzQ7H7ohbod9hKVsg4Pi0+6Y
 n7+vT+1FDHX79WJv0Jcv1JDaLQxxe5WkT6J1R2cvnpvBQxuXRWRr4+EhfGwKScCJ1/mb
 LOs5J5fScf05oE+FTHzd6cPK0TMKnt05plOdMzbmpbQV2nydJS8YC/A1y5Lc6br5X28v
 XzPpWcqZ0CeATjIwM720YeMIcnEO3Yg7P9Yelv46xtc8Yv4FggiIibKakQQm/DqcU8h6
 Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XNfU37AazQTXdsm61rjVv6iRV4b1Jhh4zyg/a69swbY=;
 b=VbqdjoVeYerM5BNIhpCS80K3gKS0GOtuONqM8V3LoOOthxq8PRihqcI/rJc1+oQM83
 AbrVLg0yNSg37v0TlpxI3BsFKgmqQbsvOsoDYBrBRzTVs8UrBURu0kJ5KZDw8Uje7hXJ
 zKlCzNyEq+uM316E32OyrwpjE8b3Yz/JYOOeo5qQVtOyngSxikxhM/ZtV37SP30aJErz
 zUQhEvLol9IxSa9xkba7PC+NE65TrS2TZA/J6Voi+38BEU0J2dUg6VZ/lfSaEkgFtDhL
 YeXy4iMC3ar9ngFZqwgoVjDjrZ4pM9s+z/7xep48G+exGqGIt+fil1kllSbpAX7Xk9sd
 +DXw==
X-Gm-Message-State: AGi0PubpFNt2O1M1il0QPwAJEr07/uOx/aUQiVXMY2Mlu4thHz7kAEmM
 HgPls65rl9TBW/IoaSY5cfCqj4skzSo=
X-Google-Smtp-Source: APiQypIyW6t103noNrgr3n2Ve/VfshwUlnEgCMrwCuNFw3v5XZt28/OJo4IqcMzXEHwXejHlh9VAWA==
X-Received: by 2002:a17:902:9693:: with SMTP id
 n19mr14644474plp.277.1589192016275; 
 Mon, 11 May 2020 03:13:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:42 +0530
Message-Id: <20200511101300.11101-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 05/23] parsing_cocci: check_meta: Reflect
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
check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/check_meta.ml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 5a348ba3..0e7e04e5 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -374,7 +374,8 @@ and initialiser_list old_metas table minus =
 
 and parameterTypeDef old_metas table minus param =
   match Ast0.unwrap param with
-    Ast0.Param(ty,id) ->
+    Ast0.Param(ty,id,attr) ->
+      (* No meta attribute yet *)
       get_opt (ident ID old_metas table minus) id;
       typeC old_metas table minus ty
   | Ast0.MetaParam(name,_,_) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
