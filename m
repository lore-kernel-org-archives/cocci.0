Return-Path: <SRS0=Fhwl=3A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1ADC282DD
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 15:36:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7259206ED
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 15:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7259206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00BFaXBe004036;
	Sat, 11 Jan 2020 16:36:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 108FD77DF;
	Sat, 11 Jan 2020 16:36:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 733487718
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 16:36:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00BFaTcF007785
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 16:36:29 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,421,1571695200"; d="scan'208";a="430910632"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jan 2020 16:36:29 +0100
Date: Sat, 11 Jan 2020 16:36:28 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Wen Yang <wenyang@linux.alibaba.com>
In-Reply-To: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2001111633130.2568@hadrien>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 16:36:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 16:36:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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


On Fri, 10 Jan 2020, Wen Yang wrote:

> do_div() does a 64-by-32 division.
> When the divisor is unsigned long, u64, or s64,
> do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> This semantic patch is inspired by Mateusz Guzik's patch:
> commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom() calculation")
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

This looks good to me.

A small detail is that you don't need the parentheses in:

@r depends on (org || report)@

julia

> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Matthias Maennich <maennich@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org
> ---
> v3:
> - also filter out safe consts for context mode.
> - cleanup code.
>
> v2:
> - add a special case for constants and checking whether the value is obviously safe and no warning is needed.
> - fix 'WARNING:' twice in each case.
> - extend the warning to say "consider using div64_xxx instead".
>
>  scripts/coccinelle/misc/do_div.cocci | 155 +++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/do_div.cocci
>
> diff --git a/scripts/coccinelle/misc/do_div.cocci b/scripts/coccinelle/misc/do_div.cocci
> new file mode 100644
> index 000000000000..79db083c5208
> --- /dev/null
> +++ b/scripts/coccinelle/misc/do_div.cocci
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// do_div() does a 64-by-32 division.
> +/// When the divisor is long, unsigned long, u64, or s64,
> +/// do_div() truncates it to 32 bits, this means it can test
> +/// non-zero and be truncated to 0 for division on 64bit platforms.
> +///
> +//# This makes an effort to find those inappropriate do_div() calls.
> +//
> +// Confidence: Moderate
> +// Copyright: (C) 2020 Wen Yang, Alibaba.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +@initialize:python@
> +@@
> +
> +def get_digit_type_and_value(str):
> +    is_digit = False
> +    value = 0
> +
> +    try:
> +        if (str.isdigit()):
> +           is_digit = True
> +           value =  int(str, 0)
> +        elif (str.upper().endswith('ULL')):
> +           is_digit = True
> +           value = int(str[:-3], 0)
> +        elif (str.upper().endswith('LL')):
> +           is_digit = True
> +           value = int(str[:-2], 0)
> +        elif (str.upper().endswith('UL')):
> +           is_digit = True
> +           value = int(str[:-2], 0)
> +        elif (str.upper().endswith('L')):
> +           is_digit = True
> +           value = int(str[:-1], 0)
> +        elif (str.upper().endswith('U')):
> +           is_digit = True
> +           value = int(str[:-1], 0)
> +    except Exception as e:
> +          print('Error:',e)
> +          is_digit = False
> +          value = 0
> +    finally:
> +        return is_digit, value
> +
> +def filter_out_safe_constants(str):
> +    is_digit, value = get_digit_type_and_value(str)
> +    if (is_digit):
> +        if (value >= 0x100000000):
> +            return True
> +        else:
> +            return False
> +    else:
> +        return True
> +
> +def construct_warnings(suggested_fun):
> +    msg="WARNING: do_div() does a 64-by-32 division, please consider using %s instead."
> +    return  msg % suggested_fun
> +
> +@depends on context@
> +expression f;
> +long l: script:python() { filter_out_safe_constants(l) };
> +unsigned long ul : script:python() { filter_out_safe_constants(ul) };
> +u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
> +s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
> +
> +@@
> +(
> +* do_div(f, l);
> +|
> +* do_div(f, ul);
> +|
> +* do_div(f, ul64);
> +|
> +* do_div(f, sl64);
> +)
> +
> +@r depends on (org || report)@
> +expression f;
> +position p;
> +long l: script:python() { filter_out_safe_constants(l) };
> +unsigned long ul : script:python() { filter_out_safe_constants(ul) };
> +u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
> +s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
> +@@
> +(
> +do_div@p(f, l);
> +|
> +do_div@p(f, ul);
> +|
> +do_div@p(f, ul64);
> +|
> +do_div@p(f, sl64);
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +ul << r.ul;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))
> +
> +@script:python depends on org@
> +p << r.p;
> +l << r.l;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_long"))
> +
> +@script:python depends on org@
> +p << r.p;
> +ul64 << r.ul64;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_u64"))
> +
> +@script:python depends on org@
> +p << r.p;
> +sl64 << r.sl64;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_s64"))
> +
> +@script:python depends on report@
> +p << r.p;
> +ul << r.ul;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_ul"))
> +
> +@script:python depends on report@
> +p << r.p;
> +l << r.l;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_long"))
> +
> +@script:python depends on report@
> +p << r.p;
> +sl64 << r.sl64;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_s64"))
> +
> +@script:python depends on report@
> +p << r.p;
> +ul64 << r.ul64;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_u64"))
> --
> 2.23.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
