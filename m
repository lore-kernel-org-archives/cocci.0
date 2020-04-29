Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB9C83004
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 19:51:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9289206D6
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SuW3mvui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9289206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TJoP0T029990;
	Wed, 29 Apr 2020 21:50:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3B9017816;
	Wed, 29 Apr 2020 21:50:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A8CED7807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 21:50:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TJoNkQ016666
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 21:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588189822;
 bh=eNwnXU/9G+Yj6/6Y8BggZxSyM89xkaE/5Glkl2WLIW8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=SuW3mvuiLLptKO+HmQtC9pgFM7JwpRe+L2sE6VatPCt1SgztpZVVP03xWpxiwmJ/+
 fcOxuUJJvvZRoV0J8EZZLTWLF41rmWwm8glWHn91RPebybkBEw3/akIq8Rk21K0yEn
 JOdTU2gAMS6KKMWEZrtSyKU3QhCOTjgn8BxbzMu8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmqC-1jR9Q34ALO-00F1GR; Wed, 29
 Apr 2020 21:50:22 +0200
To: Paul Chaignon <paul@cilium.io>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
 <20200429190733.GA5695@Mem>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
Date: Wed, 29 Apr 2020 21:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429190733.GA5695@Mem>
Content-Language: en-GB
X-Provags-ID: V03:K1:0GiWc/twQG5+b37RRmTOEMWAjk2GuoPPHiRXIrVieqfgoTMNp8+
 fCeLOn6RrFS40ViePQHVF8R1RoxKzHwgYPaSZ31tB8KJF2J9mxIIF3GAUpYqjR3rbYGe9Q0
 kZ7FzWZdK/lNZpwwYDO6iMT93ZSCC3RNOYqpAHsiEdzUytp2EpbycHn1wK8t+eD9bsR+unT
 jzl9nnLdm4RHlphAYQ/zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PN8htrwcgDE=:dljxbSDSa9zLTDO7bq8lpa
 epN0eDfH33UwVai0mf3Y5Rjxy5A4Pie0Nytipqfvuu30/+foL0gduqwa2caKZeRkfahaNuCnZ
 WIZH6C/RlY9bA0zbtoZT50vdrzlywUVGnmgFkRya06DRbsBD6r7kxchkh0/HO9ukTekUjfOJq
 8/JB7cHKY62kCGAJavCxagp1ruW2LBebaRpiqA/ZEAk+oA6BkYxLTM94msDtOc5Z24aLYyUUS
 YgD/PN3Xye7eRvs2x28rQZs5xDwZWqjcmeIyuO0UN4pI9wSn0+n0U3EB0QHW4Rggjn3+7yrYw
 2hLc71mETSxa96nQTCWoxtJWvoHu4tjxG2YMdEKRj3gZsHTHCIgfJtEYOYjvcQQtAaS+350C5
 qWeAedmLzTrQBG5LsqxNWYX7WKOv7UkSkdQxQJqb+obXpCXPVLPOrY8BiB9YsgtD9N8n+8yCh
 N1EXPiLkWRT3AQV8wKgSgM4OtNulgeldSwIrvql6tbHieO30hKs8oa5AA4mPCP7f81XPQvOG2
 mS6gdrYPRsEDDSfSX33Gpcu7BxIMJeZBEDYQKuEsA0wtYkG0TOhuAvaqtlULeKBw3onl2mkNu
 IacRNrVtSAHrBWNr9789+OpJ3wvl19S1LI038mwtB8ztWcStXOCwuWVKHmNffN+7+n5oj4rOo
 7FEBoFwF+HQNXoFt+0XqPLkUeAFCOYVqRDvYkI5OdaqpwLdPHdQ2Lc8GoVPB40xZLvyLAgzv1
 9XHlTTWEhXIDHGnjMdn4syD4PNKZodKGth3EWdsk62rtYsVtAq2XV5hZYsovL7fdPBHWGA3MV
 axrcoQQz3YacnvqsFVVEMXp0rmMe5J6bwuGchNoyjB3axB/nZq3/F9uJ2IvLqBe5GGJrfjfrI
 GfurZVxDS5cx0iqh82ceMDJTnnjtezAmZ8FKSWuZe9TAeEoI2mXWpn8w4B88ImE9S5KRpLkTr
 8hbqcJgSM7mqJ5ECMY1WHmvgLhc8KSJ1B4ol8/bVBYSVixzTSuH2qPPqETCOKKglj/kXqedVW
 d8o7lvedcfdsqsBJ+jtqnCIaGBJn02ws5rYBMDgkTH4X0+QkzEsWlZ9ILnf+YBatf1MBdNcNA
 JZLRohuOSuS+IRC0FL9zuRDvTVjImpn9xltGeG/TsZSgdw2vmSebTJv45RD27bhNduGxzY3iu
 xnxE1FBUBGWQwj0F1GgsFlHoKUer32CIZ7gehOrZttd+10Px/RddIGV7HecPnfLXG2DLyKB6E
 nIdVHzugw55syHWBs
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 21:50:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 21:50:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

>> I suggest to handle the desired search result counter
>> by an other data processing interface.
>> How would you like to treat program execution failures otherwise?
>
> I'm trying to run SmPL programs as part of a CI pipeline, so execution
> failure and (buggy) code pattern not found really mean the same in
> the end: a human needs to take a look :-)

I imagine that such a look can occasionally made a bit more convenient.


> I understand that is not a common use case

Can such a software application become more popular?


> and I'm fine using a workaround.

We have got different views around preferable solutions.
How many information would you like to put into an exit code so far?


> Just wanted to check I wasn't missing something obvious.

Further possibilities should probably be clarified further,
shouldn't they?

Will the usage of additional data structures become more interesting?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
