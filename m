Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE6C7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sqH2crmab4vqWtvLPn3ccSJkxBJQL2p3F3GKX9xwWEc=;
  b=avcuYKABS3jn/aac7lxV91K1g9TtZ8/TEMTOU0jxA8NNI63u4GDpwmeY
   e+PASDhzHxIKl5L8bP2+3ZgIcjMjW8N4/qcZeQ0dVPXfU8+KPGvYiw2q/
   7VoCSMkwP4NuMccYF+3enziFhNVxF59TiTAACt5KK1eIC/pIPDBhlAJB1
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104277801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 10:33:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6B34EE01D1; Sat, 22 Apr 2023 10:33:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AD86DE019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 10:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sqH2crmab4vqWtvLPn3ccSJkxBJQL2p3F3GKX9xwWEc=;
  b=uVtUeWmGoaiUHZLa+ZrDBGBc7mhchhjaJMor6peJE6sICogFwEN5VvNr
   5UDx55qXlb2+wH8D+sU6SYuhN70gehwIxmSOfdkwcpGP20ZBQsB6YloZ9
   XX/Vxp0k0BpUzEeSujdgn95bC5OLG5QSOUtvVzRSUYOqUUsfps3MnyRiE
   U=;
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54028199"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 10:33:34 +0200
Date: Sat, 22 Apr 2023 10:33:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Thierry Martinez <Thierry.Martinez@inria.fr>
In-Reply-To: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
Message-ID: <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1438587565-1682152414=:2766"
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1110
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304221031370.2766%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1438587565-1682152414=:2766
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Apr 2023, Markus Elfring wrote:

> Hello,
>
> I tried script variants out again for the semantic patch language.
> Software combnination: Coccinelle 1.1.1-00448-g8e007c83 (OCaml 5.0)
>
>
> @initialize:python@
> @@
> import re, sys
>
> @script:python selection1@
> @@
> text = '"]"'
> sys.stderr.write('text: ' + text + '\n')
> match = re.match('"([^"]+)"', text)
> if match:
>    content = match.group(1)
>    sys.stderr.write('content: ' + content + '\n')
>    if (len(content) == 1) or ((len(content) == 2) and (content[0] == '\\')):
>       sys.stderr.write('Result: c\n')
>    else:
>       sys.stderr.write('Result: s\n')
> else:
>    sys.stderr.write('no match\n')
>
>
> Expected test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch match-20230422-debug.cocci seq_printf1.c
> …
> text: "]"
> content: ]
> Result: c
>
>
> A corresponding source file example:
> int main(void)
> {
> 	seq_printf(seq, "]");
> 	seq_printf(seq, "<>");
> 	seq_printf(seq, "%s", "Test");
> 	return 0;
> }
>
>
> @initialize:python@
> @@
> import re, sys
>
> @find_update_candidate@
> constant char[] input_string;
> expression input_context;
> position pos;
> @@
>  seq_printf@pos(input_context, input_string);
>
> @script:python selection2@
> call;
> param << find_update_candidate.input_string;
> pos << find_update_candidate.pos;
> text;
> @@
> sys.stderr.write('param: ' + param + '\n')
> match = re.match('"([^"]+)"', param)
> if match:
>    content = match.group(1)
>    sys.stderr.write('content: ' + content + '\n')
>    if (len(content) == 1) or ((len(content) == 2) and (content[0] == '\\')):
>       x = "c"
>       mark = ["'", content, "'"]
>       t = ''.join(mark)
>    else:
>       x = "s"
>       t = param
>
>    coccinelle.call = "seq_put" + x
>    sys.stderr.write('call: ' + coccinelle.call + '\n')
>    coccinelle.text = cocci.make_expr(t)
> else:
>    cocci.include_match(False)
>    sys.stderr.write('include_match(False)\n')
>
>
> Unexpected test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch use_seq_putc_or_seq_puts-20230422-debug2.cocci seq_printf1.c
> …
> param:   "<>"
> include_match(False)
> param:   "]"
> include_match(False)
>
>
> Why do I observe an undesirable difference for the evaluation of regular expressions here?

I know almost nothing about either python or regular expressions.
Furthermore your semantic patch is very complicated and you have not
provided the .c file.  If you want a response, greatly simplify your
semantic patch to the minimum necessary to show the problem, and provide
the .c file, which should also be the minimum necessary to show the
problem.

julia
--8323329-1438587565-1682152414=:2766--
