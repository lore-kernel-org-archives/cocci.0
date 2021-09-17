Return-Path: <SRS0=f1Jb=OH=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF4C433F5
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 06:34:25 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584B46103B
	for <cocci@archiver.kernel.org>; Fri, 17 Sep 2021 06:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 584B46103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="528935562"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2021 08:34:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47050E001B; Fri, 17 Sep 2021 08:34:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 654DDE0019
	for <cocci@sympa.inria.fr>; Fri, 17 Sep 2021 08:34:17 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AybkbZq8IUO9nk5ckcmhuk+ACI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlD/Bw8vrEoB1173DJYUkqKQgdcLy7UpVoAkmsjaKdmLNhX4tKBTOW3V?=
 =?us-ascii?q?dAT7sSl7cKoQeAJ8SWzIc06U4HScZD4bbLYWSS4/yW3OGUeOxQo+Vu3MuT5ds3?=
 =?us-ascii?q?yR9WPGZXg6UJ1XYcNu7NencGPzWurqBJcqah2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393221541"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:34:17 +0200
Date: Fri, 17 Sep 2021 08:34:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
In-Reply-To: <202109161609.9AB60A934B@keescook>
Message-ID: <alpine.DEB.2.22.394.2109170825510.33288@hadrien>
References: <202109161609.9AB60A934B@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 8
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/alpine.DEB.2.22.394.2109170825510.33288%40hadrien>



On Thu, 16 Sep 2021, Kees Cook wrote:

> Hi,
>
> I'd like to match any compound type containing a compound type, i.e. these:
>
> struct foo {
> 	struct bar instance;
> };
>
> union bar {
> 	int c;
> 	struct baz d;
> };
>
> char buf[5][9];
>
> and the uuid_t type, where a zero initializer is used:
>
> struct foo instance = { 0 };
>
> Even in the simple case, I would expect this to be something like:
>
> @zero_initializer@
> ???? T;
> identifier I;
>
>  T I = {
> -	 0
>  };
>
> But I do not want to match scalars and single-dimensional scalar arrays
> like these:
>
> 	char name[8] = { 0 };
>
> so I can't just use "type T".
>
>
> I tried:
>
> @@
> type T =~ "^((struct|union) .*|uuid_t)$";
> identifier I;
> @@
>
>  T I = {
> - 0
>  };
>
> but this only matched uuid_t instances, which I don't understand.

@@
identifier i,x;
typedef uuid_t;
@@

(
struct i
|
union i
|
uuid_t
)
x = {
- 0
  };

> For a more exact match, this works for finding a struct within a struct:
>
> @found_compound@
> identifier COMPOUND, SUB, NAME;
> @@
>
>  struct COMPOUND {
>         ...
>         struct SUB NAME;
>         ...
>  };
>
> @zero_init depends on found_struct@
> identifier found_compound.COMPOUND;
> identifier I;
> @@
>
>  struct COMPOUND I = {
> - 0
>  };
>
>
> But this doesn't (fails to compile and I don't know why):
>
> @found_compound@
> identifier COMPOUND, SUB, NAME;
> @@
>
>  \(struct\|union\) COMPOUND {
>         ...
>         \(struct\|union\) SUB NAME;
>         ...
>  };
>
> @zero_init depends on found_struct@
> identifier found_compound.COMPOUND;
> identifier I;
> @@
>
>  \(struct\|union\) COMPOUND I = {
> - 0
>  };

Disjunctions are only allowed around complete C terms.  In struct x, the
type is struct x, not just struct.  So you need to duplicate COMPOUND in
each branch.

In the found_compound case it seems that one has to duplicate the entire
type declaration:

@found_compound@
identifier COMPOUND, SUB, NAME;
@@

(
  struct COMPOUND {
         ...
         \(struct SUB \|union SUB\) NAME;
         ...
  };
|
  union COMPOUND {
         ...
         \(struct SUB \|union SUB\) NAME;
         ...
  };
)

julia
