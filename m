Return-Path: <SRS0=1uRY=44=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC457C10F27
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 08:15:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523682082E
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2020 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eiaIX96D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523682082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02B8FQXm025289;
	Wed, 11 Mar 2020 09:15:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8BC247816;
	Wed, 11 Mar 2020 09:15:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D8327802
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 09:15:24 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02B8FNGc027279
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 11 Mar 2020 09:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583914522;
 bh=8F6lbaQwUKqzbTq+swP9JvxrgPh+TdyssIHjO8WIgtk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eiaIX96DviuYiTxcWLgiZurW9rBcbWEFW+eSWAaFPqqulk3xIm8VxTyAT3kgAg5Nf
 ZeuflBaFvgrbtCSMJTXT0ZXL49MIyvD3RROR5GoE1HQd1Y8VOJ+C+z/OBcLHlPPDes
 q9YfXqABnL8gdNbgU435TuD27KMhRyEp+s7UmzU4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.144.136]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LopdT-1jo09q3zyt-00gqbN; Wed, 11
 Mar 2020 09:15:22 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <127b687b-7139-e3b3-bc5a-13461609851c@web.de>
 <alpine.DEB.2.21.2003081541140.2400@hadrien>
 <a03a8370-0bc7-b048-5a5e-7ee1730fe704@web.de>
 <alpine.DEB.2.21.2003110909390.2439@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c4abeef9-3237-ee89-9149-2a7e1341f95f@web.de>
Date: Wed, 11 Mar 2020 09:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003110909390.2439@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:+ZOIAmgAYXqtfaxIphYlJnDB1Ss5vB6pjqfz68PpJakPANIeNLp
 /dOMbGx3Nk2/t+XHOYHqBozETkvqagBBxu8oYxg+fieKZSFpM2bCyEcSqnDZJ2rzj+FBdN+
 prDgeasKJY087LPiCXCUsY5/hyjzkGYnwMJd6rt3FF8PJuzRhbQMkOA5NCgpXcdfze10bgn
 R7J7W7Ta9bbw2nnPnpQQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m0h8WRBugbo=:ZfjJhUdeMMmVN5tN7HwL9s
 L/SARIOsLOvn3TcRE8KG8/st3Ju5vX4EI8NFr4rT59Az/Mq8V1ZsbXdveufwcsxkvxKgsjL4v
 GlsIn5GtcLDcUthKBgqgpVI0dNM9rbP5czf0KtRkQDufGaQexREV41+c/KuhtSOMbtEGxMVyM
 bESSReHMr5w7XHt84ERrJLWYxMHQEOVgMSIYJvCS7QaTQcnbwjpMItY2m5SoEAPUKHbQ6skI7
 9mY6Q7tvxdL6p1hf8nlpqXSVgjmFmf5QJDDvdKdkThNjun83W8FWloq2Bf6s+tc6Gn74OAt9M
 urW+FHPWWcYKshE9wuj7xarXmbFGHNaQ+PxWOMTMhTmosxoY7BU6voQEI1KVRjWLcgxHXYs0h
 0sWPE51nupLYi+fMTlJnBihjPEW7YlbqtjSb/r9Ix90ZQvF8NyvraZZek+qiFsLc9T289BH6G
 NyepheaABwvEjDTuscxfWFcsqCoSV+/czVtKwogtUnD5Pv5WIkelegyMfFDfu4aqWY4EfqJto
 fjytobRTTJBGRK+P1mdUgdwWOD7/E5xsP3w7taVokYxj2/nrgHPYzIaKECxyMHMjtCCzeuegX
 Q9Pn39DzRNppcGFf3S035MzEDPASgmiwf7mykOHyQ2/tO2iM3+hlE0vj4fI98YmU3lcMe9xq0
 CXMX41BjKsyKYbMGGmwfmrejnTWX5ggqiygnm2Uvb75czv3xXnT77AnINGYhYoQ7EsXsgb0PZ
 f5kYtncnzfEJ2IhuSAy9+icB+delqpIxqnEzcxwAoeLvsD5OH3nC79teKWjRC12QPrwruJV1v
 CR7VDpC9XrMAJ5WNqeRoFQ8Nk4UbxOXEoG/TokS5I1DCaPSmj2wGQyDA7P5gYvUJjkP9CdcI5
 DuUEPcNiIkuTSkXTGetwRF/pDAHPEVl0YMNDmCpww56wKJdhxbTMxB/1lgpBu+kNmsezrqMJ8
 EpHVK7I+DyjhDF2I6vrws66+nA/oX7mJVqZ/N1qrrr1K/v13zboQ4nn8P7npq1n2nYIx+zqpt
 eYNZzGrzJveiiZLcZuuRyFm9AygX9nMUwdx9YtX21WZ61qxFIrCzlTWZMs9wQWjvA7OqWPgG1
 6LB/rAbSc0NWg8gZnxGqvH82hOtlDPmcxySo7I8/Mp39wTqpeAVFw5/C74Suaz3kxpg4aoYOR
 7VTDxpS689bsFydEPKIZKCY8avK6mjloJxiBGOHXs8x/I57iuLvZ+az3mlpGdoHIwiLPqwXfk
 iiiHWXnUwqWUyOr1k
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 09:15:26 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 11 Mar 2020 09:15:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for application of null pointer checks
 with SmPL
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

>>> pointer == NULL would have been sufficient (not related to the noted problems).
>>
>> Should this detail be handled as an isomorphism?
>> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L134
>
> Yes.

Unfortunately, I might stumble still on difficulties for the understanding of desired
and actually observed software behaviour (because of remaining open issues).

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
