Return-Path: <SRS0=A19M=S7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBCC43219
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 06:06:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1572075E
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 06:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1572075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3T6669O002312
          ; Mon, 29 Apr 2019 08:06:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D9A77741;
	Mon, 29 Apr 2019 08:06:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC9347732
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 08:06:04 +0200 (CEST)
Received: from mail.osadl.at (178.115.242.59.static.drei.at [178.115.242.59])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3T663fD011725
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 08:06:03 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail.osadl.at (Postfix, from userid 1001)
 id 3B2585C0B38; Mon, 29 Apr 2019 08:05:12 +0200 (CEST)
Date: Mon, 29 Apr 2019 08:05:12 +0200
From: Nicholas Mc Guire <der.herr@hofr.at>
To: cocci@systeme.lip6.fr
Message-ID: <20190429060512.GA16251@osadl.at>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 29 Apr 2019 08:06:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 29 Apr 2019 08:06:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] detecting false positive sparse with coccinelle
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


Hi !

 I'm trying to detect false positive sparse messages by taking
 the pattern and scanning with coccinelle for it so that the
 fix could be generated. Basically the identification seems
 to be working (a type-check on var is stil missing - but thats
 a different issue) - the problem though is that I'm unable
 to insert the (__force __be16) cast in the patch rule as 
 coccinelle is refusing hose lines. Any hint how that could be 
 done or is the problem the syntactic oddity of having a 
 unknown keyworkd followed by a type that is confusing coccinelle 
 here ?

thx!
hofrat

virtual report
virtual patch

@acheck depends on report@
identifier var;
position p;
@@

(
* var = be16_to_cpu@p(var);
|
* var = be32_to_cpu@p(var);
|
* var = be64_to_cpu@p(var);
|
* var = le16_to_cpu@p(var);
|
* var = le32_to_cpu@p(var);
|
* var = le64_to_cpu@p(var);
)

@script:python depends on report@
p << acheck.p;
@@

msg = "forced endiannes annotation needed"
coccilib.report.print_report(p[0],msg)

@afix depends on patch@
identifier var;
position p;
typedef __be16, __be32, __b64, __le16, __le32, __le64;
@@

(
- var = be16_to_cpu@p(var);
+ var = be16_to_cpu((__force __be16)var);
|
- var = be32_to_cpu@p(var);
+ var = be32_to_cpu((__force __be32)var);
|
- var = be64_to_cpu@p(var);
+ var = be64_to_cpu((__force __be64)var);
|
- var = le16_to_cpu@p(var);
+ var = le16_to_cpu((__force __le16)var);
|
- var = le32_to_cpu@p(var);
+ var = le32_to_cpu((__force __le32)var);
|
- var = le64_to_cpu@p(var);
+ var = le64_to_cpu((__force __le64)var);
)

@script:python depends on patch@
p << afix.p;
@@

msg = "forced endiannes annotation added"
coccilib.report.print_report(p[0],msg)
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
