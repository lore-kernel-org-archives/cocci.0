Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AEFC02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=3NY4Yw7jGxZQed5RDnf4ib6Ngs/vabCxuKI742CEXEU=;
  b=Ox1dIbBma81SKOtfa8Sl4j152ndMuooCpTQdGVjvfRMxppetFJE7ymyb
   gh7KSRDuHEfjU5RXUl+R3O0CTtMeIIzXnF8in+8bDu6HZ3jqVAgYQ389e
   Qohp4c2BE7kUgcDpwxOqmwpZRZAC2VxiiU2tsDawR8IMLbeHN3/gDskbI
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
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207463271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:16:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5310BE0261; Mon, 10 Feb 2025 12:16:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63BB0E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 12:16:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3NY4Yw7jGxZQed5RDnf4ib6Ngs/vabCxuKI742CEXEU=;
  b=JfE0a0zdTTOEAibcD7rZ5H/tIlMKmJDdoWsjhe89PJ4xZV+SZwZMZp/o
   n6l7xU6uIcoOjkBm/m/m1fPGx1EdfpcE6Qqu3S2eTM8Wr1uNzIdqEb+vN
   KguzkI2Lmfs5iKJBuOiOX6qOGzYqzPI1D0V4zY+yIbEZp6LIv/RsyW+6z
   s=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="108659253"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 12:16:18 +0100
Date: Mon, 10 Feb 2025 12:16:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr>
Message-ID: <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-385556135-1739185848=:64981"
Content-ID: <9b56bac4-98f0-66c-d9fc-4df11530235c@lip6.fr>
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2388
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/74e89641-1819-e332-47c1-f1ba5fbc47%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-385556135-1739185848=:64981
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f2337797-2e84-de62-fe7a-a15ea470f9@lip6.fr>



On Mon, 10 Feb 2025, Fonyuy-Asheri Caleb wrote:

> Hello,
>
> I am new to coccinelle and am interested in creating a patch which can define functions based on the function pointers 
> available in a struct declaration. Since the names of the pointers don't exactly match the 
> function definitions I want, I used a python script to modify the names. Below is my script: 
>
> @m_rule@
> field list f_list;
> identifier I;
> @@
> struct I {
>     f_list
> };

I'm not 100% sure if this work, but it could be nicer to match the
declaration of a function pointer, ie

struct I {
  ...
  T (*I1)(...);
  ...
}

Also, it is better to omit the ; at the end, because a structure type
could be declared in a variable declaration, where there is no ;
immediately after it.

>
> @script:python p_rule@
> nf << m_rule.f_list;
> n_list;
> @@
> new_nf = []
> for f in nf:
>     parts = f.split("(")
>     r_type = parts[0]
>     if '*' in r_type:
>         r_type=r_type.strip()
>     else:
>         r_type = r_type.lstrip()
>     f_name = parts[1].split(")")[0].replace("*", "").strip()
>     params = parts[2].split(")")[0]
>     new_nf.append(r_type + "pv_" + f_name + "(" + params + ")")
>     new_nf.append(r_type + "hvm_" + f_name + "(" + params + ")")
>
>
> Please how can I write a new rule that defines several lines of function definitions from 
> the p_rule new_nf list available in my python structure? 
>
> I tried adding the list in a plus(+) entry but that does not work. 

I'm not really sure what you are trying to do here.  Maybe if you could
give an example of source code an the results you want to achieve that
would be more understandable.

An alternative is not to bother with the type declarations, but instead to
see how some fields are used.  A function pointer field is a field that
has a function name stored in it.  So you could do:

@fname@
identifier fn;
@@

fn(...) { ... }

@@
type T;
T x;
identifier id;
identifier fname.fn;
@@

x.id = fn

This might be less complete than what you propose.

julia

>
>
> Thank you in advance for your help. 
>
> Caleb
>
>
--8323329-385556135-1739185848=:64981--
