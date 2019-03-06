Return-Path: <SRS0=WBXL=RJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4183C43381
	for <cocci@archiver.kernel.org>; Wed,  6 Mar 2019 09:41:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A19F20675
	for <cocci@archiver.kernel.org>; Wed,  6 Mar 2019 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CfkElrdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A19F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x269epHC001785
          ; Wed, 6 Mar 2019 10:40:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 12FE6770F;
	Wed,  6 Mar 2019 10:40:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DACCA7702
 for <cocci@systeme.lip6.fr>; Wed,  6 Mar 2019 10:40:48 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x269emLG001257
 for <cocci@systeme.lip6.fr>; Wed, 6 Mar 2019 10:40:48 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1551865247;
 bh=OA99c/4xqDEOjELBq0mquZ9hftQ588EG2ml1SZi+zvQ=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=CfkElrdPAMbz2SUOLDKsrwutSfsFbMLCjP3NiEdTLzbyxp9K3O9tCAUpsQn8PYHzB
 UOuIgROah9UcttVtQ+XzX4TJCRhF3ssn5v3UbNn8m9zeluYecbQSR1cMVLyqI7yqSH
 5nRv7+HStvq3wuUpsZSKBQMjEHr9lp4T3CNj1Qh8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.80.135]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOikY-1gvOlF31k6-00686a for
 <cocci@systeme.lip6.fr>; Wed, 06 Mar 2019 10:40:47 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a92e39ec-4daa-0101-553e-21ca743c2df0@web.de>
Date: Wed, 6 Mar 2019 10:40:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:6gFyv4TVhu0AUxAtm5PdmyrLZ+r2/fOfuJqrvbDKDI4+PzMVLlY
 Run1IACr6crwte1Q2+U0RYCqv2Ty5bto8zcS7ReBl0HI8F6rICtNuBZ1yMw1nL3lga/ruQ+
 tl4J0RjkFtNoS73eQR3M8vQykrfG9UmvI/ETB34wmAj+vJ61WsraXWovH1zFvFFKEPqqrJU
 ONlrLSAK2up8kG3NS4yAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6s4+nPWuo0=:Xl7zXB5eg9F9ebNWQ7yuyt
 2UL0gbyH2K+HLTH74xvmyeppJIpeYR+CwQZSsDxn/GS9/jSU0T2W6uB4exr5NpzIsWh99Etvn
 fV0AbmaIMPJMSbfHLS8Zej9xkY5d4oXf7qcLtP5cB4t6mgqVLhriG2OnrJv73CtV/T0dKmDgZ
 iVcowtmEBBqCQBa/N7imxL89F9wKrbmW+rk+mMJJHgPd8EJtaroMTIdgRciEzFcCRg26CTD5s
 esNvBwD6AQIwETL4aj5DubgEKqxzbAVzLxYnhMoWI3DCCBnAHxByeD+GMVoLrXYo8ybIjh5KX
 J1xQFefouOSTuWAnUHuH2gG2zqFWl0mLRgyYMbyR4sZN95xkR06WKL6f0YheQsAnIH3HLyJdD
 iYb4GDXzcWzYQ5l+4CvwePyqNPcVVUzQWQT6CfItCvMC3m1JnENszTql3QXFnSmjyQ9/p6Cd7
 Ofm3Yhdm/8+16PnsEyrZnjqzeCjNLoGCZhKkjhWGy7pRUGhCuHPkRad84UWe9aTWawLMV+Nsr
 4V4D9DgX2b9iJQ3uyHrn8dQDY68Q5uI3UCrX723uXWxupiPWT/gpXfxMt3sB66F5/D0kN9kYy
 UiDXyfLA9kesQSwVoA1B9Otj5PGKr1AivlbUm6ikoJ8HwDJigTT8RjYNF2790EUp2pe43RQgj
 t+9Cjy/lSVZqf3JrqC+SRXRilxwohlzKUrCuOAafXBNh8azI2XDHpqcML8kMnNH5bBWiHJkOV
 ogmDfYWnOncZUnh5iEaSSUXo+wxkMvVAX4gSquEoVkV48wUkJrSp+sdsA0rba3mq9YPsBAb8h
 wYfevzgtXTQ+pnBRP7/YPGNVe4EeXrpzHbqVoCZTiFPo6rHTA+Q0ypkrkqguN/XdgytaXYNRA
 Cun6pQoX7V1IZB/aEhTUPdGfxfcemHNiiQ5yuAw9ALvvz+rg/BNtp+4yA1AA/DwSpJlhHzwby
 1o0dj7FGqbg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 06 Mar 2019 10:40:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 06 Mar 2019 10:40:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Splitting a source code search specification from a SmPL
 rule into more rules?
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

Hello,

The semantic patch language supports also to put longer code into SmPL rules.
It might look convenient and appropriate to specify such code for a single
SmPL rule. But it can happen also that you would like to reduce source code
search efforts and present meaningful analysis reports.

Example:
It can be specified that a specific function call should be found as
a precondition.

A corresponding hit can be additionally indicated in a variable for
an embedded programming language (like OCaml or Python) in a subsequent script
rule so that this variable can influence a message construction in a final rule.


How are the chances to restart (or continue) the code search after found places
(without repeating SmPL code from the precondition)?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
