Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB88CD5BC8
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=By9KFooLmVAJImYLM50hoKeQWZgMNwpCYmnHXFiE/b8=;
  b=TzvYqkw7wUVAaDYGXxe1KiDlc2IBaXtxS2XDZyhpMwVi8+H4sIFC69y5
   t0wXtl80qi5ZZoIuWTINtVJ0lqudCgoeiZLyRGuNv4WX7mL3PsIJxqQDB
   gsEA36L2r13KJ1gxk6hsUwFgFY5LBiy4A6z2vc7FmBj3UF6m3sTTcc0xN
   w=;
X-CSE-ConnectionGUID: Crgvznt8SLiwfdMNpU3wOw==
X-CSE-MsgGUID: BMfmrmR7SV6ju6dABVHppw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208,217";a="278199197"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 11:07:19 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 53DE6862F5; Tue, 26 May 2026 11:07:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3025680E2A
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 11:06:57 +0200 (CEST)
X-CSE-ConnectionGUID: BRWBlNIiSS+hvEtBLBwOLw==
X-CSE-MsgGUID: EOYSDe+lQ4u/Bt+fN/BTmA==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208,217";a="278199066"
Received: from 88-183-23-223.subs.proxad.net (HELO [192.168.1.189]) ([88.183.23.223])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 11:06:57 +0200
Content-Type: multipart/alternative;
 boundary="------------zphLJuGcNcH0lxhbvIkMjNo2"
Message-ID: <53174e21-5014-40b5-a271-b2d43cb5bc50@irisa.fr>
Date: Tue, 26 May 2026 11:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
 <3d3ef8b5-cbb-8d68-e167-21bfab4fcc65@inria.fr>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <3d3ef8b5-cbb-8d68-e167-21bfab4fcc65@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Question regarding Coccinelle
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3522
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/Aa-thD0BvCIeLX39kBW8fg>

This is a multi-part message in MIME format.
--------------zphLJuGcNcH0lxhbvIkMjNo2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 11:00, Julia Lawall wrote:
> On Tue, 26 May 2026, Pierrick Philippe wrote:
>> I think I understand, also I do have a question regarding the `declaration` keyword of the grammar.
>> Is there any way to access inner information of the declaration? Such as the type or the presence of an initializer or not?
>> For example in a python or a ocaml script?
>
> Not sure what you mean.  There is a metavariable of type declaration taht
> will take the whole declaration at once.  If you also want the pieces you
> can write:
>
> (
> d
> &
> T x = ...; // matches the case with and without an initializer
> )

This is exactly what I meant, thank you.
Though it confuses me why the `...` operator works here but not in the
`memcmp` call statement.

Pierrick
--------------zphLJuGcNcH0lxhbvIkMjNo2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/26/26 11:00, Julia Lawall wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:3d3ef8b5-cbb-8d68-e167-21bfab4fcc65@inria.fr">
      <pre wrap="" class="moz-quote-pre">On Tue, 26 May 2026, Pierrick Philippe wrote:</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
I think I understand, also I do have a question regarding the `declaration` keyword of the grammar.
Is there any way to access inner information of the declaration? Such as the type or the presence of an initializer or not?
For example in a python or a ocaml script?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

Not sure what you mean.  There is a metavariable of type declaration taht
will take the whole declaration at once.  If you also want the pieces you
can write:

(
d
&amp;
T x = ...; // matches the case with and without an initializer
)</pre>
    </blockquote>
    <p>This is exactly what I meant, thank you.<br>
      Though it confuses me why the `...` operator works here but not in
      the `memcmp` call statement.</p>
    Pierrick
  </body>
</html>

--------------zphLJuGcNcH0lxhbvIkMjNo2--
