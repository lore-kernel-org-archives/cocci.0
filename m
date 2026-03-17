Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB33FD8740
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sl9qmbCnO/ZcAv5kKWeyZRMDIJux9z+uxxk79dpGugo=;
  b=BietO2f06DSE7/ZfDaLkn7uB2spAb70VYoo7ZpfBh+6qF31bJjLtX6aK
   lXvuCBk4mEyW2HzRSvDyNGmRk3mV3vOBAHRP2rcx1ap9f7vNNKCDAMbnQ
   FoE5GUHMEOBSj46uZLpGPV7kY3F/wRe4MA9bYNXznfEcxiclBr7z6TpV/
   I=;
X-CSE-ConnectionGUID: tvDMEkOnTHiu4yCZK7Vr7Q==
X-CSE-MsgGUID: 2xEcrfmhTHOeGtAFM8oa5w==
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
   d="scan'208";a="268151647"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 12:31:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0DD2F82390; Tue, 17 Mar 2026 12:31:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1B9388204A
	for <cocci@sympa.inria.fr>; Tue, 17 Mar 2026 12:31:49 +0100 (CET)
X-CSE-ConnectionGUID: wd4MpcyCR7e+LbP9EhkHvQ==
X-CSE-MsgGUID: FBcPGtknTUOBenJSVpecfA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="268151621"
Received: from unknown (HELO hadrien) ([78.104.51.45])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 12:31:48 +0100
Date: Tue, 17 Mar 2026 12:31:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alice Lee <Alice.Lee@ist.ac.at>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <79a19f5adf154119b6c4d0dc7187e383@ist.ac.at>
Message-ID: <3ff162c4-9337-74f-c4bf-2510c9f0d53@inria.fr>
References: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>,<5cd9a9c8-9f99-417f-dcfe-5c1b136ec5bf@inria.fr> <79a19f5adf154119b6c4d0dc7187e383@ist.ac.at>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1400222850-1773747109=:3432"
Subject: Re: [cocci] Can Coccinelle parse files where macros are used as
 binary operations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3445
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/zIoLlLfP9OU8J27HzXS-xw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1400222850-1773747109=:3432
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 16 Mar 2026, Alice Lee wrote:

>
> Hi Julia, 
>
>
> Is there an alternative to --defined that allows me to actually define a macro as in the "#define LS <<" example? If I modify the code to use a simpler switch than the equality check from the original as
> follows: 
>
>
> #ifdef SYMB
> #define LS >>
> #define RS <<
> #else
> #define LS <<
> #define RS >>
> #endif
>
> I still get a parse error when I run "spatch --cocci-file rule_test.cocci --defined SYMB musl-1.2.5/src/string/memcpy.c --debug"'; is this actually best done by a preprocessor and out of scope for
> Coccinelle?

Coccinelle seeing the macro definition doesn't force it to use the macro
definition.  Try putting the #defines you want in a file and then putting
--macro-file-builtins file.

Alternatively, are these definition actually in the file where you expect
the expansion to happen?  Normally, if there is a parse error, which a use
of eg LS should trigger, it will start trying to expand macros.  But I
wonder if it only tries for the ones that look like functions?  If these
definitions are in a header file, you may want an argument like
--all-includes or --recursive-includes.  Or you can put --include file.h
on the command line explicitly.  Or if you don't want to type it all the
time, you can put at the beginning of your .cocci file:

#spatch --include file.h

Or any other command line arguments you want.

julia


>
> Thanks,
> Alice
>
> _______________________________________________________________________________________________________________________________________________________________________________________________________________
> From: Julia Lawall <julia.lawall@inria.fr>
> Sent: Friday, March 13, 2026 3:12:34 PM
> To: Alice Lee
> Cc: cocci@inria.fr
> Subject: Re: [cocci] Can Coccinelle parse files where macros are used as binary operations?  
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
> > I am trying to use Coccinelle to search C codebases (I split up my questions
> > to make the threads more clear) and I am struggling to understand the scope
> > of the --macro-file argument.
> >
> > Can macros used with #if in the source code be defined in a file passed with
> > --macro-file, and then the right sections of source code are ignored? I was
> > unable to get a small example to work, so I assume that I can define the
> > macro but then there is no preprocessing to drop code. If I'm not
> > overlooking something, how would you recommend I parse a file
> > including these lines and then uses LS/RS as binary operators: 
> > #if __BYTE_ORDER == __LITTLE_ENDIAN
> > #define LS >>
> > #define RS <<
> > #else
> > #define LS <<
> > #define RS >>
> > #endif
> >
> > I'm especially confused by this example because Coccinelle also cannot parse
> > a version in which I remove the code above and put one of the pairs of
> > defines in the macro definition file.
>
> I think you want the following command line options:
>
>   --defined                     <symbol> treat cpp symbol as defined in #ifdef
>   --undefined                   <symbol> treat cpp symbol as undefined in #ifdef
>
> --macro-file is for providing dummy definitions for macros used in the
> code that you are trying to parse.
>
> julia
>
> >
> > Thank you,
> > Alice Lee
> >
> >
>
>
--8323329-1400222850-1773747109=:3432--
