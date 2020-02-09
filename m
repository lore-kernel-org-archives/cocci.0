Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86340C35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 09:01:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE26120661
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DECZMArB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE26120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01990h9D000980;
	Sun, 9 Feb 2020 10:00:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B0C9772F;
	Sun,  9 Feb 2020 10:00:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DA157718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 10:00:41 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01990euD023294
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 10:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581238838;
 bh=eggTCwy3v4nY0VmwJhNO6L7byGfjwsEUpYa0OsTp6oE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=DECZMArB4KJFAWgRWJQxnay2vVQ9aObwfC4dzmG1YhQ5X5EXqaqJAv72sK2mqh0Ph
 Sqfz3oaDH6lwHRWaouFDXZQHPY8efOv0KdSp81Y9PEntNladQnwv+KnRXy8CIKQ7by
 ATFXggAoiWSdaZ6WE4+S484Ay8s+5Q6sbdwEBlGI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.72]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40na-1jqksO1O9y-00rUmj; Sun, 09
 Feb 2020 10:00:38 +0100
To: Julia Lawall <julia.lawall@inria.fr>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>
References: <dc0d8d19-85b0-54ea-6d15-d62c47fdaece@web.de>
 <alpine.DEB.2.21.2002090950560.3430@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <899a271f-2b4e-ab3e-3ed7-fa949bbd4c08@web.de>
Date: Sun, 9 Feb 2020 10:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002090950560.3430@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:KjvaILfqb0777+y+cI86FgPb9ybehL+JmzoL54qYn2R+J7cTSUq
 4ToH9Vfq40Si58JX42+fQVbjFnttHDLe0PwoTnMtC3ZpBHsHtFxO7teYETzy/y4iGRjx0os
 wPwBljEIiuvy/OlLZ8i4iHK2XYPxabqzYGLYYNMAwCbQisTnDSE5+pvZYIZkOCCud67k+yh
 Z8h95YURNAhF+av+HIFRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b66+UXWy22Q=:vjt4zvX5inR8xF55b/B30x
 OTnVoh57s54ksl/lY0l6vkGE6K/kgyv414LWAw3j+3fvMQXCuCKDviLqUK0eO6ijbnvT71m1z
 +pQr0Nz8kWQDP0MDTm51gaIw8b2fzWPWwWv1807FrWfsg7rceniLPMEM0iOdAeBQV9RH5VSo2
 TqGPzSOQyCVTKaiQzlvMrs4QVP0EZk597pOJiTD0euCXnYGTCksT93zWd0b3vdXi0QlSV3k3J
 vtemnI2AJYaknViMsFykqK3lYMoSVFehez0nchU6ZMRT9zeBRWr+lkZ/cPMxNCI9K0ECz9tik
 M+kxOhEoG5e1ggaMWJjgJTpyH4CcupsoafSBUZrV8ibtK8phErwtEH+x+p50zDBoCgCVJi6Ma
 uzWvpSyZYKZKp37hEhrDKG0DAy8MQVLKlHwR5m4Ot7UJh9P/gbNqYGT7HLAVkhYV+rp55qU8p
 ozh0KjiXQoPIqfIUzNE60wnwkmNceVvtbDBfpPYpH5jiiv6jlaOoKQjZFA1PLqf3fL+81Wbs+
 UT1HKJC3PPy7xq5A9jQqBtlhxQsTqg3wBamwlh952uTv4vCrnhNFHoAQL/lGc5tmQPXIgboxn
 Ji59n4cwFFK3dGKkf5eH2GHyB8o5yDEp2YBt0JsGZ5WMfKQtL1cWP1C/Xj04Bmeh4xkzLU3z7
 2G5+JZUu3JYMHIL4cbZxieXPcLmZeMZkoMxk/B3KpH9Ei1r6PyvQyiizfuzKhisBBU3ptpw1w
 m8IbgonzJZuryvMU86VpEnEMDeUOzghzYXEEEcTdMDR3d5VlNZ8XXRWxsAJ+plaNfBgpSH35O
 jJF5vInTx2pvL35QGyf6W3zW1IQNfVQGQUiNyMmXsQhNbcbNvE/nUkiO+hTLeGtKqTPrmBMS2
 q76768ufDGuSkeyRDVf40o0u/7Z1EKIbAU2OPVkxOS76g5bZd9fckhXKV4V0n+0s8fvPnsYOU
 UClfIud6jM3r/svMd30iPyHv7QrRBIwd3w4AbY8Rx5lZBCdUHxWUXP4Nzmf1geuMFYZmY8nYO
 qww4zHNBFYNrx2VH0OXYlfjazfr7fK90CuJI1JZX2kw9FUp63ue8wZpzGjv2DpZ1f0B385Uix
 Q5dfwm4SLT34Y9PzR+gFTeGlrLyEZkjD1gs6jJRIzYfkQ00rgSxtZXkecRF7aCRcxS6zi6Cfy
 vVL8TH5UxN+5ZdG4y8yaqscfg5JI5UTF+XIwtBsfi3Z+uoLy3yH7JD+LZ53ix9ZGLggQxtMEQ
 JQv7TbzCYq+vjOKh1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 10:00:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 10:00:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v2 0/2] Align the C AST and Coccinelle AST for pointers
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

> Like what?

Do find my corresponding previous suggestion reasonable?
https://lore.kernel.org/cocci/702596c2-84bf-13ca-b014-8784bbb98808@web.de/
https://systeme.lip6.fr/pipermail/cocci/2020-February/006842.html

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
