Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A9D65552
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SkwgsTMlHABNHyjlyao4/bUC3uiQaD4u89W+hQq0I+Q=;
  b=UXZyg9zbIifT7YxN6YMIskoYN1cd5+O1sleqr9ctShtEEUxjl5CHM8V1
   ifhSTtM2Dn0WViufzXoMbx+LEZ4whWdsxaVYdZLTwkqAxZpYiBZ2jBOvg
   QWQlSpA0LCkh+iJe1Sijv5zEaW3Tn2mafxU2E/56EDRozXuMKAzCekZpy
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195952138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 21:15:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2948E013D; Tue, 26 Nov 2024 21:15:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E6CFEE00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 21:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SkwgsTMlHABNHyjlyao4/bUC3uiQaD4u89W+hQq0I+Q=;
  b=ARnljGCbVS6ZwF4MoPqvWOW+vM+ZokqAxy+L6gcdjSof0w5eX41Lc9IT
   8WCE2sCG4QT8HHUWwijxXEZT++4Ep7acHVhE0IitHh0ReDM0o7s//Pz0n
   PNHAMVcDjErYIgd/UwcO6uLaeSNMlJ9FPRP5cyzGX4LrqfIswT3h13+v9
   A=;
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="102707353"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 21:15:27 +0100
Date: Tue, 26 Nov 2024 15:15:24 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Zack Rusin <zack.rusin@broadcom.com>
cc: cocci@inria.fr
In-Reply-To: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
Message-ID: <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replacing type names
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2134
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/6b81d431-36e9-7a7a-687b-2d7fc7aa6c31%40inria.fr>



On Tue, 26 Nov 2024, Zack Rusin wrote:

> Hi,
>
> I'm trying to write a  script to snake case all type/function names
> but I'm having a hard time matching some types. I think I'm missing
> something silly.
>
> My input script is:
> https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b
> which when applied
> spatch --sp-file sample.cocci sample_case.c
> on the following sample_case.c file:
> https://gist.github.com/zackr/97cb903c6e0306b25dcb8fa9f696077c
>
> ends up doing a little silly things like:
> -typedef struct SomeDevice {
> -    uint32_t sampleVariableUnsigned;
> -    int32_t sampleVariableSigned;
> -    float floatVariable1;
> -} SomeDevice;
> +typedef struct some_device {
> +    uint32_t sample_variable_unsigned;
> +    int32_t sample_variable_signed;
> +    float float_variable1;
> +}struct some_device {
> +    uint32_t sample_variable_unsigned;
> +    int32_t sample_variable_signed;
> +    float float_variable1;
> +}struct some_device {
> +    uint32_t sample_variable_unsigned;
> +    int32_t sample_variable_signed;
> +    float float_variable1;
> +}SomeDevice;
>
> I'm guessing t@p somehow matches three times on the typedef structs...

This is clearly not what we want.  Thanks for the report.

>
> Does anyone have any tips on how to match both types in definitions, i.e.:
> struct Type {...}
> and
> typedef struct Type {...}
> declarations i.e. Type var; and parameters/function return i.e. Type
> func(Type var);


I think you would want to take care of the typedefs first?  Then you can
make a rule that does the other structs.

>
> Plus is there any way to transform arbitrary function names? I'd like
> to endup with:
> https://gist.github.com/zackr/c37683157f10b2728dfd3576c88e64f7
> in a generic way that basically can transform any arbitrary type,
> function and identifier name.

idexpression x;

is an identifier that is also an expression.  This will cover function
names and variable references, but not variable declarations.

identifier x;

Will cover the variable in declarations, but it will also include
structure field names.  I don't know what you want to do with them.

If you don't want to do structure field names, you can do something like:

@bad@
expression e;
identifier i;
position p;
@@

e.i@p

@needed@
identifier i;
position p != bad.p;
@@

i@p

@script:python s@
i << needed.i;
generated;
@@

coccinelle.generated = // python code to transform i

@@
position needed.p;
i << needed.i;
generated << s.generated;
@@

- i@p
+ generated

In the needed rule, you can also write

identifier i : script:python() { ... };

... would be a call to a function that checks if i is the kind of
identifier that you would like to transform.

julia

