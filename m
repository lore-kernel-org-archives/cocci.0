Return-Path: <SRS0=iFQY=6H=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4457C54FCB
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293F6206EC
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2020 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="X7lfJqmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293F6206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03NFNlki019449;
	Thu, 23 Apr 2020 17:23:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E5A7E7815;
	Thu, 23 Apr 2020 17:23:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 115FF7763
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 17:23:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03NFNi4q020362
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 23 Apr 2020 17:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587655411;
 bh=M4+W1USca9HVX4Azy30pfv+90wRipbT6lbsENz2hjLE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=X7lfJqmckIqrzVGF8Ua8MYRnMuAHeg7JRJc3NiXdXXZDdvsLJslU1gyRhusrShVWM
 QwG+JhBkfsdkJ1mA4n1GWJOUoQGIWOwWaLD1QoWesfmq/oqVhjz5Se35l0W+uvX7G/
 OeVTU2JoNoggBqkRSigX5yaPwxZruirJARcvxhtc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.235]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtFAh-1j3cSW1x8N-012lEi; Thu, 23
 Apr 2020 17:23:31 +0200
To: Dejin Zheng <zhengdejin5@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
Date: Thu, 23 Apr 2020 17:23:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423142909.GB1562@nuc8i5>
Content-Language: en-US
X-Provags-ID: V03:K1:I25rebWPlVXPKQRAe55ebCQcs7veEq7l6aFHkXrgRw7EUlk9SwD
 HgMOlxkXVFe9XYv/FIdjuIJV8fhn6BItJ02BaMHD92JBxUWd1xGyycKcI2Z/Q5ldqeCmgXw
 7dXbBhC8v7ddRXO2YSf78ATIXoAYemzl1Zx4KwGFb30cTVPZndDhV5tByiH+w728LF7wA+y
 /BcsiBgtPYMHCGzbMoABA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OXXHy57w/qU=:6qxJ8NG+o0pbnqSZCEl215
 4d+khhyja+zyuz1vcTiizHh/q7uob/WMBIgfqcF+BUMdsyR1Za3+E3cIq1sn/wJut/8iP8Q4d
 lW21wgVA17HbIBO4sKVk3hGJfT34B26XamcnxKVcMEovAfPBgmsEviu+b4DSm5cJOOsuzxs79
 efWE8tkraY8TetcCqX/oGl61h/RYajFPt9Ejxr5RHTFVwGNN/cCncV397eVU39dQiTGyR+Qy0
 rZ/KywoluAI2Se/yAYOlXqaZXGkv2ZQUOfG7fz/j1pj5yLjMI/sOF4UveG/KKFt1ZyE3BHIEk
 8oLrK9+bv52eRgBhrVCDnDnXK8QTg/9l9KunAoL8YzKgujwiJuUFwSASj1tAFt2KKkEb2uBKF
 VSQbq2leQxo4+i865JDBUji5B8pVHMsxZo3m0HNeTgXgy57aDh4oow7A3IvB8UT2z0WY16hkF
 QVDC71DThevQp5qRwhu3olLx7qWLdWWu/X4FHuSBCEqPDyR8mpfF0IRJwxipUnTTiZIc1xHIf
 XEaXLu410qnBIfDi5SeEz4wVrRTpV3v03e03nGB+3Jxc0DXAQcL7WQLRC7m49RBjlNmg+rXjJ
 78Svc6IvYsrC9G1IOt8sdNGbWruYzDCHDj7EbRlpE8++b1t65eVrjlD3xw2ZtdNUHTw0RTIrr
 Fy5AsujnAhPIbRbRMLfgc6KO8JXDyEBwY/Suhle/4gLzL7D/xH71GbuB/BUkB6iRy2T+qXTO9
 o/zzaDE52l8jDYInr4TmSKKEt1rIdm8EfKk5JtdEQfhR/Jurq8d995sffEgrzt8t+Dt87FWkv
 fz918D9e3j78anlwGUgpu1YjDsIpFio7Y4xsjdFgr7Ixizin7Zehozjp/sEBB65Z+SYSF7/uX
 0MqqmLzZmEPIz/MfOevJ8djJaEEXeYRTI5QW0GvXFRhEB5sDtWAUxTnrPT09VbssE8a8yaD0N
 OGbBzE9+KjlrVCjFiQPk5Kg7j8MbeBPXOUGBZXNqX2WwLgXFOeXOHPzewg41MRlT7C5WP/dLD
 h7zqJR+qwjtbfUHkncwO604PnqY0hwQXyTw1QiYgdtxzm47TTf6E8/waOZU5+KotnaokeJkcZ
 olEp88R7mVAo7NMzKUBG7YHyjXX8VZ0i2aXwRdN0q15ZMIsGxsj89Ir0Z9a1lIMqEB5xxVyfj
 /FnoacgZtSBQ8hB6qk6XxoqjhFyq//oAHkrLq/vm8fwXmRHlM3SRsmue3t3HFHCdZ71y9fmvF
 Cd2bbOH7uI70yEW/h
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 23 Apr 2020 17:23:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 23 Apr 2020 17:23:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] console: Complete exception handling in newport_probe()
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

>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
>>
>> How do you think about to extend presented software analysis approaches?
>>
> Sorry, I am not familiar with it, I don't know.

Do you find the comments helpful at the beginning of this SmPL script?

Would you like to let any more source code analysis tools help you
to find remaining update candidates?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
