Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3DFC433F5
	for <cocci@archiver.kernel.org>; Fri, 11 Mar 2022 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v32DEkk1jj8ljo8GTCh2PAFBTTCqJDB4kg2H7J4s2PI=;
  b=WfZ8uDfb+Mq7Vqo7mCYZ/X30QxAQkWoXb6vdngMaFAaEqwNDiROXK++R
   hBrfiIGaCCgnzUMLoe2akYrYQXomcUxmQoaqEInWkYrbM24RYON75OjGR
   TZ7+b5jOgliWkveX9m8fruJMPTjgyKl3HYIts5SrzBg+UoyzlscqEk+lu
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@univ-grenoble-alpes.fr
X-IronPort-AV: E=Sophos;i="5.90,173,1643670000"; 
   d="scan'208";a="25639495"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2022 12:12:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 237A4E02A3; Fri, 11 Mar 2022 12:12:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01B01E0045
	for <cocci@sympa.inria.fr>; Fri, 11 Mar 2022 12:12:49 +0100 (CET)
IronPort-SDR: va+6ZBGZaPq36cxWh5w87m7iMgKr7fddQseN0ePw8T8kRRMvJF0g7GVBi9KTpQBUC7qL1BOBrI
 BHCtcfekN3wABSrHWcOHqewl6IgJuDQ+XQDRgA7FqgC8/jkfORU1aWKzDPBZg2GLGF9NBKCh1M
 Nco3oXUu9dRfXoHIsXCf9wiwAJnt0EkTqPsNqzZmSJIrf5/xTHYxzYosbX8pBwePZK889f0YIx
 /15GLbtdgWujiIz5HmHTQNsT8Sn2Bm6Ji9hPSxqSn/XUTG0Vhy02yK8AKvKnC09n2zq1BFIIWb
 rPwJcPTCu6j0+XYQJjQerl1/
X-IronPort-AV: E=Sophos;i="5.90,173,1643670000"; 
   d="scan'208";a="8277114"
X-MGA-submission: =?us-ascii?q?MDHKmRwJQiLGr9KWEtRdLAbzpmqQJWTdTjtPWo?=
 =?us-ascii?q?Baw8shHjnwQKo7fbR7+PtnQm5ybi8KPTCjnYFUvDfau4/EZLNx0IO8Ol?=
 =?us-ascii?q?9hMEQlBQ04rK0mAL+cv3lMNM8oJKl0A+cYhrQbBcx3DOeqsnT+vpF4/3?=
 =?us-ascii?q?nwPJqLbf2razvFnfQXsRIxaw=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:12:49 +0100
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2A7A740212;
	Fri, 11 Mar 2022 12:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1646997169;
	bh=FiaWccYyXPUvrrzNGLPys882cGnW1W83QvVHcFkDgSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPJ8r2DGTfRTUcq5BDUKNwIupuQIRQ/2GEELK0T987KRv6WoyTItrIOB59f3VLNRU
	 P7YqO8ahXn6b8VVodOfXdwxGC2oTDjzAuHhfeUS01D8drTQEUbnKnpOQ9KQ8hzd5FD
	 16n5AqxUfP+yI5saOQi0BojnkeGaeIdSCM8w6pm4vb2uJk+78uz4HU6i/MlxtOlpvP
	 IdUB1Qmf6P+vFXw2l39xXRfWHaVtlFRQbk2W6A8mhZI2lOA0Hd1Qigay4kZ0ncKLmr
	 0NjN/u/ZHd9SNfTq10cVQMTvh/GboL8OgcUSaZ/Wpwjm5My7Fhog4yZsJtOdIz/jS1
	 FKI6pBamWGVMg==
Received: from mailhost.u-ga.fr (mailhost1.u-ga.fr [152.77.1.10])
	by mailhub.u-ga.fr (Postfix) with ESMTP id 288F710005A;
	Fri, 11 Mar 2022 12:12:49 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
	by mailhost.u-ga.fr (Postfix) with ESMTP id 21E4660067;
	Fri, 11 Mar 2022 12:12:49 +0100 (CET)
Received: from [129.88.52.245] (erods-pc-palix.imag.fr [129.88.52.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 104A414005C;
	Fri, 11 Mar 2022 12:12:48 +0100 (CET)
Message-ID: <af50234b-f84c-72ed-df93-acc7bc41bb82@univ-grenoble-alpes.fr>
Date: Fri, 11 Mar 2022 12:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: fr
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
 <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
 <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
 <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
 <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20>
 <e683d80-5764-7550-d729-273e61b607c@ewheeler.net>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <e683d80-5764-7550-d729-273e61b607c@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (42)
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 152.77.18.2
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 204
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/af50234b-f84c-72ed-df93-acc7bc41bb82%40univ-grenoble-alpes.fr>

Hi,

If there is not too much extensions, maybe you can enumerate them in the 
SmPL, or generate a SmPL script per-extension after a collecting phase.


The Regexp are the ones from the Ocaml Str module, or PCRE according to 
the configuration.
https://github.com/coccinelle/coccinelle/blob/master/globals/regexp_pcre.ml

So, the group definition are legal for the matching, but maybe depends 
of the underlying Regexp used.

Moreover, but because we have Python and OCaml escapes with more power 
to generate thing, using group seems hard to use from a SmPL syntax 
perspective.

I like the C@1 notation to get the group, but how would you say
to concatenate it with a prefix/suffix either static or variable (from 
another metavariable) ?

As your example suggests, maybe keeping only the first group if any is 
defined in the + part would be great, and all the bind string otherwise.

I retrieve the matching phase here
https://github.com/coccinelle/coccinelle/blob/master/engine/cocci_vs_c.ml

Julia, where can I find the + part that where the bind string
is used ? Can we still have the Regexp at that point ?


On 10/03/2022 23:03, Eric Wheeler wrote:
> On Thu, 10 Mar 2022, Markus Elfring wrote:
>>> Anyway, my needs for this are already met with a combination of SmPL
>>> cleverness and a bit of manual intervention,
>>
>> Would you like to share a bit more information about a (temporary) solution
>> which you find good enough at the moment?
> 
> This was the resulting diff from git after doing the complete refactor to
> remove "untitled" from default filenames:
> 
> 	@@ -991,6 +1019,7 @@ on_freqplots_save_as_activate(
> 	     GtkMenuItem     *menuitem,
> 	     gpointer         user_data)
> 	 {
> 	+  char newfn[PATH_MAX];
> 	   saveas_drawingarea = freqplots_drawingarea;
> 	   saveas_width  = freqplots_width;
> 	   saveas_height = freqplots_height;
> 	@@ -998,7 +1027,8 @@ on_freqplots_save_as_activate(
> 	   /* Open file chooser to save frequency plots */
> 	   SetFlag( IMAGE_SAVE );
> 	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> 	-      "*.png", NULL, _("untitled.png"), rc_config.working_dir );
> 	+      "*.png", NULL, get_nec_filename_stem(newfn, ".png", PATH_MAX),
> 	+      rc_config.working_dir );
> 	 }
> 
> This was the Coccinelle SmPL:
> 
> 	@ replace_untitled @
> 	identifier F != {on_nec2_save_as_clicked};
> 	parameter list PL;
> 	expression list EL1, EL2;
> 	expression EXT, arg, E =~ "untitled\.(.*)";
> 	@@
> 
> 	F(PL)
> 	{
> 	+	char newfn[PATH_MAX];
> 		...
> 		file_chooser = Open_Filechooser(GTK_FILE_CHOOSER_ACTION_SAVE, EXT, arg,
> 	-		_(E),
> 	+		get_nec_filename_stem(newfn, EXT, PATH_MAX),
> 			EL2);
> 		...
> 	}
> 
> but that just moved the existing "*.png" in the metavariable EXT into EXT
> within get_nec_filename_stem(), which wasn't quite enough, because
> get_nec_filename_stem() wants ".png" not "*.png": so I manually deleted
> the *'s.
> 
> It seems that I use Coccinelle daily: there is always something that is
> easier solved with SmPL than manual editing, even if there is some minor
> intervention after SmPL does the heavy lifting.
> 
> 
> --
> Eric Wheeler
> 
> 
> 
>>
>>
>>> so no need to rush about trying to implement this on my behalf
>>
>> Thanks for your nice feedback.
>>
>>
>>> unless it would benefit others.
>>
>> I guess that further demonstrations for the application of (advanced)
>> regular expressions in combination with the semantic patch language can help
>> to clarify corresponding use cases.
>>
>> Regards,
>> Markus
>>


-- 
Nicolas Palix
