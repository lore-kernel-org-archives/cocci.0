Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E7EC433F5
	for <cocci@archiver.kernel.org>; Wed, 16 Feb 2022 15:38:24 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,374,1635199200"; 
   d="scan'208";a="21695605"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2022 16:38:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02FA6E0163; Wed, 16 Feb 2022 16:38:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E4142E008D
	for <cocci@sympa.inria.fr>; Wed, 16 Feb 2022 16:38:19 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=derek@knosof.co.uk; spf=SoftFail smtp.mailfrom=derek@knosof.co.uk; spf=None smtp.helo=postmaster@avasout-ptp-001.plus.net
IronPort-SDR: SiXpLaXO1sLIhSNP+dT8o/Lq84s5pOjsnt9oi3ySZWaDxOPNOjHZ+OH54l6TmeY9NZsns2i1Dt
 qjWXCXkZq4cNa83FoHqXX18XYY1pCxeCcKuEQBO2wrpttfjBY4RMKzagGD9wczxGm0lFdfytZT
 9aK+W4fTj6L2ep2Q7n+p9ERZMrjtymN2tGdxcxhQ0+fkJiWJjPHJgt0DSIz2F2fsGGJqM3d0FF
 IJ54gxuE9cYaQdH29rwvsMRuhZybWLPiH9tjok9i+D/0vOdPnnKpt2F3zOURBtimjb0KBXjrPx
 WAGzOlM7CCC35wZyytSYe2An
X-IPAS-Result: =?us-ascii?q?A0AHAwCcGQ1ibOPmXVRagQmEAgd3VysEC0KEVJBpMZ5VC?=
 =?us-ascii?q?wEDAQ03CAIEAQGCEoJ1AoQCAh0MBS8TAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECAwQBExELBwcGDAUSDgU8ZGiBT4F0CzQNgjUig2wBBAEjFUYLCxoCJ?=
 =?us-ascii?q?gICVxMIAQGDAAGCdSEEC6tggTGBAYMjLAEWGG2DLIFeBoEQLI5DFxAWBoINg?=
 =?us-ascii?q?TwMA4JEMD6CYwGCLoJLgmUElUGCd6EbnmeDUYktPYEalEgGDwUug2CSTgyRV?=
 =?us-ascii?q?h2WLY0SmWCBeIF+TTQEgnABATJOAQIBAg0BAgIDAQIBAgkBAQKSDopeQTQ4A?=
 =?us-ascii?q?gYLAQEDCYVGPosaAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:20ApJa0PLiXrN9Ib1vbD5eB3kn2cJEfYwER7XKvMYLTBsI5bpz0Ez
 DEeCzqFa/7ZNDPwLdAlOY638ksC7JLWyNMyGQNq3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQzy4bVvqYy2YLjW1nU5
 4uoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt4p71
 9F9iKSwdRw4A/DuwsE3AkFlFQgraMWq+JefSZS+mcWNxlbBbmep2+l2SRluZMsA/vtsR2dD6
 ZT0KhhdMlbS3KTsm+r9ELMz7iggBJGD0Ic3tnx6wDLxDvAhWpfNBa7No8JbtNs1rp4XRK6HN
 5FxhTxHbRHqTBRkOw0tAZM+scqEnknzQyJJkQfAzUYwyzOJllwriOCF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoQdp6VqlmObUmj7nHZoODPjgrqcsmFmO3SoVBQF+uUaHTeeR0EShX+JiE
 0wo4TsT8Ipo0Wb6FuT7dkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYfMbTKU+doHVQXO
 k+1c8DBWGc04efFIZ6J3vLN8G/vZED5OEdbPUc5oR05D87Lj6tbYvjnddZuHqC0g9n5cd0b6
 wvUxMTSr5gVgsoC0anTwLwqqzuyr4POUxJw/hnPGzr9t0VhYJO+IYql9TA3DMqszq7HETFtX
 1BdxqByCdzi67nRyERhp81RQdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hOP6F8AtMcKYyv1BUOSX25XI5p0pUQHPYq4Ps04kvISPvCdiSfcoHk3OxLAt4wTuBR3z/liU
 XtkTSpcJS1AU/Q9lGLeqxY1ybs23SYz2QvuqWPTkXyaPU6lTC/FIZ9caAXmRrlgvMus/VuJm
 /4CaZri40gPAYXWP3iLmaZOfABiBSZgXvje9ZcIHtNv1yI2cI3XI6KJnupJlk0Mt/89q9okC
 VnnCh8Ckwug3ySaQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 aBfKcaGBe9IRHLM/HIAbsCl/oBlcR2qgyOIPjakMGNvL8M/GVSR94+2ZBbr+QkPEjGz6Zk0r
 Yqm216JWpEEXQljUJvbZav3nVO8tHQQgsxoWE7MLoUBcUng6tEweS/3ieQwLYcHLlPexWLCh
 QqRBB4Zo8jLopM0oIKZ1f3b8d/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2eoqq+sU
 uNYkqPnO/odkVcW7odxHuo5za864Nez9bZWwh4+QCfCcV2wDa58Z2GaxYwX7vQL3rtEok2wV
 17WootWPrCAOcXEFl8NJVV0PrvTj61MwjSCv+4oJEja5TNs+ObVW0tlORTR2jdWK6F4Md94z
 Op96tQa7Rez1kgjPtqc1HwG/nqFNXsdT+A/qolfWNeyzBIv10oEZ5HAU3ek7JaKYtRKE08rP
 j7L1fqd1+4AnhLPIygpCHzA/etBnpBS6hpE+1kPegaSkd3fi/5rgRBc/FzblOiOIsmrDg6yB
 oRqC6GxDayQ9ixvmdQGR3y0XlkZXVuB/lHqjV0EiAU1iqVuunPldAUA1SSlpSj1MF6wuhBY+
 raDz2ijWjGsYcKZMu4aRxt+s/K6JTBu3laqpS1kdvhp27E5Zz3+haHobm1OthiP7QbdQqHYj
 bECwducopEX+cLdT2PXxmVaOXktpMi4GVF/
IronPort-HdrOrdr: A9a23:W7aZ+KmebzaOQjOU7bf+4RK4XeLpDfIG3DAbv31ZSRFFG/Fxl6
 iV7ZYmPMTP+U0ssR4b9+xoVJPhfZqYz+8S3WByB8bGYCDDuG+laJ5v9pHjxTqIIVyHygc178
 4JGMUTNDSzNykcsS+Q2miF+qEbsb26Gc6T9ITjJjtWIj2CEJsQljuR1TzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,374,1635199200"; 
   d="scan'208";a="6110183"
X-MGA-submission: =?us-ascii?q?MDFsdBphHG4UxMgoWEX02xJm+EEM/+AdzH1yJy?=
 =?us-ascii?q?qS72ngqiXUTbZfKyJgEvq1FM39g0EKicb9z6Js66P/FdfbwC/l8aHxDb?=
 =?us-ascii?q?sAL7J+zZrMq/aAzejGbg962CcZ1t2M8VGpwNtP74ZrhDfFIKxBC9fEjR?=
 =?us-ascii?q?gLis7jp23HHsk5/YWAoMkHpA=3D=3D?=
Received: from avasout-ptp-001.plus.net ([84.93.230.227])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:38:19 +0100
Received: from localhost.localdomain ([146.90.138.106])
	by smtp with ESMTPSA
	id KMNhngPEGdshDKMNinTs5x; Wed, 16 Feb 2022 15:38:16 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HNmgqqhv c=1 sm=1 tr=0 ts=620d1a68
 a=JuxLXg4YQuczP7c3B12D8Q==:117 a=JuxLXg4YQuczP7c3B12D8Q==:17
 a=IkcTkHD0fZMA:10 a=bB1losSDAAAA:8 a=ck400hXp75Oa8QSfy7YA:9 a=QEXdDO2ut3YA:10
 a=l5tUKbM-eQEA:10 a=jodkC11rQHUA:10 a=fF55zpIGIEQopqupB-e6:22
X-AUTH: derekshar@:46500
To: cocci@inria.fr
References: <trinity-d2f86e7d-49b0-44e7-8673-ffac34794a80-1645018456602@3c-app-webde-bs60>
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
Message-ID: <837ff738-477c-8188-943b-d5b3483eda41@knosof.co.uk>
Date: Wed, 16 Feb 2022 15:38:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-d2f86e7d-49b0-44e7-8673-ffac34794a80-1645018456602@3c-app-webde-bs60>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJivTyCHGFGdDG3Y3TIvN++4UV4kjgPYfEhKA8Iq/LGxb0Y/MOzMNR/d/6DvZq04VeiX5QUpFNeWwUspNpgOTUS9kgzLba+NQ5VjIwTI1HwxLc36J053
 03rL/MPjW31T5c/Iz88Ei/TNdeG20c+zqFv9rFXE7jTYQMbdUzOfC5+bErMGEF95T32ue+yMNkkzEg==
Subject: Re: [cocci] Supporting adjustments for JSON data structures with
 SmPL?
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 142
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/837ff738-477c-8188-943b-d5b3483eda41%40knosof.co.uk>

Markus,

> Will chances grow to work with a semantic patch language variant for the handling
> of JavaScript object notation data by the means of the Coccinelle software?

Have a look at semgrep.  The pattern matching functionality
is not nearly as sophisticated as Coccinelle, but it has
lots of potential
https://shape-of-code.com/2022/02/13/semgrep-the-future-of-static-analysis-tools/


-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
