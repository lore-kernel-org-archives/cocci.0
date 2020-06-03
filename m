Return-Path: <SRS0=21EQ=7Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB9C433DF
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 17:52:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763302068D
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763302068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 053HqLMO022814;
	Wed, 3 Jun 2020 19:52:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E5BBD7567;
	Wed,  3 Jun 2020 19:52:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 44D9D3BAB
 for <cocci@systeme.lip6.fr>; Wed,  3 Jun 2020 19:33:38 +0200 (CEST)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.45])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 053HXbtB024877
 for <cocci@systeme.lip6.fr>; Wed, 3 Jun 2020 19:33:37 +0200 (CEST)
Received: from [10.68.32.192] (broadband-37-110-38-130.ip.moscow.rt.ru
 [37.110.38.130])
 by mail.ispras.ru (Postfix) with ESMTPSA id B1754CD465
 for <cocci@systeme.lip6.fr>; Wed,  3 Jun 2020 20:33:36 +0300 (MSK)
To: Coccinelle <cocci@systeme.lip6.fr>
From: Denis Efremov <efremov@ispras.ru>
Autocrypt: addr=efremov@ispras.ru; keydata=
 mQINBFsJUXwBEADDnzbOGE/X5ZdHqpK/kNmR7AY39b/rR+2Wm/VbQHV+jpGk8ZL07iOWnVe1
 ZInSp3Ze+scB4ZK+y48z0YDvKUU3L85Nb31UASB2bgWIV+8tmW4kV8a2PosqIc4wp4/Qa2A/
 Ip6q+bWurxOOjyJkfzt51p6Th4FTUsuoxINKRMjHrs/0y5oEc7Wt/1qk2ljmnSocg3fMxo8+
 y6IxmXt5tYvt+FfBqx/1XwXuOSd0WOku+/jscYmBPwyrLdk/pMSnnld6a2Fp1zxWIKz+4VJm
 QEIlCTe5SO3h5sozpXeWS916VwwCuf8oov6706yC4MlmAqsQpBdoihQEA7zgh+pk10sCvviX
 FYM4gIcoMkKRex/NSqmeh3VmvQunEv6P+hNMKnIlZ2eJGQpz/ezwqNtV/przO95FSMOQxvQY
 11TbyNxudW4FBx6K3fzKjw5dY2PrAUGfHbpI3wtVUNxSjcE6iaJHWUA+8R6FLnTXyEObRzTS
 fAjfiqcta+iLPdGGkYtmW1muy/v0juldH9uLfD9OfYODsWia2Ve79RB9cHSgRv4nZcGhQmP2
 wFpLqskh+qlibhAAqT3RQLRsGabiTjzUkdzO1gaNlwufwqMXjZNkLYu1KpTNUegx3MNEi2p9
 CmmDxWMBSMFofgrcy8PJ0jUnn9vWmtn3gz10FgTgqC7B3UvARQARAQABtCFEZW5pcyBFZnJl
 bW92IDxlZnJlbW92QGlzcHJhcy5ydT6JAlQEEwEIAD4WIQR2VAM2ApQN8ZIP5AO1IpWwM1Aw
 HwUCW3qdYAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRC1IpWwM1AwHyul
 D/sEtLx81fmyKhRMBxmwQxWg03ltA1UlxHbUImhEGNENrgi54tAuEfV+m/krGZo2tTEmMokm
 ftJikOLkZxSsbIhy/NUkfnFZMcmLdTBQc/vu0iUKe5UymcsEU/FLR8aQbeuWi/C+2i08fPxZ
 aRt+6IIG0n2WPPRtvWRslY0PSi3RBw8u+HHKSprZOO5P+W/OGhaoY7r2aCwPVHi8ITitVEPC
 PSvhUEVfQAvXIu+PjtOd4atXaEie839TIdUq4BmfdyMYUABddlIuj/pEB5xTspuvtUqZB/DT
 MzzRK50RFNuoDc+9IoTEhSxRGwG3KoYXfrIulChfnAAC1KD9/bTn7VNNgVVYl7NKR/EPFo4d
 iikXPj8UlAknAr9GT6PZPygweFUCXeSFYYUfxa8hYNBIHzBm7AkxFZ9VeNyrlHL5zXhQDO21
 U4dVT34tvzWAfYTNiYlplhQCrNhjtjZNJSpYmt8ftucVjU1udx16GVNe+c5q8JJbS6/SkijE
 Tr1XnqoyJtDG5KGaeBm5s7CNr6nippYQZc95/Ko/z8yBiBd6ltni9gt0dxoeh4DKXZB6gzjY
 6gRznUb6gM09PteixUtEYAQwbc5AEwL+qBsbK6A6CbFXlv21VOq8b1ND+tsCgKC2PKmum1Xh
 5amVKdEBx+r8V4pZV9xDVzAHYVzN5uw0FUgjOQ==
Message-ID: <5149c7dd-2771-e592-c5da-f36cca725a4e@ispras.ru>
Date: Wed, 3 Jun 2020 20:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 19:52:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 19:33:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 03 Jun 2020 19:52:19 +0200
Subject: [Cocci] How to match a part of a rule expression (documentation)
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

Hi,

I'm trying to write a rule to match consecutive function calls. For example:
@r@
expression E, E1;
@@

  call_func(E);
  ... when != E = E1
* call_func(E);

It works well, but not in case "E == p->f" and p is updated in between calls.
So, I'm to understand how can I avoid these kind of pointers update.

And fail case example:

struct test {
	int a;
};

void call_func(int);

void test(void)
{
	struct test t[10];
	struct test *i;
	for(i = t; i < i + 10; ++i) {
		call_func(i->a);
	}
}


While I tried to figure it out, I faced some cocci constructions with no documentation.
For example, what are rulekinds, "when strict", and "expression *r.E;", "expression E1 <= r.E;"?

1)
main_grammar.pdf, page 2:
rulekind ::= expression
             identifier
             type

What is it and how it could be used? I see that it's used in deref_null.cocci, doublebitand.cocci.

2) 
What is "... when strict"? Is it negation of "... when any" and enabled by default?

3) What is "expression *r.E;" in ./null/deref_null.cocci, for example:
43:expression *E;
54:expression *ifm.E;
115:expression *ifm.E;
175:expression *ifm.E;
239:expression *E;
248:expression *ifm1.E;

4) What is "expression  <= " in ./null/deref_null.cocci?
53:expression subE <= ifm.E;
114:expression subE <= ifm.E;
174:expression subE <= ifm.E;
247:expression subE <= ifm1.E;

Regards,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
