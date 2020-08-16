Return-Path: <SRS0=wO9s=B2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4576C433E1
	for <cocci@archiver.kernel.org>; Sun, 16 Aug 2020 11:08:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C810206C0
	for <cocci@archiver.kernel.org>; Sun, 16 Aug 2020 11:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MHsJpVSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C810206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07GB7vHh019158;
	Sun, 16 Aug 2020 13:07:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EDB937814;
	Sun, 16 Aug 2020 13:07:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B763F5F8F
 for <cocci@systeme.lip6.fr>; Sun, 16 Aug 2020 13:00:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07GB0N03028684
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 16 Aug 2020 13:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597575622;
 bh=3RhTZZDnjJqZ1Mm//gZuTCp8ew5Sb7W4O+cqAkkzUOc=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=MHsJpVSg6wU8FOczIdZjdkju+7rw+Y4YJexzjboJb61F2u3JftXYxlxmMbx/HSZHW
 IK0DwSkLoUOcSXx4ZjhSsqXUn4nWsiSy85DXoO7ILlOuRDz9v8rKu9fLv7EsEzRqzv
 8RaOyqOO5GFyL1jtVhTV4m8TBJ0LKE2Ru9BPZzMc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.138.182]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYnu-1kDPCF3lBe-00WVFJ; Sun, 16
 Aug 2020 13:00:21 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
 <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
 <48ffa436-6e73-88b2-07bc-89942f3c6d8e@web.de>
 <0a9015b6-9037-59c5-31f2-cd2b32c86b50@linux.com>
 <047eaa85-20cf-800d-7087-a980f53572de@web.de>
 <79b1be9f-51a0-1e02-bf96-af9104324eb9@web.de>
 <alpine.DEB.2.22.394.2008161043120.2502@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <16535f60-5c06-117e-b90a-6f41263ff929@web.de>
Date: Sun, 16 Aug 2020 13:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008161043120.2502@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:0UAuzGz25BiAkvftiOceh+g8mircTod471rqdEZjuLe9IiJy4ke
 tZPZNfuXOpUlfZtyd2Jrv8YuvMFg7bVp983SL7aoQRSkLEh1jxgXSOMDbt38M1S5mxRgZqs
 wseM8m/LG96n+epLpO35EtZ77Cz+5vBzKY/0hu9A3fXMdJ+YY201/17MCUQKQD4/ka8Ux2Y
 nZNkPST+F0Y7c1ytBV5eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i3lrkeP7JSY=:kGyLjpV/h5lrA2vDlBF35x
 mkyuoIJZDp4FAGTlLWDagD4IsU0LOIl14LIP1MelCdBAi19mUwshM9APDF6JkPfOOoIu6Aoah
 89ikM1lTemYnzZXJHYxegl8AgHMttjUFia+QSEWc2zIPMIh7lXshSWCz6Kfpl7cE5iHsBDZQi
 U7YaKoF9zHLBEc7q9qRN2wsMOyeseOXPqW5VdDAfd4P1g9R1pViF2Ux5RklBx7o1WBXOO9U8I
 Z/Cj5aepzPHK8OAAs14O+K8gta6TW58MzfCaGcsD43ohfTdV0ViBQpZ8lgO7OJK+32BsuRsQ7
 gSlobdyTv0AbBLOeKX7xMOOgLwbjXKm1lOShfDmVlibHxubLMG5+ws/6YtK/XXyZfdgYXp9t9
 64q6hWSj5SaXjIALgcIE0Cf0fgcrQ0htTkPYq7OvjIbkuzNiACt2QVqWY3UNSVfs0uobyd4Cm
 bh2Jfq9reuXuKvOEHEURa7ij2xoJk0s4H8CrRP2SDUYgidCNsYgPH4gWBxzP/bNzxr5DcAmp+
 5RJrdsN9r72Jujid9eNsFXijy3VPjs2QCbgkeGWgIo2NPFztz/FpwAO+x9xo/LW8LvCW32ybZ
 //rFFfJfGgRidWpxmE9D+BNIdRbbmtXSEcqXoEm/cynHjSUiImKzegnCo+QCIroC8GsXty3u6
 yhIeFrPXTaWffRztgkcEqtjo1uC2WXK4LpvFgjyo2OdPSaGSMxSpKBesD14oMD8+bbCRoxqA6
 BkabxpvwTRyOSq0MbAXtXczAnx++yZdoq+N1sxTsiafOd7dUxBwjrT1y45YmlWo8OMxWtoBYb
 kcZ6oGOI5hXxwxssIoyo3KosuTkh2h8Yo9XoqQi9ERE2TRzZ/rz5zfH7f8iN5il8AMyZnzYDQ
 Gdb0H/Nnk/q5MyIhVMHtvmRvJ4KrJ8aT4WCr2FNXbmybjz53d9lnJ83z9bgvgS63FMehG66E/
 3+lvDgTyHEz/BPUiDpG149mEL/JQ+vTrrBMwZH5fRfwLUF6EiSQihIuzRB6dP6hlbV1DzXTSN
 UyrD5ti9cIfuMcHlB+SeaVhPgsunYb/Fk0HSwZVdrZLJhSvw6teygslzK7bizuKkK8JfF28zN
 yetSkKUSfBYx5fDL1jwWMhNB2OshXQXGJ8rWYn+656l6oZLnmNLObE7TBz9WVpL6aSQrEViXj
 3Wx5gtaQwiWjpJxJsnLuWuizd/eq1REDZQg5bnhKuxkXzp6I5KSYS1AZqWFFzWvPBY3wMuXU+
 rfmqYIjjW08t0Q357ukzVsOd1Jq0Q8gK87nI2jA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 16 Aug 2020 13:07:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 16 Aug 2020 13:00:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 16 Aug 2020 13:07:55 +0200
Subject: Re: [Cocci] Searching for format strings with SmPL disjunctions
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

How do you think about to extend a source code search pattern like the following
by using a regular expression as a SmPL constraint?

@display@
format F =~ "l{0,2}[diuxX]";
@@
*\("%@F@" \| "%@F@\n"\)


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
