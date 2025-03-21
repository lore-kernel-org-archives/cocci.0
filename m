Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A78C36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hd3kOGlfqW2uj30YEO+UhCkfG7XCsHdiHz7K4jhTp2k=;
  b=eVplU/MNxgi4XLYLA2j65W9D58OjV5ilhJjm/bHFBQ23qIaFAynRzzny
   wy87mu1SacgDP48/8XkJR2PAD/V1iRYKn2/aKHHLvgAHGLIqWVGxffmJb
   5XG1wzh5wvvNdQkY11sp7BADkWsGo9YMiZquKqhcVi6S6DQeakYTLpKQq
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214127173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 13:54:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1675E0264; Fri, 21 Mar 2025 13:54:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A347E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 13:54:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hd3kOGlfqW2uj30YEO+UhCkfG7XCsHdiHz7K4jhTp2k=;
  b=t/kvXp4DDOl9wnoxheDlz9mn/9DwnuKw9qjUBtIDG5B01Alv/1AD2xFX
   E67bZcTnJCWLwLDxAYZLXWPcrTVMj+QKxADa6nB47TZZ/Sx/GIWEd4P6z
   FdjFj2iQIdSAkF8qB6HFr2P+v/n1oGocFkc1sXDPR3Civj9/LW0DTOcce
   A=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112253937"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:54:52 +0100
Date: Fri, 21 Mar 2025 13:54:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?H=E5kon_L=F8vdal?= <hlovdal@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
Message-ID: <a999c5c-5229-7e24-e36e-181c31d1ebd0@inria.fr>
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr> <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-93147694-1742561691=:3459"
Subject: Re: [cocci] scoped_guard
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2665
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/a999c5c-5229-7e24-e36e-181c31d1ebd0%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-93147694-1742561691=:3459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 21 Mar 2025, Håkon Løvdal wrote:

> On Fri, 21 Mar 2025 at 12:50, Julia Lawall <julia.lawall@inria.fr> wrote:
>       Coccinelle offers the "metavariable" type iterator for the names of things
>       that work like for or while.  That is, they represent the header of a
>       block and they cause a loop.
>
>       Now the Linux kernel has scoped_guard that represents the header of a
>       block, but isn't a loop.  So the name iterator is not suitable.  One
>       option would be to just make special cases for scoped_guard and
>       scoped_guard_cond, but other similar cases could come up over time.
>
>       Any suggestions about a possible metavariable kind for these names?  Maybe
>       just header and header name?
>
>
> My first encounter with scoped_guard is looking it up just now, however
> since the core functionality of the macros is to start a (guarded) block
> I think "block" should be part of the name as the most essential property.
>
> The Linux and resource specific properties are not essential, this could
> also be used for a general hypotetical `mydebug` macro like the following:
>
>     FILE *file = fopen(filename, "r");
>     if (file == NULL) {
>         ...
>     }
>
>     fseek(file, 0, SEEK_END);
>     long fileSize = ftell(file);
>     fseek(file, 0, SEEK_SET);
>
>     mydebug(dbg_ctx) {
>         printf("%s is %l bytes\n", filename, fileSize);
>     }
>
>     char *content = (char *)malloc(fileSize + 1);
>     if (content == NULL) {
>         ...
>     }
>
>     size_t bytesRead = fread(content, 1, fileSize, file);
>     ...
>
> So brainstorming a few name suggestions:
>
> block_header
> block_start
> block_begin
> block_prefix
> block_setup
> block_factory
> block_creator
> block_constructor
>
> Scope *could* perhaps be used instead of block, however scope does
> not work without being associated with a resource, so I think it is a
> poor fit.
>
> The concept seems similar to the `using` statement in C#,
> https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/using.

Thanks for the feedback.  How about just block for the generic case and
block name for introducing a specific name?

Might a user start to expect

for_each_child_of_node(...) {
  ...
}

to be matched by block name for_each_child_of_node;?

julia
--8323329-93147694-1742561691=:3459--
