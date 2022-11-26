Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C45C43217
	for <cocci@archiver.kernel.org>; Sat, 26 Nov 2022 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G/nbCtLf1Nbm7qwpK8hRl4UzP3axzJju5Z2hCCzlLho=;
  b=dckDgSyYP7nkIFc1EPvd/4q6O4e5KxuDGZrm5lDlJNR94UkDSCaMVk57
   rM0SZm0AeLeX8Yn+opjZOuwWefK8lR+D4AntXceU6eSFAGvacy8LpoLS7
   1vUfR3trMkBRNSu7vQvyFSSiODVKVlzEm29cHgAUSqCmVBpaTK19TbpQY
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.96,196,1665439200"; 
   d="scan'208";a="80178534"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2022 12:58:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F658E028F; Sat, 26 Nov 2022 12:58:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 702B6E0010
	for <cocci@sympa.inria.fr>; Sat, 26 Nov 2022 12:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G/nbCtLf1Nbm7qwpK8hRl4UzP3axzJju5Z2hCCzlLho=;
  b=YvYf3yM74HZ6xR0iKtHjtTK1Mqe3oLidW0SvDqGvSZ4edjmnBqKjirQu
   AeiYPTenCRVniHHFN9dbiT2lTBVqkFwZJSrcnrMaj1DVEV8bTy80mzoxB
   E95I/+IGaDiDVBOHQOsIGdLOrT9ee04rah5XcjCkNgna7yE53WFmdLJmh
   E=;
X-IronPort-AV: E=Sophos;i="5.96,196,1665439200"; 
   d="scan'208";a="40865514"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 12:58:05 +0100
Date: Sat, 26 Nov 2022 12:58:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <433b8c36-21ac-2458-49bb-0bacea62b47b@web.de>
Message-ID: <alpine.DEB.2.22.394.2211261256520.15234@hadrien>
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de> <alpine.DEB.2.22.394.2211201641340.40755@hadrien> <79bb70c9-3257-504c-7d52-55ccaf51f640@web.de> <alpine.DEB.2.22.394.2211261130330.15234@hadrien> <433b8c36-21ac-2458-49bb-0bacea62b47b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-689033947-1669463885=:15234"
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 758
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/alpine.DEB.2.22.394.2211261256520.15234%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-689033947-1669463885=:15234
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 26 Nov 2022, Markus Elfring wrote:

> >> How are preprocessor directives (for example) integrated into the taxonomy of
> >> the Coccinelle software?
> > I have no real idea what the above question means.
>
>
> I hope that further development ideas will influence software evolution
> in desirable directions.
>
>
>
> >                                                     Things that Coccinelle
> > is able to parse are put into the AST.  Things that it is not able to
> > parse are attached as comments to neighboring tokens.  There is no general
> > anser for preprocessing directives.  Some are parsed and some are not.
>
> Would you become interested to export data from the mentioned “abstract syntax tree”
> and “control-flow graph” into any other standard file formats?

The control flow raph is already available in "dot" format, with the
option --control-flow-to-file

julia
--8323329-689033947-1669463885=:15234--
