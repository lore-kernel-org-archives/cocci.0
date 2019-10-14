Return-Path: <SRS0=hTpQ=YH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09511C4CECE
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 13:33:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1590A20873
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 13:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1590A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EDXAhR003551;
	Mon, 14 Oct 2019 15:33:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 618B577B2;
	Mon, 14 Oct 2019 15:33:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1DAFB7792
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 15:33:08 +0200 (CEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EDX6bx009410
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 15:33:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 21946BDE8;
 Mon, 14 Oct 2019 13:33:06 +0000 (UTC)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
 <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <fb924870-4bc2-1ca0-4fa4-0ddbf7ebb9d2@suse.com>
 <alpine.DEB.2.21.1910141309080.2330@hadrien>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c03fd3e3-685b-1305-54c0-e3063201cd31@suse.com>
Date: Mon, 14 Oct 2019 15:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141309080.2330@hadrien>
Content-Type: multipart/mixed; boundary="------------63E125D08E7ABFC8CFE21D0B"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 15:33:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 15:33:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] macro parameters and expressions?
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------63E125D08E7ABFC8CFE21D0B
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

On 14.10.19 13:14, Julia Lawall wrote:
> 
> 
> On Mon, 14 Oct 2019, Jürgen Groß wrote:
> 
>> On 11.10.19 22:00, Julia Lawall wrote:
>>>
>>>
>>> On Fri, 11 Oct 2019, Jürgen Groß wrote:
>>>
>>>> Hi,
>>>>
>>>> I have a simple semantic patch:
>>>>
>>>>     virtual patch
>>>>
>>>>     @@
>>>>     expression buf, val;
>>>>     @@
>>>>     - snprintf(buf, PAGE_SIZE, "%d\n", val)
>>>>     + spgprintf_d(buf, val)
>>>>
>>>> This works nearly always as expected, but not in some macros. The cases
>>>> where it is not working are those when "val" is using a parameter of the
>>>> macro, e.g.:
>>>>
>>>>     #define MACRO(name)    snprintf(pg, PAGE_SIZE, %u\n", ptr->name)
>>>>
>>>> Is that on purpose? If yes, how can this be avoided?
>>>
>>> I don't think it should be on purpose.  Could you send some C code that
>>> illustrates the problem?
>>
>> I have attached a little C file and a semantic patch, which I had
>> located in a local directory.
>>
>> I invoke spatch via: "spatch --cocci-file patch.cocci --patch . --dir ."
>>
>> The result shows that the problem is a little bit different from my
>> first analysis: whether a pattern is recognized or not seems to depend
>> on macro parameter usage, which is not limited to the pattern itself.
> 
> Thanks for the examples.  The problem in these examples actually has
> nothing to with parameter usage, but with the ability to parse the macro
> definition.  I get:
> 
>   #define macro1a(par)            \
> -        func(buf, 1, par)
> +        func2(buf, par)
> 
> Tha above mentions a parameter but the code gets changed.  This case is no
> problem because the body of the macro is an expression.
> 
> 
>   #define macro1b(par)            \
>           func(buf, 1, par)       \
>           func(buf, 1, par)
> 
> Nothing happens here.  It is not possible in C to have one function call
> after another like this.

Oh sorry, typo by me.

> 
> 
>   #define macro2a(par)            \
>           par++;                  \
>           func(buf, 1, 17)
> 
> Nothing happens here either.  Because the final ; is omitted the body of
> the macro is not valid C.  But it doesn't work if you add a semicolon at
> the end either.  It seems that a sequence of statements is not supported
> either.  OOn the other hand, if you transform it into a do while(0), even
> with no trailing semicolon after the while (0) all is fine.

This is not always possible. See the new example as attached.

This is more like the original problem (stripped down a lot).


Juergen

--------------63E125D08E7ABFC8CFE21D0B
Content-Type: text/x-csrc; charset=UTF-8;
 name="tst.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tst.c"

#include <stdio.h>

#define macro1(prefix, name)                              \
static int func##prefix##_##name##_show(char *page)       \
{                                                         \
        return snprintf(page, 1, "%d\n", name);           \
}

#define macro2(name)                                      \
static int func##name##_show(char *page)                  \
{                                                         \
        int rb;                                           \
                                                          \
        rb = snprintf(page, 1, "%d\n", name);             \
                                                          \
        return rb;                                        \
}                                                         \
                                                          \
macro1(pre, name)

--------------63E125D08E7ABFC8CFE21D0B
Content-Type: text/plain; charset=UTF-8;
 name="patch.cocci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.cocci"

@@
expression buf, val;
@@
- snprintf(buf, 1, "%d\n", val)
+ spgprintf(buf, val)

--------------63E125D08E7ABFC8CFE21D0B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------63E125D08E7ABFC8CFE21D0B--
