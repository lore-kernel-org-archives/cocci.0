Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4008C2BA83
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 13:46:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492E72168B
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UUnyokeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492E72168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01EDk7aM012523;
	Fri, 14 Feb 2020 14:46:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 780977802;
	Fri, 14 Feb 2020 14:46:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0362E77F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 14:46:06 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01EDk5FG026761
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 14:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581687964;
 bh=zQQuNIHJQoojH0+0Gjj3CtfkK0xdL6vxXNXtsh0Ldnc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=UUnyokeBc03QHD69zilt98X1CeRcKK5km6+YIEeg2WUBZ47Nav8QWQ8VLdJ8P1TpJ
 fQsSKXYNybMxNVdXfRUMUjmgLz4yJsEwTQjwwueLw4aCxgQa9gZ6O0dWnlcsMdm3m/
 +F4VfmxEJHPvU6WuqiKkS19qwyKLub1afL86YWB8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.73.52]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN47k-1j9E3g2yc4-006glo; Fri, 14
 Feb 2020 14:46:04 +0100
To: Wolfram Sang <wsa@the-dreams.de>
References: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
 <20200214120535.GC4691@localhost>
 <2050f71a-5da1-f01b-b3ed-8efd675e36c9@web.de>
 <20200214125638.GA20771@ninjato>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <4679f087-e68d-1bcc-60ac-ade440d28363@web.de>
Date: Fri, 14 Feb 2020 14:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214125638.GA20771@ninjato>
Content-Language: en-US
X-Provags-ID: V03:K1:RWRc9pPe1jxMq41AHvaSi62hretCG80PWRZfIWbuO6JdHcQal0h
 a2cuGaFbznJsIK9fpwDf29asraiXxeRU1o9T6Kx9wI1K5yAOQ7U6jsXtZQVhTaai9K6PxHZ
 23Xzy7+mKklJKESE3yBPt/ksAChlT67YSlRgtnSgsSCkEQJqhY5Fhgci3lhyC3uFJeq3zE+
 i21YxNLf9ANgc6Zl9Kwsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJ3M/bA5SJQ=:lwafW/LlTreEZ+r5w5kel2
 gMjdz2Z4UE52sqxo5OXUCpetEQfSuOZNzfx3uzrmgk6OVBNoSxRp+yqCv+ooLU+CSzs4tKJJz
 aLEJcUkh8VHXH/Ja87E8mwiywUkYAVYdJTkyJS8YihSFkJCrlHBOlKDiQaQ/xaW7w0/jT8vKN
 vWusNieCa74HM6vMJHgVHLKglOY559OerPUYm0jegC72kRT1p7OxqFFyPrQoiiyRfUhhILHop
 Qi1NzHrfAg9FwwvYx/UocL1iicybNoxc+N8pbDFaA2NGolUIpYHgqKgqYNGehfuB+omoTsZ/Q
 k42PP3xNLBoWe/Z4QS89v9NGSaNZE5Jkv9WvhlMcSfjrh0TO+WWOKc/i69OVe/uqx5UF2iAih
 Vdw4nYUGjzASgVof4Vdh3XdqQI+gjkgaon5QzTYP0hKVfVGrY136/udxfNosVl8O4ep1kitb2
 +JmtbRTXI5tm8V4gBZdLBmRjtjAv3iOa2SYGZAuOEVW+j7qMWflj82oaRDEYNcyTqCU0uPnA6
 L5b45z2mwTCPXcngLPHqBmn7ZjVYYkE+pp/hHOHY9kKADBOtL69g3PoLU9hpupYf50D/h7auZ
 9MNq76YrsHLj6N638i6mExfs+rYdz1wnPy5WHtwuOmxjZ6JVMcppKrtFMmvoGr9qvd0UbFTKo
 DtTBwXDXB92UxH70qKp9s2buD2n/YIvm69/QiwQDTulJWgTC6jRgdhOzFinsG7hkc4TckgUmZ
 5pjqiSo7q23DQUdkQAqPoQqkcR187smZO/xpZVHbmABLAhMs5PKGcpRhOvVRTCq1XfpsZecgR
 59Ey+VSKrZEJxjD7ui8PFRz1H/JDilrc5qQWytAr5Vq6z7qMCmzDyZ99qakJDg7fdxlYvPhda
 MFq9XpRsomyO2EbFF7kGA7jQL3YaZLn+8kUVO3deo0FKELYxYAgUICbc6dUgTou7+ppsxmVzI
 XT4AFi4QpkvmWql0VVDlrMrOLkv//97TUcF55nLBtB+4ZI2bzCkAieTN3PjOD15zvqzqie1ni
 qeX3lCSBECEfBhbuVe8gKtP36jQppfmrPU443Xn6MjPtveXCIC81fkzwrMDCCioHb7CjLe982
 XIvsuMuMytxICFoA8ZCzm5NgeQ5LrrrDTZ7+K3MXA5GHd8NRrLLovc0lwT8b73+Q8/omsBDmu
 jeebjPgfdNItMI2PLj4ENnUGkM8i/++eg7WvmOwHc1tCdCFjpp0Y1Wa4BSztnP6pUP+QMd8hY
 sQ71zQ5/5czmZh3Tm
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 14:46:07 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 14:46:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Supporting Coccinelle software
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

> Why do you want to know?

I am looking for related incentives to achieve further progress
around affected areas.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
