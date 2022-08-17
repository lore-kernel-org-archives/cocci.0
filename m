Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE1DC25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fIbC/xUJEYSJmJ6NQOC/5d7e1UYuIWBR6blYlNspZhU=;
  b=Ghg7lDNi2OZ5jnRgfDOjO+h7Ked/SVXqRJ1OrfOYNj4PVVlLTcVBSr3Z
   zxGtzjnvy92guIxN4iAxBYS1sbSrwHUk+fj9qN/GTlUwPUXdo5S75gt+y
   /3nXkWG95r6JEUtTUz+WqM9O0ozaY/9oHNkoxFU8+uV6V5hoDQxSFSA0g
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49031701"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 16:37:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44679E0AC3; Wed, 17 Aug 2022 16:37:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D2C2E0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 16:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fIbC/xUJEYSJmJ6NQOC/5d7e1UYuIWBR6blYlNspZhU=;
  b=m1YGyU/4JcNYMa9MvTEs00dWGsj2tCasM8tIHr8xWJHDH+6y7dFVABGI
   EaOXDJ1HXHjjEL0XveoXACHNwVd9B0zoeXTjx4Q/pLTgV65F+wZIwLWkF
   xyC2hw7nh4R965TWVEJ8FTmOc/K0xQvFfNIre8GbKHnY3Klkk7/FDR3Bk
   4=;
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="21434292"
Received: from unknown (HELO hadrien) ([95.166.247.26])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:37:00 +0200
Date: Wed, 17 Aug 2022 16:36:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakob Koschel <jkl820.git@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com> <alpine.DEB.2.22.394.2208162306410.2625@hadrien> <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 512
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208171631050.2482%40hadrien>



On Wed, 17 Aug 2022, Jakob Koschel wrote:

>
>
> > On 16. Aug 2022, at 23:07, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> >>>> Based on that I was wondering if there is a way to say: match if the expression is
> >>>> within an expression list. So if I for instance have something like this:
> >>>>
> >>>> @main@
> >>>> type T;
> >>>> parameter list P;
> >>>> expression list E;
> >>>> expression E1;
> >>>> identifier func, func_call;
> >>>> @@
> >>>>
> >>>> T func(P@E) {
> >>>>   ...
> >>>>   func_call(E1 in E)
> >>>>   ...
> >>>> }
> >>>>
> >>>> (above is not valid syntax of course)
> >>>>
> >>>> Ideally I would like to make and get the parameters of 'func' that are used in any position
> >>>> as arguments in 'func_call' if that makes sense?
> >>
> >> Do you have any idea regarding the expression lists?
> >>
> >> looking at the following code snippet:
> >>
> >> test.c:
> >>
> >>   int func1(int argc, char *argv) {
> >>      func2(argc, argv);
> >>
> >>      func3(argc, argv);
> >>
> >>      func3(argv);
> >>   }
> >>
> >> what works is (only matches the first func3 call):
> >>
> >>   @main4@
> >>   expression list Es;
> >>   @@
> >>
> >>   func2(Es)
> >>
> >>   @main5@
> >>   expression list main4.Es;
> >>   identifier func;
> >>   @@
> >>
> >>     func(Es);
> >>   + // add comment
> >>
> >>
> >> what doesn't work (matching on the expression list from the parameter list):
> >>
> >>   @main4@
> >>   expression list Es;
> >>   @@
> >>
> >>   int func1(Ps@Es) {
> >>   ...
> >>   }
> >>
> >>   @main5@
> >>   expression list main4.Es;
> >
> > Could you try
> >
> > expression list main4.Ps;
> >
> > It may transform the parameters into a list of expressions.
>
> I just tried:
>
> @main4@
> parameter list Ps;
> @@
>
> int func1(Ps) {
> ...
> }
>
> @main5@
> expression list main4.Ps;
> identifier func;
> @@
>
>   func(Es);
> + // add comment
>
> but that throws:
>
> meta: semantic error: incompatible inheritance declaration Ps
>   File "test.cocci", line 45, column 24, charpos = 539
>   around = ';',
>   whole content = expression list main4.Ps;

OK, there is a specific context in which this works, but it is only for
generating semantic patch rules.

You can do something like

@r@
parameter list [n] ps;
type t;
identifier i,f;
@@

f(ps,t i, ...) { ... }

@@
expression list[r.n] es;
identifier r.i, r.f;
expression e;
@@

(
f(es,i,...)
|
f(es,
- e
+ 0
  ,...)
)

I'm not sure if that is exactly what you want to do, but perhaps it will
give some ideas.

julia

>
> >
> > julia
> >
> >>   identifier func;
> >>   @@
> >>
> >>     func(Es);
> >>   + // add comment
> >>
> >>
> >> Ideally I would like to 'find' all parameters used in a function call,
> >> I also tried this:
> >>
> >>   @main4@
> >>   parameter P;
> >>   expression E;
> >>   @@
> >>
> >>   int func1(..., P@E, ...) {
> >>   ...
> >>   }
> >>
> >>   @main5@
> >>   expression main4.E;
> >>   identifier func;
> >>   @@
> >>
> >>     func(..., E, ...);
> >>   + // add comment
> >>
> >>
> >> But it throws: 'rule starting on line 41 contains unattached metavariables: main4.E'.
> >>
> >> Any idea, why e.g. the second one doesn't work? If I print it with python the expression list
> >> looks the same as for the first one.
> >> Also in the end this boils down to: is it possible to match to any of the expression list elements?
> >>
> >> Thanks,
> >> Jakob
> >>
> >>>>
> >>>>
> >>>> Any help is very much appreciated!
> >>>>
> >>>> Thanks,
> >>>> Jakob
>
>
