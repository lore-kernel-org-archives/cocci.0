Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A54C433EF
	for <cocci@archiver.kernel.org>; Thu, 19 May 2022 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JIg7ChsyzOO8F90q3Vy8AY1YUWWE9UfxDaDs5d+PoKo=;
  b=o5Xo7JEsZYKcNziwlEoKLzfTe98Mb+cyNLjd0qiYbWyDWJ99ZcDgoWyO
   +sAzp3Zkf+ZWVD8lq9/Cp8roDFFL0vCMmJW92U+BhKX2YusaeDY89IHHe
   UsZeQK5bOwkMVxJEO8AnNhxUDPbK6CBSU4rbVvJnnsOU68xfDeeKiReGC
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37205222"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2022 21:52:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82A1EE0096; Thu, 19 May 2022 21:52:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 14C2BE0094
	for <cocci@sympa.inria.fr>; Thu, 19 May 2022 21:52:19 +0200 (CEST)
IronPort-SDR: 4FQtJC9uQOfcu4/nZm7qoAc9nqDWBv6K9r4d8TJccVnS+1/HsRdJqYJTm2bIm/b3vvk0vdhLx1
 4pj3IGb+uwvXwGSKfUokjd7oesHBX80B2r+3BS7+sl/jrmbide+W3uRiS86egyr88hQSVq0wWJ
 2E+q/tn33XQBybLw9yajzjDjKyTQTZA/bYK3pDJh8Pfa3d66QYZo4glWUeKswLhUwWc3/5ffPI
 +G1HujWDd6W8Cnb7GLMAK3IG/hLmMb6LKoZA9l5/VrG9Gg7prpUd6r3IJR1GZ5QJnAtqqpbalL
 OlMEf3i7Z7UbN4p63Go4GVgq
X-IPAS-Result: =?us-ascii?q?A0AdAAC5n4ZihwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgiSBUy0EC0OETpw2hxuEUodMCwEDAQ0/AQIEAQGEeAoCh?=
 =?us-ascii?q?T8CHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNC?=
 =?us-ascii?q?QUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAMDIx0BAREmAQ8LGgIfBwICV?=
 =?us-ascii?q?wYBDAgBAYJ5gmMBAzWsHoExgQGCCAEBBoRKHywiUoFcCYEQLAGKGC8JhBInE?=
 =?us-ascii?q?IFVRIEVJ4JTMD6BD4J8UoM9gmWVYSgEDwMcMjkSgSFxAQgGAwMHCgUyBgIMG?=
 =?us-ascii?q?BQEAhMSTQYdAhMFBwoGFg4UHBISGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjC?=
 =?us-ascii?q?wIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEB?=
 =?us-ascii?q?gMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmAwICG?=
 =?us-ascii?q?wcCAgMCBhcGAgIZWAooDQgECAQYBB4lEwUCBzEFBC8CHgQFBhEJAhYCBgQFA?=
 =?us-ascii?q?gQEFgICEggCCCcbBxYZHRkBBTYnBgsJIhYGCiILBgUGFgMmUicFCgoGIgEbA?=
 =?us-ascii?q?pdKeoMNkjqPTJ5cNAeCE4E9gUMMnikGEy2WUA4GkXUtkQyFLiCnDYF4gX4zG?=
 =?us-ascii?q?iSDN04BAgECDQECAgMBAgECCQEBAo4dGR6DbootPzQ7AgYLAQEDCYVHAQGHf?=
 =?us-ascii?q?oJIAQE?=
IronPort-PHdr: A9a23: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
 JdcE9dm
IronPort-Data: A9a23:1kbV4qviOsuraNZuV3nwZySTgufnVHtYMUV32f8akzHdYApBsoF/q
 tZmKTyHOf/YYjenfNt/aYW3/RwHv8TRnNQ3TwM5+CExF39EgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52LBVPyvX4
 Ymo+5CGaQf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnZCMcwZwEbPRo7UyaEJ0TxNnMJZY1LCSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN03F3Ipaw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcDg21o25oXQJ4yY
 eInc2FTTzLvcSZDYEsnCrYDm+f4iVvgJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 0AowCt3grYvzx2EdYLRAy+hrUWakhFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaWCkeGmZCO
 rihwImBONB/jFGGYS7Mru/P9lteLQBFcTVdOUfoWCNYu4GLnW0lsv7YZvpOeEJfpv78AzXr2
 S2KoUDSbJ1M05dQiM1XEXjtij6hoN325dov+hnaW2io9AwRWWJIT4mv9ESd8vtKaoqUJrVgg
 JTms5jEhAztJcjT/MBofAnrNOz5jxpiGGCN6WOD57F7q1yQF4eLJOi8Gg1WKkZzKdojcjT0e
 kLVsg45zMYNYSH6PP8pOdzuVZlCIU3c+TLNCaG8gj1mPckZSeN71H0yDaJt9z2xwRZ3y8nTx
 7/BLZr1VB729piLPBLvGrtDiOZ1rszP7TqdHNj6yQiqy7yTeDacRt843KimPogEAFe/iFyNq
 b53bpPUoz0GCbGWSnSJreY7cA5bRVBmVMieg5EGLYarf1s2cEl/UaO56e16IeRNwf8K/tokC
 1nmBye0PnKk2SaYQehLA1g/AI7SsWFX9CJkYnd0Zw7zs5XhCK72hJoim1IMVeFP3IReITRcE
 5Hpou2MXaZCTCrp4TMYYcWvpYBubkr5mg+EeSaoOWBtc5llTg3P29nlYgq2qHhQVHXq75Nmr
 u3yzB7fTLoCWx9mUpTcZsWv+FXt73ITr+R/AhnTKd5JdUSwq4VncnSjjvI+L8wWBw/Ewz+Wi
 1SfDRsC+7vSroVz/NSQ3fKIqIKgEu1fGEtGHjCHvOjsanSApjKumNYSXvyJcDbRUHLP1J+jP
 egFnevhNPAnnUpRt9QuGbhczZU4u4nlqYhcw1k2B37MdVmqVuhtL3Taj8lCsqpBmu1QtQesA
 xvd/95HJfOWNcmjHFNIfFgpaeGK1Pc1nDjO7K1pcRugu3ItpOKKARdIIh2BqC1BN78rYokr9
 ucWvpJE4QKIjBd3YM2NiTpZ9jjXI3FcAb8rsIoWXN3ihgYxkwgQZJvBFmnp7ZvJZ9gVahsmJ
 TqdhazjgbVAxxOeIiRpSiWXhbJQ1cYUpRRH7F4ePFDXyNDLsf8A2kED+zoASAkInA5M1Ph+O
 zQwOkB4TUlUE+yEWCSes6GQ9wB96Nmx/0vs1x0WmWefQ0TAuqkh6oEiEb7lwazb2zs0kvtnE
 HWw12vvFzrnFC009jVnQlZr8pQPUvQonjAvW6mb8wCtAJQwJzbo6kNriazktDO/af4MaIb7S
 SWGMQq+hWAX9cLdnkHjN7Sn6A==
IronPort-HdrOrdr: A9a23:99A4k6gIb8cpjhmhbccYX+vIyXBQXv4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37205215"
X-MGA-submission: =?us-ascii?q?MDGny7TXd0glK4hQrDNHfa0CjTGyxXX7RLH6hu?=
 =?us-ascii?q?BF8Hu8nILNHkXvpZnJq9wF59SDUcGhEabZp5ezP73kMVdkPtn0QA6p3Z?=
 =?us-ascii?q?6sV8iif2EQYMqWfSlPSDUCoGYIGs8MtMeyyd4RTXKXjO4n3JeFaF5oET?=
 =?us-ascii?q?a58AMp9l4LjgfofuscSbBSQw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 21:52:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652989930;
	bh=y0I5jrxX9/d0x2479L/o9QxE0nXzuhmQFJBAjBIXDI8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=KSE6mops9IMZRgIey+dMdJXx/Ssjba2kQIdCrP2WibAg24u09XHF5vDjfwVlpq9Bx
	 BfWjdbLxRlGIIZKDLEOrxxSV1bQgKc80fPaAgshV47+Ew8+4K2ETUo0k7JGwtPN8Wa
	 zM3xzxxu6ME9fOmXNCiO9bNo8bTCJE5IW8V7GeyA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.56.145]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7usw-1nvbgG1gYs-005CBa; Thu, 19
 May 2022 21:52:10 +0200
Message-ID: <c1d5d00d-d770-530b-abfa-0c1f462e5f22@web.de>
Date: Thu, 19 May 2022 21:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Phil Edworthy <phil.edworthy@renesas.com>, linux-clk@vger.kernel.org,
 cocci@inria.fr
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220517133556.6934-1-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hOvUXYio+MaFrGArqAPtCosiMP+R1r2OBnYfUrcCTKrfRPP8Jkz
 ZSg61UDEsahsz8RtfG/UYMLdVLIpeq4GD8G+wVwvYC+VVq1XHWMHS7kzyyLPgNcabpVuRgE
 W3iPJlVtyXc+vnq70INdzdqwZcrIrdayDvazMbaMBmVOjK3gZ0Vm765Qbqp7q0rSVYLW/J6
 ytDvZ3Vwy+p8zICAGDpXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q7/DbtJQE7c=:cyQNNHjzRViFIwD8ixuZS9
 GecCucTS6LQFrEi/SloKTAz04E1XqWGpCNI/4ZPZV7CVcl/rHwpSnyCNVk2RLqOPUzeM3xAj5
 3kDqh8hAh0T+vu85GiDPdK/vRCsvrui0Pa1XTwuoBwH70ZijkIcS4N95EQO1tupmOsGDONnIE
 gLTI3b9O1tUqnZOlAlelBUFvvyu/snQ4YDPVS4u2rnde50+39H/alu9nFfVoJb8CH2ntLKiph
 f3NOFyjTnSordywcL/pljU17LIFnb5ZfAyNhHO1j/vgnmycQl3X3oZDJ8cTkyJBVLk4nTtd6q
 TofSr1it8PED09so0rUppTLTkHJUL5um/qBnMy2MKgbPoL435BMNqrJt5P1SDDmg7uw//xzYp
 XjvkDjNxTUrDeAEnKsnNRYPu3sVixeQgE4cRfcZB/d5YTB5ZR4L1Nt0hi6tgk0ue+o4wwakCu
 RwSnlIHx7H1yiWFP0L3KkiLHSn/TfyusqYBHr1khALGGeLDDxUkK9WThHa0YD9nI/+DxG0QjI
 /HatKLGu/+/h4GJ/x43Tm1mdmy9d2QS6s++Rb2hsWgemNkAgun45afKWQQRTojXjGJRJ2K+mO
 +sam9r+vdzSgPYNnmtPehnlybZf5Ge4z5P9oGm5aWCAR5LQy67rkbqlItWLNsTC8SCc09fV+v
 gFy/zxRxcdGJuTWqRfRFq/Cdf6H3AM+L2PB4txv3Zl9EgjFaaLgaY599U8qFLcOI3jAOf1mGa
 sGCbpdfw1Lc7ZA8v2qVmODIQ7ha2uKF4nI0WdYJaBxW1K6fQBop1dyS3OBhJAsWWnXCkCjQk6
 lBjcz06letRj5wQD/f9/8F3bV+LW8wZiKobr/AttQOt/6QXILWP07dROPmy620yjy0BJvCxgY
 x5hwtXUrWlVvbAxPmN4mnyVekB/TA/0tuDk6derCF2w+9ihPjHNXoh4eoYugsBo98oo26Binv
 nKVNhtTEPzdca6aPXBBlcRom8Nw0OIdLRRhkfqaDEzuEWvZygJRWZXj1tQ63pt6lbUJpgucfn
 6DUtbnVpu200P6vl4ZXj3FTdigO18O8691n0B7jJnLk8iSat17r+kEdvcAF7s0uLw/QPs+2xz
 IDZ1CD3C6ARmcL1nbgTb97N+iElgTyiXRnIpUHLNlHFS2b8RcwUnAkqVQ==
Subject: Re: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 400
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/c1d5d00d-d770-530b-abfa-0c1f462e5f22%40web.de>

> +@depends on patch@
> +expression clk;
> +@@
> +
> +- if ( \( !clk \| clk != NULL \| !IS_ERR(clk)  \| !IS_ERR_OR_NULL(clk) \) )
> +{
> +clk_disable_unprepare(clk);
> +}


I guess that you would like to mark the curly brackets also for deletion.

How do you think about to handle simple and compound statements with your
source code transformation approach?



> +@script:python depends on report@
> +p1 << r.p1;
> +p2 << r.p2;
> +@@
> +
> +msg = "ERROR: clk_disable_unprepare already checks for valid ptr so check on line %s is not needed" % (p1[0].line)

I imagine that it can be a bit clearer to split the message into two sentences.

Can a line break help here?


Regards,
Markus
