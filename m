Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A5C4828D
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=U2lkcyl7WTffXLL1m5E7q8UJOoWEv/qqd/5Dd2FmytQ=;
  b=FnG3rOe2bykHjFALNdxlsa9bCj5jbdEnnWLX7L+LwV05wHLoqKQfxxih
   VmWizN5BS+vmoNAMaYZLpWVK596q7N7QbkCgQ2GZW96C06ACj/DKxyCFS
   oz+CHbQZBxAWr0Yp8idAkGhIBC8vd5uPhyK+EYVWJGk3xx2h/l+ZDCuXp
   M=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150523412"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 12:31:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0E70E00B7; Tue,  6 Feb 2024 12:31:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 158E0E008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 12:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U2lkcyl7WTffXLL1m5E7q8UJOoWEv/qqd/5Dd2FmytQ=;
  b=saNQ6RJVDOo7zS8GiBKaQGF0t2/pMybi+psZJQz5FlRowtt7MOuC3uRN
   GUOMy1Q1b0EngvwhVRZby4nSyqrNqpAddQSqL12/etICWwwVD/ADXpi8e
   63tuTn/72UxyRNrdPB0PfaK2z9sUOp60F8dl+P3SZCvWv6nwn8o8rOpkH
   s=;
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="78866015"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 12:31:17 +0100
Date: Tue, 6 Feb 2024 12:31:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <20240205095637.54f3f450@kernel.org>
Message-ID: <366eb1b-c41b-89a8-5f9a-eaa280d562a@inria.fr>
References: <20240205095637.54f3f450@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --use-patch-diff broken?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1501
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/366eb1b-c41b-89a8-5f9a-eaa280d562a%40inria.fr>



On Mon, 5 Feb 2024, Jakub Kicinski wrote:

> Hi!
>
> I've been trying to run coccicheck with --use-patch-diff
> to try to limit the number of processed files. I _think_
> it worked when I set it up early last month but recently
> I went back to check and make coccicheck stops after
> the first spatch call, all it prints is "hd"

There was a problem in parsing the added line range, in the case where
there is just a single number (one line added).  The fix will be avaialble
shortly.

Thanks for the report.

julia

>
> https://netdev-3.bots.linux.dev/cocci/results/452585/new
>
> spatch seems to work fine when run without --use-patch-diff
> cocci version is the latest from git as of $now
>
> FWIW the git hashes are from this tree:
> https://github.com/linux-netdev/testing.git
> (probably best to clone that thing with --depth $number)
>
>
> Example:
>
> /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/err_cast.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 48 --chunksize 1 --use-patch-diff b9f2444cd114a7f9c44950dc850aa1753b3edd94..be5bf59888403413619dd74e0d5f5386ffafbc90
> grep: warning: + at start of expression
> grep: warning: + at start of expression
> grep: warning: + at start of expression
> hd
>
