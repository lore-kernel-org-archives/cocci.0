Return-Path: <SRS0=0tLN=2G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADDC43603
	for <cocci@archiver.kernel.org>; Mon, 16 Dec 2019 16:28:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2187B206D7
	for <cocci@archiver.kernel.org>; Mon, 16 Dec 2019 16:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2187B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=knosof.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xBGGRqSY013754;
	Mon, 16 Dec 2019 17:27:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A872A77DD;
	Mon, 16 Dec 2019 17:27:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D537A77D2
 for <cocci@systeme.lip6.fr>; Mon, 16 Dec 2019 17:27:50 +0100 (CET)
Received: from know-smtprelay-omc-11.server.virginmedia.net
 (know-smtprelay-omc-11.server.virginmedia.net [80.0.253.75])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xBGGRng5007626
 for <cocci@systeme.lip6.fr>; Mon, 16 Dec 2019 17:27:49 +0100 (CET)
Received: from [192.168.1.201] ([82.2.1.89]) by cmsmtp with ESMTPA
 id gtDoidVva6HGqgtDpiUjiK; Mon, 16 Dec 2019 16:27:49 +0000
X-Originating-IP: [82.2.1.89]
X-Authenticated-User: dmjones@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=d/JBNirE c=1 sm=1 tr=0 a=WPUjqzW0G8tv1tco57yGEQ==:117
 a=WPUjqzW0G8tv1tco57yGEQ==:17 a=IkcTkHD0fZMA:10 a=kYD52I4EAAAA:8
 a=pxdNzhGcAAAA:8 a=wKC-sUEZuKkF5-w_Kl4A:9 a=QEXdDO2ut3YA:10
 a=6UCLHkHsjq5DW36378aM:22
To: cocci@systeme.lip6.fr
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
Message-ID: <a4eb7a06-6890-aaad-499d-e3e2c2899dce@knosof.co.uk>
Date: Mon, 16 Dec 2019 16:27:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Language: en-US
X-CMAE-Envelope: MS4wfHnqlRMw4+HoGLXeYjA3UK/2PEpoeCqW350fZCF0gX6mdPC6pMETgYE/Nb26YkCMxkr33LKHPyI9QhMAlCLvSgKRPIYW83qjno626Xp5kmq9pIES9P8U
 MfbFWXwrOGOXQwch+/6EYEUlD/jKT6Gi7f9xkyHypxsE6qNwWDnm6Sce
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Dec 2019 17:27:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 16 Dec 2019 17:27:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Automatic program repair workshop in London
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

All,

Papers We Love is running a workshop in London on automatic program
repair, and Coccinelle's very own Julia Lawall is speaking:
"Coccinelle: 10 Years of Automated Evolution in the Linux Kernel"

The date is 19 January (a Sunday afternoon).  Sign up (it's free) here:
https://www.meetup.com/Papers-We-Love-London/events/266943387/

-- 
Derek M. Jones           Software analysis
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
