Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676EEF506C7
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Xgs1oQwDe0RYA54P75xPZe54+t0Zdbx+bLOjD3Vo4z4=;
  b=octZxIJVIj8l6NALw7Gy/vxKcbB/M0O5MPNQlV+RdUEkt0xRPT5qHw7t
   priz7+o8PetwI7mjE111Sv3g9/MRNBYpEpmm0CE3wgBpBpThC/KIDs97t
   yiRCloyzEjNFn0hM3fPa1yNqwcXBFUnbJjbegDQ58zkLbdoFpH0rIVG/z
   Y=;
X-CSE-ConnectionGUID: w/3MDiQkRnanA0sGSxb6/w==
X-CSE-MsgGUID: +wNBphJJT5CW1SbO/bde2g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="267969441"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 13:58:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 97893820CA; Mon, 16 Mar 2026 13:58:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3C39C820BA
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 13:58:14 +0100 (CET)
X-CSE-ConnectionGUID: 6G5rCdbhRrS9+3s8TQOHgg==
X-CSE-MsgGUID: wWO/JLKyQhWfJcBjXxqxsw==
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="141440611"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:58:15 +0100
Date: Mon, 16 Mar 2026 13:58:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alice Lee <Alice.Lee@ist.ac.at>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <45e5450fb5734b8091dbcf586fc880f6@ist.ac.at>
Message-ID: <51a45bb9-a09e-2791-e2bb-1e73889649fe@inria.fr>
References: <e2cb31cc2b0947d29b50188dab2e1097@ist.ac.at>,<36eb7fe0-99b7-7191-134a-3adbe9d41d68@inria.fr> <45e5450fb5734b8091dbcf586fc880f6@ist.ac.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1629704575-1773665894=:3661"
Subject: Re: [cocci] Python script interacting with non-matching files?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3439
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/MgzmckwgWPJmscJcYstIXg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1629704575-1773665894=:3661
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 16 Mar 2026, Alice Lee wrote:

>
> Hi Julia, 
>
>
> Thanks for getting back to me!
>
>
>  1. Maybe it's easier to state my overall goal: I want to count the number of matches for some rule for each file in a directory. Currently I can get a python dictionary correctly counting the number of
>     matches in files in which there is at least one match. 
>     Your particular solution wouldn't work unless I know some value is in all files. Is the best solution just to get directory information in the initialization script to populate the dictionary instead of
>     trying to do this through Coccinelle?

I think there is a way to get the list of files that will be considered
based on analysis of your semantic patch.  But if you just want all files,
I think you should get that separately.

>  2. My ideal solution would make a dictionary of all matches in each file and report files that don't parse as having a count of -1. Files aren't partially failing to parse, at least according to the --debug
>     output, but say "bad" on every line. Still no way to access that in the python script?

No, there is no way to access anything about parsing in a python script.
Python is only triggered when you match something.

It seems odd that there would be bad on every line.  When your code ends a
function, does it put the final } somewhere other than the leftmost
column?  That is what Coccinelle uses to detect that it has reached the
next top level thing, to start parsing again.

julia

> Thanks,
> Alice
>
> _______________________________________________________________________________________________________________________________________________________________________________________________________________
> From: Julia Lawall <julia.lawall@inria.fr>
> Sent: Friday, March 13, 2026 3:15:29 PM
> To: Alice Lee
> Cc: cocci@inria.fr
> Subject: Re: [cocci] Python script interacting with non-matching files?  
> [EXTERNAL EMAIL - USE CAUTION when clicking links or attachments]
>
>
>
>
> On Thu, 12 Mar 2026, Alice Lee wrote:
>
> >
> > Hello,
> >
> > I am trying to use Coccinelle to search C code bases and I have a few
> > questions.
> >
> >  1. Can a python script within a Coccinelle file somehow access the names of
> >     files that are processed without matching the search? (Maybe there is
> >     some "match all" idiom that would let me get the name of every file and
> >     then move on to the relevant search?)
>
> I don't completely understand the question.  You can attach a position
> variable to some matched code and then print the file name associated with
> that code:
>
> @r@
> position p;
> @@
>
> foo@p();
>
> @script:python@
> p << r.p;
> @@
>
> print p[0].file  // put proper python code here
>
> >  2. Similarly, can a python script tell that parsing failed for a particular
> >     file?
>
> No, python doesn't have an access to the information about what could be
> parsed.  There is --verbose-parsing.  But parsing rarely fails for a whole
> file.  If it can't parse one thing, it will just move on to the next thing
> and try from there.
>
> julia
>
> > Thank you,
> > Alice Lee    
> >
> >
> >
>
>
--8323329-1629704575-1773665894=:3661--
