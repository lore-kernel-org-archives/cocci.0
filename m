Return-Path: <SRS0=z30s=WU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2CC3A59E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 07:14:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B791C2133F
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 07:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B791C2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7O7EAnD002043;
	Sat, 24 Aug 2019 09:14:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C4ADE778E;
	Sat, 24 Aug 2019 09:14:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 82AD8778B
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 09:14:08 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7O7E8l7003566
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 09:14:08 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id v15so10774884wml.0
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 00:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Mq/Ig73tquIRzF5ZKUfK0SatX/kxznbUk0nlsDQ5rgI=;
 b=fRwWcDcD2nly+r0ZuyjWRNb2T3+uNunleCRSBoDBNZm/o68f40Xp4TClt06gYa6304
 0h+nxGyX9I43qyNdunue8fzjHZlxTyhvv/0FWhVPGywBvLXcaarZaicVfdaZbbTH8B5k
 kJPgrVE2KW/+uDSKTIV/RDwc1FFqVUbI+pLA4vaYmOtDVQVdoIdl5vgY3Cfb08OCyX5o
 CC/6seiXhOjd00xkWfzBHGcrZAyZJS2IufNd2sf8zqUnbMf9KMYjI04lc8jRLWEyCWiB
 HEbQaQ+83mjitnRfAUYvWia5BzKzrSzvb9quzZdhKsAKg0llPqDSn+2VOdG4ehqT2Jof
 dT5w==
X-Gm-Message-State: APjAAAWEWwB/Ukz40827lwordV+9I99xOMPx5CPAa/mhjwNvJCq57us6
 9IKAHQCAPk4qgqg/9tx8Nn+4z94g
X-Google-Smtp-Source: APXvYqwLjF7heN6oVcwFJaOdCNOL9844XWMhfxp3W9wXmrc+GRu0ItEOWqscbUd9bugbF0YJWX6iAw==
X-Received: by 2002:a1c:cb0b:: with SMTP id b11mr9529978wmg.128.1566630847684; 
 Sat, 24 Aug 2019 00:14:07 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id g7sm7447127wmg.8.2019.08.24.00.14.06
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Aug 2019 00:14:07 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: Denis Efremov <efremov@linux.com>
Message-ID: <44525ca7-a97b-0858-9131-a97459bac4b5@linux.com>
Date: Sat, 24 Aug 2019 10:14:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 09:14:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 09:14:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Rule for turning !unlikely to likely
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

I'm trying to write a rule for turning !unlikely to likely and vice versa.
However, it's hard for me to understand what is wrong with the rule and how to
make it work. Any suggestions? Do I need to introduce 'expression E;' instead
'(...)'? BTW, spatch hangs with -Dorg.

The rule:

virtual patch
virtual context
virtual org
virtual report

//----------------------------------------------------------
//  For context mode
//----------------------------------------------------------

@depends on context disable unlikely@
@@

(
* !likely(...)
|
* !unlikely(...)
)

//----------------------------------------------------------
//  For patch mode
//----------------------------------------------------------

@depends on patch disable unlikely@
@@

(
-!likely
+unlikely
 (...)
|
-!unlikely
+likely
 (...)
)

//----------------------------------------------------------
//  For org and report mode
//----------------------------------------------------------

@r depends on (org || report) disable unlikely@
position p;
@@

(
 !likely@p(...)
|
 !unlikely@p(...)
)

@script:python depends on org@
p << r.p;
@@

coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")

@script:python depends on report@
p << r.p;
@@

msg="WARNING: Use unlikely instead of !likely and likely instead of !unlikely"
coccilib.report.print_report(p[0], msg)

Thanks,
Denis	
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
