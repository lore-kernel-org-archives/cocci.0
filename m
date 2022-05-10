Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83A9C433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=torp9GZNvErQ6dy9GlTSEqEjKd+q8PN+ID+MYiUH2fg=;
  b=VPS3XLZS3IHjsM7DYtE/MB6+kfOYZH5A1uX6ZxuzzUWPCAFC6KQabiw2
   P236CNw9bNVcU9mXtNqw/RQKr1JPmtD4PEZxLHo0LBEn0ECwDELsSt10w
   uySHiH4NDGJ7WvUxPbec1naJsZzJruCASDo94t/f+7wfkMhe68S7bp8L8
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,213,1647298800"; 
   d="scan'208";a="35502376"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 10:06:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9521FE0266; Tue, 10 May 2022 10:06:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD6E7E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 10:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=torp9GZNvErQ6dy9GlTSEqEjKd+q8PN+ID+MYiUH2fg=;
  b=R4uVKzxDHYJMO7m1+7WvMlLkLI1amJ+2SgY0l3pFB6EGBUaRqHXGYjp1
   HOc/VcEc0gAKsr/QUduetXxb6OGqfkIoO7YuVEmtY2fg+G1qE9aVaDlfi
   CCbh2kWj/Ee925SjRvYNExa/aXM4Fo9BnaThecGEX3UpUwfn8tQTHhDdH
   A=;
X-IronPort-AV: E=Sophos;i="5.91,213,1647298800"; 
   d="scan'208";a="35502368"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:06:34 +0200
Date: Tue, 10 May 2022 10:06:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2029740184-1652169993=:2667"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 372
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205100957160.2667%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2029740184-1652169993=:2667
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 10 May 2022, Alessandro Carminati wrote:

> Hello Markus,
>
>
> Il giorno lun 9 mag 2022 alle ore 21:23 Markus Elfring
> <Markus.Elfring@web.de> ha scritto:
>
>             The solution you sent indeed does what I expected.
>
>
> I doubt that it fits to your initial source code analysis desire.
>
> Are your expectations still evolving (also for your data processing
> needs)?
>
> Indeed Julia's proposed code does not solve all the situations I encounter
> now  in the kernel source analysis.
> It reports not only global variable names but also function names.
> It confuses sparse annotation and a few other macros with variable names.
> I also have trouble with "extern" declared variables that appear multiple
> times.
> Still, it is far better than I was up to, And it allows me to improve the
> solution by adding statements and rules to make it better suit my use case.
> Currently, I'm using this, but I still have duplicates due to "extern"
> declarations.
> ```
> @func@
> type T;
> identifier i;
> position p : script:python(i) { p[0].current_element == i};
> @@
>
> T i(...)@p;
>
>
> @r depends on !func@
> type T;
> identifier i;
> expression E;
> position p : script:python(i) { p[0].current_element == i};
> @@

Thanks for the feedback.  The strategy of !func is a good idea, but it is
not correct.  There is no particular relation between the func rule and
this one.  Thus as soon as a file contains code that matches the func
rule, the file will be ignored.

One solution would be to check that the position of i is not the same as
the position of a name matched by the func rule.  For that, you could move
the @p in the func rule from the ) to the function name, and then in this
rule put as the first metavariable line:

position q != func.p;

and then in the matches below put i@q@p (ensure that is at a position
that is both different than any func.p and that it satisfies the
current_element constraint).

But in this case, there is a solution that is even simpler:

(
T i(...);
|
T i@p;
|
T i@p=E;
)

Indeed, I think it should be sufficient to say:

(
T i(...);
|
T i@p=...;
)

You can run spatch --parse-cocci to see what happens with the rewriting
due to isomorphisms to see if the simpler rule is sufficient.

Or maybe you want:

(
T i(...);
|
extern T i;
|
T i@p=...;
)


>
> (
>  T i@p;
> |
>  T i@p=E;
> )
>
> @script:python@
> i << r.i;
> @@
> print (i)

Maybe you also want to inherit the position variable and print the file
and line number of the declaration?

julia

> ```
>
>
>
>             Would you mind add a short explanation of this
>             statement:
>             `position p : script:python(i) {
>             p[0].current_element == i};`
>             I probably have a simplified understanding of what a
>             position is.
>
> I imagine that known information sources can help further.
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a
> 6f4465c286a2792354/docs/manual/cocci_syntax.tex#L410
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e
> 537f97ab62a/docs/manual/cocci_syntax.tex#L410
>
> Thanks for this.  
>
>
>
>
>             Maybe it is worth digging deeper and having a more
>             concrete knowledge.
>
>
> Probably, yes.
>
>
>
>       Any read you want to suggest to me?
>
>
> Related links for example:
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a
> 6f4465c286a2792354/docs/Coccilib.3cocci#L5
> https://github.com/coccinelle/coccinelle/blob/57cbff0c5768e22bb2d8c20e8dae7
> 4294515c6b3/docs/Coccilib.3cocci#L5
>
>
>
> Regards,
> Markus
>
>
>
--8323329-2029740184-1652169993=:2667--
