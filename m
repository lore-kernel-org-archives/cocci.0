Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE838C433ED
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 21:50:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDA3613C3
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 21:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDA3613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 135LoKxg020210;
	Mon, 5 Apr 2021 23:50:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1ECB13CA1;
	Mon,  5 Apr 2021 23:50:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EBAE43B62
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 23:50:17 +0200 (CEST)
Received: from ssl.serverraum.org (ssl.serverraum.org
 [IPv6:2a01:4f8:151:8464:0:0:1:2])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 135LoEN8000880
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 23:50:15 +0200 (CEST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id ED14422205;
 Mon,  5 Apr 2021 23:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1617659413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yUHZlPeVoJW9O4AU548WiUb8ygOmfPPgGrfLgiCaWY=;
 b=Wwb37McqSUSQu6Qj060954aTV089lQxMIGiPnT/b1LIDiUtmj/prO2tW0GFEeVye12sR1h
 BdED+VueyAGabkhI57kr9nrKD9Wft3btvN5qi336J6na9l0iwvpyACNGA5InU92V+g8CTD
 7NhBKKTky9PQrplXcc1lU/3sWWQTSJ8=
MIME-Version: 1.0
Date: Mon, 05 Apr 2021 23:50:12 +0200
From: Michael Walle <michael@walle.cc>
To: Mansour Moufid <mansourmoufid@gmail.com>
In-Reply-To: <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
References: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
 <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <80c602de0af4fd3c578714dc837bb6fe@walle.cc>
X-Sender: michael@walle.cc
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 23:50:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 05 Apr 2021 23:50:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] changing of_get_mac_address() to pass a buffer
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

Hi Mansour,

Am 2021-04-04 19:48, schrieb Mansour Moufid:
> On Thu, Apr 1, 2021 at 4:13 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Hi,
>> 
>> so first I need to say I've never used coccinelle before,
>> so please bear with me ;)
>> 
>> To make of_get_mac_address() work with DSA ports (and a nvmem
>> provider) I'd need to change the semantics of of_get_mac_address().
>> Right now it returns a pointer to "const char *", I'd need to change
>> that so a buffer will be passed as a parameter in which the MAC
>> address gets stored.
>> 
>> (1) Usually the call is something like:
>> 
>>    const char *mac;
>>    mac = of_get_mac_address(np);
>>    if (!IS_ERR(mac))
>>      ether_addr_copy(ndev->dev_addr, mac);
>> 
>> This would need to be changed to:
>> 
>>    of_get_mac_address(np, ndev->dev_addr);
> 
> Here is one possible approach, doing the API change first then
> handling the conditionals. It seems to work.
> 
> @a@
> identifier x;
> expression y, z;
> @@
> -   x = of_get_mac_address(y);
> +   x = of_get_mac_address(y, z);
>     <...
> -   ether_addr_copy(z, x);
>     ...>
> 
> @@
> identifier a.x;
> @@
> -   if (<+... x ...+>) {}
> 
> @@
> identifier a.x;
> @@
>     if (<+... x ...+>) {
>         ...
>     }
> -   else {}
> 
> @@
> identifier a.x;
> expression e;
> @@
> -   if (<+... x ...+>@e)
> -       {}
> -   else
> +   if (!(e))
>         {...}
> 
> @@
> expression x, y, z;
> @@
> -   x = of_get_mac_address(y, z);
> +   of_get_mac_address(y, z);
>     ... when != x

Thanks a lot!

See also 
https://lore.kernel.org/netdev/20210405164643.21130-1-michael@walle.cc/

There were some "if (!(!IS_ERR(x))", which I needed to simplify
manually. Didn't noticed that in my previous script. I'm just
curious, is that also something coccinelle can simplify on its
own?

-michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
