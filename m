Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC47CD5BD1
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZukNuk7O01zMDed30bIsx2VdX/BNGzeDfP+CfgTcH3U=;
  b=hy1c7zDa6+E2Fxw2fchrgE9JVAHikMQDWV0hwUhhQjbwAf4tXYoLgLc8
   WBdDJMcJH2vrB0aNS5TImJuNzoMxQOyHa1gb2v6AH5jHN+e3grzS72xCl
   OqQuEuq0ndbOd+XgnY8eg6AvUWjQVhE4Ssl1eDgr8sC696MCznQiJybmC
   o=;
X-CSE-ConnectionGUID: i1kMOQ7xRzCpexKbm4BVZg==
X-CSE-MsgGUID: IuYeQdxnR4mg8JXtE1Maww==
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
   d="scan'208";a="278196457"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 11:00:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 67E67862ED; Tue, 26 May 2026 11:00:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A81C7862F3
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 11:00:43 +0200 (CEST)
X-CSE-ConnectionGUID: NfJZKlvFSUCcAogWARI8GQ==
X-CSE-MsgGUID: +JJNAZBGRgiAqKWwglTT7w==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278196351"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 11:00:37 +0200
Date: Tue, 26 May 2026 11:00:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
cc: cocci@inria.fr
In-Reply-To: <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
Message-ID: <3d3ef8b5-cbb-8d68-e167-21bfab4fcc65@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr> <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1020456041-1779786037=:3629"
Subject: Re: [cocci] Question regarding Coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3521
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/0cFlSzgRVIFmktBFina5sQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1020456041-1779786037=:3629
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 26 May 2026, Pierrick Philippe wrote:

>
> Hi Julia,
>
> First of all thanks for your answer.
>
> On 5/26/26 10:23, Julia Lawall wrote:
>
> On Fri, 22 May 2026, Pierrick Philippe wrote:
>
> Hi everyone,
>
> I am currently trying to assess if Coccinelle could be used to match my
> use case.
> What I am trying to do is to modify the declaration of a specific
> variable by adding an attribute to it, if and only if it is passed to a
> specific function (memcmp in this case).
> i am using Coccinelle version 1.3.0 (through nix-shell:
> https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle
> <https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle> ).
>
> My input test program is the following:
>
> ```c
> #include <string.h>
> int main(void) {
>     int a = 42; // This is the variable of interest
>     int b = 43;
>     int z = memcmp(&a, &b, sizeof(int));
>     return z;
> }
> ```
>
> Which should be modify to:
>
> ```c
> #include <string.h>
> int main(void) {
>     int __attribute__((myattr)) a = 42; // This is the variable of interest
>     int b = 43;
>     int z = memcmp(&a, &b, sizeof(int));
>     return z;
> }
> ```
>
> In order to do this, I played around with Coccinelle, but I keep having
> weird behavior from spatch (at least from where I stand).
> Here are two attempt to cocci rules:
>
> ```cocci
> @first@
> type T;
> T VAR;
> expression E;
> @@
> -VAR = E;
> +__attribute__((myattr)) VAR = E; // Parse error here
> ...
> memcmp(&VAR, ...);
> ```
>
> But for some reason, I got the following parsing error for the first
> attempt and I couldn't wrap my head around it:
>
> ```
> plus: parse error: 
>   File "test.cocci", line 7, column 25, charpos = 76
>   around = 'VAR',
>   whole content = +__attribute__((myattr)) VAR = E;
> ```
>
> Attributes are only allowed in variable declarations, which declare
> identifiers, not arbitrary expressions.
>
> In int x = 3;
>
> x somehow doesn't yet have type int.  It's just a name.
>
> Also, Coccinelle requires you specify a complete term, not just the
> subpart of the term that is convenient for you.
>
> I think I understand, also I do have a question regarding the `declaration` keyword of the grammar.
> Is there any way to access inner information of the declaration? Such as the type or the presence of an initializer or not?
> For example in a python or a ocaml script?


Not sure what you mean.  There is a metavariable of type declaration taht
will take the whole declaration at once.  If you also want the pieces you
can write:

(
d
&
T x = ...; // matches the case with and without an initializer
)

>
> My second attempt is successfully parsed, but leave the input program
> untouched:
>
> ```cocci
> @second@
> type T;
> identifier VAR;
> expression E;
> @@
> -T VAR = E;
> +T __attribute__((myattr)) VAR = E;
> ...
> memcmp(&VAR, ...);
>
> This again fails because you have only specified part of the memcmp
> statement.  If you want to put a complete statement, you have to put the
> whole thing.  I think you can also just put a memcmp call, without the
> semicolon.
>
> It worked with the whole `memcmp` call statement indeed, I probably misunderstood the `...` operator then.

... on the line before memcmp only jumps over statements in the control
flow graph, not arbitrary tokens at the beginning of a statement.

julia

> Pierrick
>
> julia
>
> ```
>
> This is probably an easy use case, but I am completely new to Coccinelle
> and I honestly can't understand what is going wrong here.
> To be honest, I also do not understand the difference between the two
> rules, and why one is successfully parsed and not the other one.
> Although this is probably due to a lack of experience with Coccinelle
> and of its internals.
>
> Cheers,
>
> Pierrick
>
> >
>
>
>
--8323329-1020456041-1779786037=:3629--
