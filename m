Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFEC4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:53:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E68B20708
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mcE2YO1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E68B20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OCrIXT010622;
	Thu, 24 Sep 2020 14:53:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CFC99778D;
	Thu, 24 Sep 2020 14:53:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C76B34452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 14:45:35 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OCjZxf018101;
 Thu, 24 Sep 2020 14:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600951534;
 bh=TDP+pHWLC04c+4nstjmJ/mZI6PbOGrNr4PK+Wb6n93w=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=mcE2YO1npak1aN8C2iImrvTYqYmMdQn2SNJr2g8JL8MLJqkJScO/pZncdF0BPW9gm
 T1qGFp+GWpiNdlt5UlDhvHfKv6i0uu3TJp6Cr2AYi7NE7F3rmPmh4QMflBJJcTLOTI
 WSrd+Hkqcoz227XUb3/8Ot8a1PSDrlic0L/I9qpc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.48.46]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le4js-1kmoHi1VDY-00pvSH; Thu, 24
 Sep 2020 14:45:34 +0200
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5a74b3c5-c0e9-1426-c477-72bb86bcf5ed@web.de>
Date: Thu, 24 Sep 2020 14:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:zf65oCXw6vQzDrRb3HaTKWAA/p/la1/fhZ/kSGmbeaY+7j28Wkw
 sg1kqOG209UN1VSzQ9OmwWBG5QmqOjjFPHon6tGe168Ly8zxBY5kVVayfRDQNdp+BnysL0x
 JVzpY+hFmTV3of1WPW55aAIKmDJzKYHfiqXACXYp7Fmau6XRTmzUKOFfQt4LGsTagKVA+Vd
 zDn1IQwypwKJB0qt/dT5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfw033XUEr8=:yYoxKWoscg2lJ/N5kfdMW2
 JT2oj/JcH/oVnjdrzqzgO+f6GKnR/nvkHbKw23wCk12zDMZemj7YMMySb58wNwUaEu0Nn5a39
 5UHyRMtj702cqTaUXbN2IF/VOJtJEDGAVoZBu4JaZpEYqVc3rPdvvtguSwp0A686I1QsvO19c
 PIwjLz2r234HcmENPeAhjRPugR5UrGDt5GhlCnu7NdoUqGixpvaipA9n2AyvvrVhU6OthNCsg
 HNknKC4dJ5CaWWYe2DrIX1YKHDRzh8NMaZrKhXPQL33ms618pfoVKunmrdIQlVfRQapthgG+6
 rpeQMLQeS5rmYlKVYz7MR9QaSbV2IAJk3kYGv/+r0qiYWYHtTZNSW4QDDrTnR6J+91Hzd9bXM
 RVnymevNdNF9swX3SzE9F67UoCeHq8U7+mbUp+AhogkYR5iN88xH1DVWrE770YhojeV6JuNNd
 yRG9j15M8usihnMqMtdpian5soEhqAMcYb0JMF9EG7mK6uihHG9i6Xqg2cwbB2H0bzlpPnJxs
 w3zRdBc0C5HS536iGyCLOWwUCLMvSV3tWoJhniCBE0GcIYjaNer8B2kkSGsboR3UarWh3+Oas
 BnBW01mIyIzbyoGf7WH6+1K2NJLXitSkoWpGJaG8Xmoj6nDv+0DSHJiwRUhikXQ6OkkY43sCD
 uvEZgTFg1QpPMOum783JfhjXXjuKydsxC2U0wwKa84Jf10GUr7g/qGRFYYa54ckXE+hjzc9Ny
 9wjU9/Wk9XYmHW6Iw4yDUgibWYcY6xzwqZTdG8IHi09GT/ZCaUx1rAxsPJqhOxNEWiAEQyjbq
 3oCKg8fYDaerd8Hgzxu4FJpxOE1fddfkoEP7hjEKz2liGOVkpB12gkDVfy8MWFDMiASlPlyiX
 rvHRHvHfOf6Caltui6xyoqzG+yXy4bNDli9UggEA8jqkZn5LMf/MdcH2Dc9pUSt9pyNyvDVTJ
 HjLT3On1CbqKSZfBY+KTiU8VlxJlApePhncDhEl47ATRvRHLavQs/pMAjlfpDxtcrZE/44gQo
 RQZeDblxuOl1AW3GrtwTqNcfatWCu0DipFJjMFtmtyzEWQtRGgiI99Qjt3be+xY32v5iO0CbB
 XnCxW/xEeEGVFZWU60BJ/+U1svJQRHJ9OTJHdQwdGPtDhLsbEqjQ64+XS+ZMT3lbqi6nMPcao
 zcBEvXPJFIrks6ad4veSohrO4XHwr0NdcNQRk2p8QU5dtDvPrmEDWUfWU7P/5BTLnQEQpKr7E
 Viz3zVM4QJQy5oX1vFh5RpDb5UNtGLJpGhp2hnw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 14:53:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 14:45:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 24 Sep 2020 14:53:17 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: iterators: Add for_each_child.cocci
	script
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

> +// Confidence: High

Will an addition like the following be helpful?

+// Options: --no-includes --include-headers


> +@r@
> +local idexpression n;
> +expression e1,e2;
> +iterator name for_each_node_by_name, for_each_node_by_type,
> +for_each_compatible_node, for_each_matching_node,
> +for_each_matching_node_and_match, for_each_child_of_node,
> +for_each_available_child_of_node, for_each_node_with_property;
> +iterator i;
> +statement S;
> +expression list [n1] es;
> +@@
> +
> +(
> +(
> +for_each_node_by_name(n,e1) S
> +|
> +for_each_node_by_type(n,e1) S
> +|
> +for_each_compatible_node(n,e1,e2) S
> +|
> +for_each_matching_node(n,e1) S
> +|
> +for_each_matching_node_and_match(n,e1,e2) S
> +|
> +for_each_child_of_node(e1,n) S
> +|
> +for_each_available_child_of_node(e1,n) S
> +|
> +for_each_node_with_property(n,e1) S
> +)
> +&
> +i(es,n,...) S
> +)

How do you think about to use the following SmPL code variant?

@r@
local idexpression n;
expression e1, e2;
expression list [n1] es;
iterator name for_each_node_by_name,
              for_each_node_by_type,
              for_each_node_with_property,
              for_each_matching_node,
              for_each_matching_node_and_match,
              for_each_compatible_node,
              for_each_child_of_node,
              for_each_available_child_of_node;
iterator i;
statement S;
@@
(
(for_each_node_by_name(n,e1) S
|for_each_node_by_type(n,e1) S
|for_each_matching_node(n,e1) S
|for_each_node_with_property(n,e1) S
|for_each_compatible_node(n,e1,e2) S
|for_each_matching_node_and_match(n,e1,e2) S
|for_each_child_of_node(e1,n) S
|for_each_available_child_of_node(e1,n) S
)
&i(es,n,...) S
)


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
