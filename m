Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF48AC35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 09:27:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231B5207FF
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XthgfK23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231B5207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0199RFas015867;
	Sun, 9 Feb 2020 10:27:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 11DB0772F;
	Sun,  9 Feb 2020 10:27:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 60F807718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 10:27:13 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0199RCI6027488
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 10:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581240430;
 bh=ldyPtOFgiAhGwqbE3fENlzl97k5sVsCCAQ6JNwT5j2A=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=XthgfK235qgx4R90oS2W2Xgs8pjWzDaoumIYPqyyjdmqDyp2n/TZDI0j158kWXIhL
 +NeFLChPLOjeWvv4V7GobXW4iU5Nkd7I62TBwfyxVkqf78UKlA5qashcKjOx8WbBuB
 9YknOgp/ZCJvUZO0KCNXjgyD4Wacy5gbyTg6iDio=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK6mD-1izLxL2gpJ-001RuX; Sun, 09
 Feb 2020 10:27:10 +0100
To: Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <97fc0859-8b23-de06-ad16-6e879bbef4f0@web.de>
Date: Sun, 9 Feb 2020 10:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:8F15Muf5wfN3qiB8ai1w82XHLZ0IxKoIyN/eyF8BhbqsgghWHay
 kyA8zF51jJzdUCRX8Rha9iYvCD1e/eWvPT9n+qdrtCxl9ZyDjzEJ0rr7tRDlphq6SX6/t5w
 CwnUHl0aHwKGzGQMFz13yY2QV1A8THTQETJNIUTK2UCBEokDsp/JNsU/SpBqq1G2vVkfplG
 foz5L85tFlgdAL5TdcIdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZIXlQMZLPOk=:xfcWBtnTeJ1RQ7v7nGnFGT
 70Q34ZRL49VMcSwYP5ZBA9sNErbf8WKUxndhdVCWYDZlh/SrLSzE1Ke6N+55MiO3RaEp6PN5Y
 hh1pJeyz2juR5dsLAyA63uLXYDkP6MYWHp0VO6UwRjPH5vJu9kPHcPKrBvPzQ0MH1fQDU6Cgm
 emPFMs7GOOFin1KliuTDHvoUE3cw/lV59hrnk6j/l2rY8Ba1LayMeFKuWhXzj2dHBaSY0KoAI
 180cvxMk83p8q86nDy9H1mK/YWhMvEcjxK5qMd+Ybbatn/KG+DwMi9sTVu1JAO9NoNf4SJYH8
 BSn4pT+6vrHlpuYzdPdA9T3uSDlohTkyq7vEIjaWsVHJmatKN83sAXkaIeZt3NLUg12RO1nOj
 VobIcaenzfMvi/Pw21utPfMxMkvHhIE1YRzbgCalddRr8XBT9qWn76PmAxJYaqeu24lfNeIhf
 MWVm0O1pzOku2V28DtTeGs5Mc7b0MuQbqreVzfaVbMRW9lcaZxjKxS+IOeX5Hn0VZ7TxNHVhO
 UrhXSjSIDcTpek9IR35beeeM66XZvAnJ4Q+v7yVkrut9UxHgdumHgNTYOmdimYzCv+Hlc++OO
 L9CphxIVT/Ob1610JtlO8zBtwMjDwSGaEFR7xmPXJpSsChCPXg7IG99dUTfU8cHnzimHldK/R
 bdJpukM2LDAqzf1b7fj0klFjztNZ8DL4rjBrW+W8rhSomDRjlRcJ4iBvF6WwmjZ7k+pefskCI
 yPlFoWzWEHXwwPjQaHGCHJGAQCw/K+wKhRGraSSpvct+sGqf3Dn+Sg+MDn3VQnbTImKWINL/6
 8AB+Nf9X7BNFFMrYjfnQaar1dXCpXlkvbVXzTZb+ySLrzI7X3UfbZ7ea3oRZAchNDh8R4EIv2
 CWLfSe9y0ljSudmBnkrtMBIIRiiLcCYNVDdUQvrwFUl6jIvr2y5XqoOCw5F/rjhka0JiHYMXD
 D1IaYdJPvrQ37MkrOSH191pUpsX7sa3mg+CC9/zjLOyJk+m2Vq33UB6XNBRcY9o06URGZmIn8
 F7I83kADYVaaq8kmoStDP6OPmDnOod47ixe1PAATijLB6Q8OGWr4bqkDL8syIRuTaK8KKuzxh
 xvxsRYlBW6PCwC4lbd/BIw3mchAOy0RXx+A/is3u169APRYyuI+uhF45W6K4uHWnrIh9rUxmP
 JaHlNziz4CoxZZ9LZHpnqsIKzYuyQjlvmNQ0ZILimXzkSFaaglt/vj+rmVGZ9ks4vHD63ANWt
 BYyNXP7w2fvcAdNoS
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 10:27:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 10:27:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [v2 1/2] parsing_c: Align C AST and Coccinelle AST for
 pointers
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

> +	const char *const *y;
>  }
>
> There should be a space between * and const on the + line.

Will such a detail become more interesting for the clarification
around coding styles?
https://github.com/coccinelle/coccinelle/issues/37

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
