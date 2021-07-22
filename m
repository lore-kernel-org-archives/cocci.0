Return-Path: <SRS0=EbQ7=MO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5775C4338F
	for <cocci@archiver.kernel.org>; Thu, 22 Jul 2021 20:11:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C3260EB5
	for <cocci@archiver.kernel.org>; Thu, 22 Jul 2021 20:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4C3260EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16MKB30O009087;
	Thu, 22 Jul 2021 22:11:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 07CF97783;
	Thu, 22 Jul 2021 22:11:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DCCF43FE7
 for <cocci@systeme.lip6.fr>; Thu, 22 Jul 2021 22:11:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16MKB0Z1003083
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 22 Jul 2021 22:11:00 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkKASV678tHKvy6NIcQPXwHPXdLJyesId70hD?=
 =?us-ascii?q?6qm+c31om6uj5qaTdZUgpHjJYVMqMk3I9ursBEDtex/hHNtOkOos1VnLZnibhI?=
 =?us-ascii?q?LqFvAe0WPaqweQZBEWj9Qtq5uIEZIfNDSANykfsS+g2njALz9I+rDum5xAx92u?=
 =?us-ascii?q?rUuFKzsEV0gK1XYdNu/0KCNLrSB9dOsEPavZyMpbhiaqPU8aZt68ARA+LpL+ju?=
 =?us-ascii?q?yOupL6QAIMQyUq4gmWjT+u9dfBYmOl9yZbfTNT4KsotVPImQzh5qmlrrWSxxLG?=
 =?us-ascii?q?23XIhq4m6OfJ+59sBNGslsNQEDnqhwqyDb4RI4G/gA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,262,1620684000"; d="scan'208";a="521138992"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2021 22:11:00 +0200
Date: Thu, 22 Jul 2021 22:11:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?UTF-8?Q?Andrew_=F0=9F=91=BD__Yourtchenko?= <ayourtch@gmail.com>
In-Reply-To: <CAPi140Mgk8zEk9vStbBU4Hh6oEMU2i6Kaji502AojELjFCR1OA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107222203110.42931@hadrien>
References: <CAPi140Mgk8zEk9vStbBU4Hh6oEMU2i6Kaji502AojELjFCR1OA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2007497743-1626984660=:42931"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 22 Jul 2021 22:11:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 22 Jul 2021 22:11:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] how to make substitutions at the end of the function,
 vs. the end of each block ?
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2007497743-1626984660=:42931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 22 Jul 2021, Andrew 👽  Yourtchenko wrote:

> Hi all,
>
> I work on the VPP project (http://fd.io/ - open source software
> dataplane), and  tried to use coccinelle to make a relatively
> non-trivial change
> as in the mail https://lists.fd.io/g/vpp-dev/message/17532 - it seemed
> to be a very good candidate - boring enough to be painful to do by
> hand, complex enough to make sed inadequate for it.

Thanks for trying Coccinelle :)

>
> I came up with this semantic patch:
>
>
> @ detect_func @
> identifier CLI_FN, AVM, AIN, ACMD;
> fresh identifier LAIN = "line_" ## AIN;
>
> statement S1;
>
> typedef clib_error_t, vlib_main_t, unformat_input_t, vlib_cli_command_t;
> @@
>
> static clib_error_t *CLI_FN (vlib_main_t * AVM, unformat_input_t *
> AIN, vlib_cli_command_t * ACMD)
> {
> + clib_error_t *e = 0;
> +  unformat_input_t *LAIN;
> ...
> + if (!unformat_user (AIN, unformat_line_input, LAIN)) {
> +    return 0;
> + }
> +
> -  while (unformat_check_input (AIN) != UNFORMAT_END_OF_INPUT)
> + while (unformat_check_input (LAIN) != UNFORMAT_END_OF_INPUT)
> S1
> <...
> - return ERR;
> + e = ERR;
> + goto done;
> ...>
> +done:
> + unformat_free(LAIN);
> + return e;
> }

The problem has to do with the fact that Coccinelle is actually oriented
around control-flow graphs. So it doesn't know which end of a control-flow
path is actually the end of the function.

You can try adjusting the line <... above as follows:

<... when != true exp
     when exists

exp should be declared as an expression metavariable.  The when != true
thing means that the path cannot cross a true branch across a test of an
expression that matches exp (ie any expression).  The when exists means
that the paths through this region of code are considered individually.

I'm not certain that this will work in every case.  It will be necessary
to check the results carefully.

Another possible hack is to first replace every return under and if,
while, etc by something else, and then rewrite all of the returns in a
third rule afterwards.  This is pretty ugly, but may be more reliable.

julia

>
> I attempt to run it on this test file:
>
> ubuntu@vpp-dev:~$ cat ~/test.c
> static clib_error_t *
> syn_filter_enable_disable_command_fn (vlib_main_t * vm,
>                                       unformat_input_t * input,
>                                       vlib_cli_command_t * cmd)
> {
>   vnet_main_t *vnm = vnet_get_main ();
>   u32 sw_if_index = ~0;
>   int enable_disable = 1;
>   int rv;
>
>   while (unformat_check_input (input) != UNFORMAT_END_OF_INPUT)
>     {
>       if (unformat (input, "disable"))
>         enable_disable = 0;
>       else if (unformat (input, "%U", unformat_vnet_sw_interface,
>                          vnm, &sw_if_index))
>         ;
>       else
>         break;
>     }
>
>   if (sw_if_index == ~0)
>     return clib_error_return (0, "Please specify an interface...");
>
>   rv = syn_filter_enable_disable (sw_if_index, enable_disable);
>
>   switch (rv)
>     {
>     case 0:
>       break;
>
>     case VNET_API_ERROR_INVALID_SW_IF_INDEX:
>       return clib_error_return
>         (0, "Invalid interface, only works on physical ports");
>       break;
>
>     case VNET_API_ERROR_UNIMPLEMENTED:
>       return clib_error_return (0,
>                                 "Device driver doesn't support redirection");
>       break;
>
>     case VNET_API_ERROR_INVALID_VALUE:
>       return clib_error_return (0, "feature arc not found");
>
>     case VNET_API_ERROR_INVALID_VALUE_2:
>       return clib_error_return (0, "feature node not found");
>
>     default:
>       return clib_error_return (0, "syn_filter_enable_disable returned %d",
>                                 rv);
>     }
>   return 0;
> }
> ubuntu@vpp-dev:~$
>
>
> However, when I run it, the "done: " label, etc. gets inserted twice:
>
> ubuntu@vpp-dev:~$ spatch --sp-file /tmp/rules.sp
> --allow-inconsistent-paths  ~/test.c
> init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
> HANDLING: /home/ubuntu/test.c
> diff =
> --- /home/ubuntu/test.c
> +++ /tmp/cocci-output-56896-8f35c5-test.c
> @@ -3,12 +3,18 @@ syn_filter_enable_disable_command_fn (vl
>                                       unformat_input_t * input,
>                                       vlib_cli_command_t * cmd)
>  {
> +  clib_error_t *e = 0;
> +  unformat_input_t *line_input;
>    vnet_main_t *vnm = vnet_get_main ();
>    u32 sw_if_index = ~0;
>    int enable_disable = 1;
>    int rv;
>
> -  while (unformat_check_input (input) != UNFORMAT_END_OF_INPUT)
> +  if (!unformat_user(input, unformat_line_input, line_input)) {
> +      return 0;
> +  }
> +
> +while (unformat_check_input(line_input) != UNFORMAT_END_OF_INPUT)
>      {
>        if (unformat (input, "disable"))
>         enable_disable = 0;
> @@ -48,6 +54,12 @@ syn_filter_enable_disable_command_fn (vl
>      default:
>        return clib_error_return (0, "syn_filter_enable_disable returned %d",
>                                 rv);
> -    }
> +    done:
> +      unformat_free(line_input);
> +      return e;
> +  }
>    return 0;
> +done:
> +  unformat_free(line_input);
> +  return e;
>  }
> ubuntu@vpp-dev:~$
>
>
> I get a feeling I am missing something fundamental - but RTFM did not
> help much... What am I doing wrong / missing ?
> Could anyone please nudge me in the correct direction ?
>
> Thanks a lot!
>
> --a
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-2007497743-1626984660=:42931
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2007497743-1626984660=:42931--
