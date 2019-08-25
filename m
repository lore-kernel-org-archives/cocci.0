Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B84C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 10:22:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F7D20674
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 10:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Zj9K7nK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F7D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PAML6q008158;
	Sun, 25 Aug 2019 12:22:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E2A6E76C5;
	Sun, 25 Aug 2019 12:22:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 902F17694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 12:22:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PAMG1A000800;
 Sun, 25 Aug 2019 12:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566728536;
 bh=lvzabUW9tZjtG/QyXkxMsvmydssVGLzlvQtnyGByfwg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Zj9K7nK+tEhOZY1+zSSVAEobaAiJBrpgxf+Wk45LBbInI3UpCC+elxyn9MbWssXHH
 Ri96pCGuhOhKIfKOlqb8ULaECk7q8GaNzO/h3rQkBZtODo1R9Tfnon0HZQfbxJRT4G
 p1TKqp4CXw4iC24QTyS1K3JDtak6/zK6nlh6pOk8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5ZB-1hvTsX0tDd-00BHSy; Sun, 25
 Aug 2019 12:22:16 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
 <alpine.DEB.2.21.1908251741460.2366@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3d06c34b-ad1b-2d5b-f36a-0de6429ad361@web.de>
Date: Sun, 25 Aug 2019 12:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908251741460.2366@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:wYnJmPRu2H9y4dcDb0H2V4T0VE/muemgDqK+Ndjcr1cFHnf0HUw
 sizBbJ0zaJ5Gnc4EUwpibXtMpoK5PHjo3fZmbb1itaGXBOaV0m+RxldufxAqiO1Zc9QVfsD
 YUV+xAD8/1qnHw36DBlEb0ZPINeyybJXCi8qxK7q6blQgNF8hdJxVz8LHtKE27xxGuavAQo
 vWxXr6OzXbpAnfKUEKTsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZ2SjVzaBX0=:SWhakpnu8h1MgZEdiFYrbu
 TCYDA0WpPl7u8Cez94l87Cazp3HQHZtgCbZFPty/Dik2vJo0y5aK27rBgNqyoD2jPgqNSi9D3
 +EZ0/QrfH+Nc7muuTii7kkGjE8ZrQt0GhtHj/hEFQ337Ae3im6D83v6C6EhHgiAvibVdeE4mn
 ua8alhR7rAs7OgwexHnqCQLPZ2s3OnoRn9bpn7TyelOeLhr9a6i+LvLnMUaPtqu/ziNw1LWxb
 2k4dXkvAenuVjox/H0FQlX/dJg+yoq48w7LR8HcnGb7BRFrdJiSxOFHLsTtMdgdT+kj55h6yg
 Uhkz9mZmLKQ/XslRZlJWVUgJylE5FkDSnF0ZQwnyG9cOmIgVFBE+35V9sIe0q2bwbsX2VMBnp
 SEryH+IkZUNPtb6iTrOpSzwuSYGwJyRmfvpx75FACNtKcAsqEe6lKLQ5WVRHmGqA3sdF7CUEv
 ixmQ2GtJow68w7R7vtJm5c7te8M5iBWt4P/xj9NmuXShJzZxEr6UC2bTc9FiwU7doa4YzHvGO
 NZpJpHieOgEnJ5++htF88SMPcBC86/3QI9jOAb68W2R+BHXJIPKZPsp8KlnvqmwA2mRpQS1sj
 0ZpauEJFaSoxF9w8nytSW0roB8ftpJLNDnlZy2T7QFfWMdb90R+XlEUKZylkYmIgxDRkrimXm
 QkeSFonl6yuWybOxUs4KPR+ARVfshG2HBCVx8OJnGxIZ1THXDgO5FCIpdHjvmVJ+2oAuLvVwM
 fsQ7LrthTnG5/ow+994ttoXN+uS6xFZohF2MHomfaX2aR2MVDPkAuD9ZuF0I6p3nZk5S0Fd7T
 bxBbdanbbM9qMtsTJY+zpwHnOXLqaQxku19pcPQWQ7WDzhtIjMoP1uuYCqegQgRyf3ecVYnR9
 lCvUw/o2B6dX1Oks9poR3h8CebOPUkFS89SMVybr2oTVqIr9N+5vSqBThctaxHEaiWsb6d5mt
 Gup+17BTXGQxpdZ0+KNHRdZgqelpnBzJyXxFmHv7m5qeGDQZYP4luG+sozMtS+1YWEEHVd+Uq
 PHGucFc2py3i1WNhzrFHV+PDmXSgfOmY3Eg44i6Uou6oGaCvZZ0kibRKK4oqcleHsNi22zxPS
 F6FRdeAt6ELaIUyY8fnQtFIGr+j9QKHJafaTBVkKvg4aZ3VW4kLmF2VCb+expamE82fG6Uba9
 4zQzA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 12:22:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 12:22:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Challenges around asterisk usage in SmPL code
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

>> @check@
>> expression x;
>> statement es;
>> @@
>> *if ( \( !(x) \| x == NULL \) )
>> *   <+... *(x) ...+>;
>>  else
>>     es
>>
>>
>> Can it be avoided to express assignment variations explicitly?
>
> I don't know what you are trying to do.

Can you get the impression that I am trying also to achieve something
around the detection of null pointer usage?


> Previously, you had the beginning of an assignment before the ...
> I suggested to replace the ... before and after the *(x) by <+... ...+>.

This variant gets accepted by the Coccinelle software.


> Strangely you have deleted the assignment part as well.

I became curious if such an approach should also work.


> Your code line with the <+... ...+> ends with a ;.

Yes - for this test.


> So the <+... ...+> must match an expression (which could be an assignment).

This can be appropriate.


> But due to parsing priorities, <+... ...+> that is unknown is parsed as a statement.
> So the ; causes a parse error.  To force the <+... ...+> to be parsed as
> an expression, you have to surround it with ().  An isomorphism will
> normally cause the case without the parentheses to be considered as well.

Thanks for this explanation.


> None of this has anything to do with unary operators.

This view is reasonable.

I just put a search pattern with an asterisk into this SmPL construct.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
