Return-Path: <SRS0=FowQ=Q3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D25C43381
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 20:04:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2152075C
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 20:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="WPphJ7Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2152075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1KK4JBC018462
          ; Wed, 20 Feb 2019 21:04:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E5FAF76FF;
	Wed, 20 Feb 2019 21:04:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 96928764A
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 21:04:17 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1KK4F1k005949
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 21:04:16 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C258643D7C;
 Wed, 20 Feb 2019 21:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1550693055; x=1552507456; bh=coIPx0GMHuP3eUUGmY8
 y6PWxhf4zfvo6SztNnqC0gjo=; b=WPphJ7LsbErDqCsbToVDfpZJd9g4ekit1cT
 zvicYq90k4c0CI2cMqud48VDtlXDLZtp6y6N7uL8LWaaGnLS3gZkck8gVrggPGYt
 JocbTpz+L+eLi66mYRB7TYMd3zI2f9BL6h7szXMgxtxAwKFrhinXlcy8ELasNvvL
 sGvm6bYHC7tSmTw8BdDvFWLTIi5gmlELEwcTg324dMYF6ANckAAHSP5w+lUqVBVy
 4IZY6UK8U6fPF0FSQ9jjg7g6Yxx/49/Au4uQ8dF4TYcqV5R6wqaQsYsxB4w6spzH
 wMhQ+LaQmkuRjVMTj2sbhfDDtNu/rbLolkPWON3zs8yHjiC0O5EFC12KYc3vx1lB
 2GX8zqrKQ+o5uHaNj7F5+fqoTtZZApOw1gMnbtACBR2pqyjO4dgRIWZQa/0Ogtc9
 lytWLARs8CY903QAjtdspZdhvk4HP5Q6EK1iIW8TjEfKvATFq6tQFWq3Qzu7fZ3k
 VEkTEBIcuJxthFGa1fpktC0lUbbwFMAOpx1VSF0mErQ0GjgFneEk0M06CUkFSAS1
 1qh+HvpDItw2HcdtcFyjxdIFJnc5y8QTToJTInvrQ9HcQkjmR4U6t75Ok8fjeYlp
 kqwIB5exvpGaCKTjeO+z/S3rjML/8sHSZV1d5JPXdKL2spsc43uwwUcR/HZwPCAE
 zUvh26eQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CiQjCaJ2dN2h; Wed, 20 Feb 2019 21:04:15 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 1DCF243D78;
 Wed, 20 Feb 2019 21:04:15 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id BE7262585;
 Wed, 20 Feb 2019 21:04:14 +0100 (CET)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <9b04d689-5786-517b-afcc-30c71f5c687e@mykolab.com>
 <alpine.DEB.2.21.1902202052100.2496@hadrien>
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mstefani@mykolab.com; prefer-encrypt=mutual; keydata=
 mQGiBEBzHYsRBACu8uw/xP4j/RYT/HBhw46jwNx9tJaHUADksKmmNRMVnpAX768sVFOMz+rO
 4Zfx0pGoaMrfw5yCh3v+fwh7hh8mMutZ6HmtOZho10hd/Kp+1JSpFDVP5b92ATr2Yexd+SXz
 jSbCDGLjGGpPWEEtNzu4UhdRwIIymdQqVTx6aCvscwCgvsbD+M9kmUWdToQI/H6QYsNBmukD
 /iPmBemMiw69xBzH+pLCpfdlnundj/ZXXdUO86Br6reg9q5m5Vv4ClyTHMIXcd6Dnm43S2Z9
 OvCDwtBMm+Hu5H89/B6E0NSyknn7CMciD3bLklFGQl4isyF+6Gnd5MTr1cM1Pm0EtYmCAdhK
 +h9SW2NWnPQOr2b3KRrn6rFRumTqA/0YDv8IvVRQZjv9DqK4YP7/va7GGUJHS44ksPyHuQXI
 gZVvHgE5ntSjBeUULoTk6vY55JTdgj3w2BdW9zvjUD9O7kDCf/sx74YvInw3bHsTDo4C7mr3
 QPWIVHKF63dElZwTNL+W0pzwDi6nBnu6RGpiQgI6gktIE13ySF1HjoKAjbQ1TWljaGFlbCBT
 dGVmYW5pdWMgKGVuYyBwd2Qga2V5KSA8bXN0ZWZhbmlAcmVkaGF0LmNvbT6IXwQTEQIAHwQL
 BwMCAxUCAwMWAgECHgECF4AFAlNET0gFCRw3Mz0ACgkQ0ei8kcpE1VFHMgCgtPjwlA34jJ2F
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEryuQINBFNETU8BEAD2GkRuwYIX8RZt
 rxtlr5m3mVvxeW4k+Zq7LfFDJ4tGFDDIQAGWPK1RfljVjvPSPxzsoj+KynXnIqw9e6PoSNg3
 tDMQaKvaLpzAKRUZIRJrIdCNuXQxvVI6Jxgg3GVbFider//67y+8rBJE5+QZp5zaIS4ifm90
 9NnHtOvr0ddJ1r26IwOo8/Pyg7y+bTN/Xuu5qr/zOeTcdJMtaQ2kbBh3IU2FSRGvUZTG9UNg
 aU54KKX7+Zu3cziEK87r89Y1fZTr0rZfdQNaUwivxHY4nOXN+EAFl3mfaHnYIsdSDG3mqza8
 RgoqLJpOGvl0JVlyYI9jgOvi05q+kFzGlZj1raAgnImzXh3p2se1sxUuXrmYkQt9b9OrFiCf
 XYuWEVgNoW6qpmzYHkjOGBcATANhv9JBoNbMQEsg7oeyeCZzI3se8yXkif89NLB3MmLFHcPV
 ui8Pv/6Y9/MAHq6ohM7AVJtOKt21jsb8R+Me3k5BoHkdU3iUAviScLKqiR5v5eL084gZtijv
 2ZgGfw1bNcX3y7VYsw5omvw042uGxzA76tm9hRjxDKK9OA/GAtkv20gusA4fZXUSuy7RRJ8N
 T7U24WD4lRLCBjkNnV4izQHr9qwM6I/5/jP8mguRSL7HguxBLcyL7ZQ01aQALcc43v/p5Vw4
 96b3Et/nZrVw04xtwwvuhQARAQABiE8EGBECAA8CGwwFAlNET6oFCQlmA9sACgkQ0ei8kcpE
 1VGjvgCfWX5kaF0YptgUFItMH6U8kA6vnRsAoJkVZPLvJDyYi4TiEaZXyk+3DKPf
Message-ID: <3b8639cc-131c-7c2b-128b-b18559c5cdee@mykolab.com>
Date: Wed, 20 Feb 2019 21:04:13 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902202052100.2496@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 20 Feb 2019 21:04:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 20 Feb 2019 21:04:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Capturing comments / whitespace with statement list?
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

On 2/20/19 8:54 PM, Julia Lawall wrote:
> 
> 
> On Wed, 20 Feb 2019, Michael Stefaniuc wrote:
> 
>> Hello,
>>
>> is there a way to capture in a statement list the comments and empty
>> lines between statements?
>>
>> I've got asked for scripting help to merge a ton of helper functions
>> into their only caller.
>>
>> Of course it is trivial to do with coccinelle. But the comments and
>> empty lines get lost in the process:
>>
>>   spatch merge.cocci -D func=foo_base merge.c > merge.diff
>>
>>
>> It is not a big issue, only about 55 functions to merge. So I can either
>> use the above script and add the comments and newlines back. Or copy the
>> stuff manually.
> 
> Metavariables lose all of their whitespace and comments, so that that they
> can be unified against other instances that have different whitespace and
> comments.  Perhaps dropping the information could be delayed until the
> metavariable needs to be compared against another one, but that doesn't
> seem to be what is done at the moment.
Yeah, assumed there is a technical reason for this.
Not a problem as manually moving the code isn't the hard part / tedious
part. There are more transformations to be done on the moved code but
that is standard coccinelle work.

Thanks anyway
bye
	michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
