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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243AC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7812080C
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT2wr7BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7812080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAE2Is026921;
	Mon, 11 May 2020 12:14:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B0EB3E6B;
	Mon, 11 May 2020 12:14:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D0773DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:00 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADwqb023412
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:59 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id e6so7551409pjt.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RAztWq6kekRCOkyGvpZmJpf2WO9JzYN+dY+xdc7Ro2U=;
 b=XT2wr7BBRq6hnfBtprxYLqgOV+HkG00GTeyTsIrRKfHq/ybD59R9s0sntPEfWozRr9
 12QUghI6ayhdFa8pYmWVT8c7oRmmUxdZzyCMNyuqj4TUT6aGTJBw+YWFznGhOHSkHg50
 2d97NxwuAYUs6JyAd2rE0ejiIL4be8OwDvL/JVQBBMdKDnQauAzxPSgivZPe7CMyk68F
 qxu+oVvtvbnrRuONsAgVm7EU57IbwuywwFZNxkiem7xzOrsJ5j0qP1CVSrLvxgUgaiR6
 o/WboOccC0VfJwh1gpklsS5UdViufC01AjvqpVICM3bgntrNs3h3ysgsP0sYRrsEJ1nx
 wpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RAztWq6kekRCOkyGvpZmJpf2WO9JzYN+dY+xdc7Ro2U=;
 b=sUCHabIo4b9zFglEhPxzsYlFZesZ58sEXR5jyQtFEehE8RPE47h0IayIellwpSjtm2
 R6s3eLpwP0VvWvU3G81C0PvwA+RsFKrR3lF95d/JkvRchxmIYZILTZ3m01mrvZRtt0XI
 n5g0uVeO1791eT9JtqNeO3c62+oV+tOgT/D4GDuGAQhHjsdGqL82lZABpXfPKNrPXUwY
 Cucxe9XN2ZEmZLdI8rw8rjTK+8BxXeZs96J19x+uJ6BzVX3REG2Wvtrqhi9W0romakSt
 +xmsjXdvt+17BcCoZIXS+ub9YbCKu7AiKEWSr/5NyJMh0XZ92xqSykADclM3gJZwfQSF
 AcmQ==
X-Gm-Message-State: AGi0PuZi5L6wRgxEqk6uB/FY9Mu8svmrUYsfWWNuVX8VwKWvNzHYf1fN
 81+EgQ38rIjqL+k/+54zuMAnalNHxBE=
X-Google-Smtp-Source: APiQypKb+tdlNCP/e4PObvj6HY6AFfG8XRHOJzlyJJnNfE4jc2+UhgolaBJkkT1+CbMks4L6OKBQFA==
X-Received: by 2002:a17:902:728f:: with SMTP id
 d15mr14530110pll.285.1589192038089; 
 Mon, 11 May 2020 03:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:48 +0530
Message-Id: <20200511101300.11101-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 11/23] parsing_cocci: type_infer: Reflect
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
type_infer.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/type_infer.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/type_infer.ml b/parsing_cocci/type_infer.ml
index e8aad810..495d7974 100644
--- a/parsing_cocci/type_infer.ml
+++ b/parsing_cocci/type_infer.ml
@@ -420,7 +420,7 @@ let rec propagate_types env =
       Ast0.FunDecl(_,fninfo,name,lp,params,va,rp,lbrace,body,rbrace,_) ->
 	let rec get_binding p =
 	  match Ast0.unwrap p with
-	    Ast0.Param(ty,Some id) ->
+	    Ast0.Param(ty,Some id,attr) ->
 	      List.map (function i -> (i,ty)) (strip id)
 	  | Ast0.OptParam(param) -> get_binding param
 	  | Ast0.AsParam(param,e) -> get_binding param
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
