Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FCDC77B73
	for <cocci@archiver.kernel.org>; Sun, 23 Apr 2023 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=X7NhJ1l/Eq6VmBha5pmYJz6G6NSNvefG8QKvK9NEC4g=;
  b=O4FXJQVf3n+Mb7RN2TW0e05g3NVqsjtv/PSuBc3gbp5iC/DuIFZVmRmq
   3Q1lCWnksEduQSoUXGG/Os1tJaGxcmHWM0off4CW+xALiev8hZ/LUbEVG
   OwW7dNzWIbOJY6XuPQImHCOWdxx/Dlb6c+USe4mEwGjnwhieihJezPLEx
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.99,220,1677538800"; 
   d="scan'208";a="104414423"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2023 09:39:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2368EE0269; Sun, 23 Apr 2023 09:39:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B3CB0E019E
	for <cocci@sympa.inria.fr>; Sun, 23 Apr 2023 09:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X7NhJ1l/Eq6VmBha5pmYJz6G6NSNvefG8QKvK9NEC4g=;
  b=A0trxS2ClOnY7yXKKIt/5q6duLaFLWEryVj7plUsw4PozVGMEkQjPbdv
   jIGUUYmMryTC/wuEM/ZCe0NfAp+e1ps0wvaf54RalOyN0xyi4AG+JXDCe
   xn8T2XIEU41icTv09bvgUVcZwq/8xiJRxNXpnl2FHnyZSZW04a6aIJjWJ
   E=;
X-IronPort-AV: E=Sophos;i="5.99,220,1677538800"; 
   d="scan'208";a="104414399"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 09:39:55 +0200
Date: Sun, 23 Apr 2023 09:39:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
In-Reply-To: <dfed0b6a-5b20-3b06-9afc-69e808cb0c3b@web.de>
Message-ID: <alpine.DEB.2.22.394.2304230939260.2765@hadrien>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de> <alpine.DEB.2.22.394.2304221031370.2766@hadrien> <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de> <alpine.DEB.2.22.394.2304221724070.2766@hadrien> <dfed0b6a-5b20-3b06-9afc-69e808cb0c3b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-45023255-1682235594=:2765"
Subject: Re: [cocci] Checking selected contents from metavariables by SmPL
 scripting rules
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1125
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304230939260.2765%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-45023255-1682235594=:2765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 23 Apr 2023, Markus Elfring wrote:

> > But a helpful way to show some issue about whitespace around a string
> > would be somethng like
>
> Source file example:
> void f(void)
> {
> action(x, "X");
> action(y, "++");
> }
>
>
> SmPL script variant:
> @find@
> constant char[] input_string;
> expression input_context;
> @@
>  action(input_context, input_string);
>
> @script:ocaml special_display1@
> text << find.input_string;
> @@
> Printf.printf "text: =>%s<=\n" text
>
>
> Test result:
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch ../janitor/show_string_data_with_OCaml-20230423.cocci string_literal_usage4.c
> …
> text: =>"++"<=
> text: =>"X"<=
>
>
>
> Another SmPL script variant:
> @initialize:python@
> @@
> import sys
>
> @find@
> constant char[] input_string;
> expression input_context;
> @@
>  action(input_context, input_string);
>
> @script:python special_display2@
> text << find.input_string;
> @@
> sys.stdout.write('text: =>' + text + '<=\n')
>
>
> Another test result:
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> spatch ../janitor/show_string_data_with_Python-20230423.cocci string_literal_usage4.c
> …
> text: =>  "++"<=
> text: =>  "X"<=
>
>
> Will such a data presentation trigger further software evolution?

Thank you for presenting the problem in a much more understandable way.  I
will take a look.

julia
--8323329-45023255-1682235594=:2765--
