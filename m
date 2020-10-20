Return-Path: <SRS0=QPwM=D3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1AC433E7
	for <cocci@archiver.kernel.org>; Tue, 20 Oct 2020 09:38:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E3C20691
	for <cocci@archiver.kernel.org>; Tue, 20 Oct 2020 09:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3C20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09K9cGxq022141;
	Tue, 20 Oct 2020 11:38:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F3F6C75B4;
	Tue, 20 Oct 2020 11:38:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6239845D8
 for <cocci@systeme.lip6.fr>; Tue, 20 Oct 2020 11:09:27 +0200 (CEST)
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09K99NEB028230
 for <cocci@systeme.lip6.fr>; Tue, 20 Oct 2020 11:09:26 +0200 (CEST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 3EE7920D36A57E62FF7A
 for <cocci@systeme.lip6.fr>; Tue, 20 Oct 2020 17:09:21 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 20 Oct 2020 17:09:21 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 20 Oct 2020 17:09:20 +0800
To: <cocci@systeme.lip6.fr>
From: Peng Liang <liangpeng10@huawei.com>
Message-ID: <ab7c6405-6384-9454-1219-08666b51c5c7@huawei.com>
Date: Tue, 20 Oct 2020 17:09:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 20 Oct 2020 11:38:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 20 Oct 2020 11:09:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 20 Oct 2020 11:38:14 +0200
Cc: xiexiangyou 00584000 <xiexiangyou@huawei.com>
Subject: [Cocci] spatch issue with compound literals
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

Hi,
I tried to use coccinelle to add an empty element to compound literals
using spatch version 1.0.8 compiled with OCaml version 4.10.0.

Here is my script:
@@
identifier a;
identifier fld;
expression E;
@@
 struct A a = {
     ...,
     .fld = (struct B[]) {
         ...,
         { ..., E, ... },
+        {  }
     },
     ...,
 };

And I received the following error:
minus: parse error:
  File "add-end-of-list.cocci", line 8, column 21, charpos = 97
  around = '[',
  whole content =      .fld = (struct B[]) {

Am I missing something?

Thanks,
Peng
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
