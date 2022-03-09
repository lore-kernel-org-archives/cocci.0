Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAA3C433EF
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FnTobg3ShDygwh3xKthoWAIYQ5gU6/gq3IeENf6mEf0=;
  b=lsoQMBlz+ADLdnXybpy6d8MtOTe67wrrFMsOmapFDvGIKnCL74bKQ0st
   Ma/zxOyiENV9m+jrCkFihh8jTvJiKhQrvOk9K0ykrqGXEknMsTrKTuXZq
   /FCwKxfS24LVLPPT+Mm5VqyfPKMCt7aqHxYKfhlpv1ZKxVlz8xQ21UDbZ
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25326231"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 21:56:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D45FCE0362; Wed,  9 Mar 2022 21:56:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A712DE004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 21:56:45 +0100 (CET)
IronPort-SDR: ddxGht92P9VAoLyJiDtTMSsYs0vKOVFe3YjN1+bIWqXVdttOFCalSX8LkCOiWX0SGI81g1YW+A
 4p3fRqHVE2JuNAhVzhWtpOOTwT0ZJPQo75d3XIPPTdh5wL1TifONhZgGyKKZyy1rhid6nOW078
 UbnSLzvJxSKW3UjjcT8uv2rGPG6aisoo2s0OjZHDjGuazo3MfymJBcRITnVPuZQwcfQtQycW17
 z3HIyFC50Fmt7JUkmFA8xLTRuBwLMKoy0agJtXDsueMtC+3I0ZP6bjLu/quLKZl1gPgNtQx+Tj
 skjt64kp2SjXogBQTHYeYZ+X
X-IPAS-Result: =?us-ascii?q?A0BmBwA7FCli/0Xcza1aHgEBCxIMQIQCB4FNAQEBKQQLl?=
 =?us-ascii?q?AuBdy4DnlsLAQMBDUEEAQGFBwKEIgIdBgY0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSkBg2MBAQEBAgE6PwULC?=
 =?us-ascii?q?xguVwaDF4J2Ia1SeIEzgQGJe4E8jkgnHECBTYEVJ4EVgW4+ikQEl3oxEnoPJ?=
 =?us-ascii?q?Xg6kX6QEYEvnGODU5hvhmcGFC6EOoMSjnmLG4ZSllWhSA+FIoE/OSWBWR8UG?=
 =?us-ascii?q?ggmCjuCak0BAgECAQwBAgIBAgECAQIBCAEBAgGOKBaOTyABAQFpAgYLAQEDC?=
 =?us-ascii?q?ZESXQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NwfpEa83nSGNvacXmh1kDrUDsniTJUtcMsCJ2f8bNWPcYEJGY0x3n
 WROUW3XaPzeZ2H2e9AkPoq3oU1V6p7TmoNrTQA/rSFEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 ouj+5a31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z+
 NsKkoezVwsSBpLIpNk8XSFiOQRAFPgTkFPHCSDXXc27yl2AfmTszvhqAVtwO4AEkgp1KTgRr
 rpCcG1LNErbwbznqF64YrEEasALJ87gN4I3vnB70SqfAOkmTJ3HTr+M49JEtNs1rpAXRa6HO
 5txhTxHQ0z9fzBKEX0sVqk/n7y4mlv0bj92twfAzUYwyzOPklcgj+iF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoRKB+22lguvnjyL+UpgbUry+7P9jxlOJrlH/EzUTRR22vvm0h0qzQZRZJ
 lB8FjcSQbYaxELsacL+QRGDmEGAgiM9VeJqOcgEwVTYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mO0c8PV6S9H6+LKFCrMnluAhXbjZnhPdD5qiTosFFNdu7HeTJcPYgUjp+uP/Yawnpv4BjH9z
 jSHtm44iql7YS83O0eTpg+vb9GE/MShousJCuL/Bz7N0++BTNT5D7FEEHCChRuARa7AJrV7g
 FAKmtKF8McFBoyXmSqGTY0lRe/1uabYaWSF2AM/QfHNEghBHVb5Iui8Bxkley9U3jssI2K3C
 KMtkVw5CGBv0IuCNvMpONPuW6zGPIDtCtToW/TZdNtIad0pLWe6ENJGPiatMqGEuBZErJzTz
 r/AKJfyVylGUfo7pNd0Ls9EuYIWKukF7Tu7bfjGI96PiNJyvVaZFuUINkWgdOc84P/WqQnZ6
 Y8PZc+L0AlEFuDhYiTa9YMJa1YHMSFjV5zxrsVWcM+FIxZnQTt9UKWJnOp9IoE1zb5Ikuro/
 22mXhEKwlTIhUrYdVeAZEdlZe69Rp14t386YHIhZA76x3g5bI+zx64DbJ9rL6I//eluwKcsH
 fkIcsmNGNpVTTHD92hPZJXxttUyJhCqnh6VeSe6YDUye5N6AQrE5oa8LAfo8SAPCAuxtNc/+
 uf8jVmDHMNfHgk7VZTYcvOiyV+1rEMxouMqUhuaOMRXdWXt7JNudX77gMg3FN5Qex/N8T2Xi
 lSNChACqOiQ/YJsqIvVhbqJppuCGvdlGhYIBHHS6Lu7OHWI/menxoMcAu+EcSqECTHx6OOve
 uVYwvXxKrsBkUoT69hwFLNizKQf4drzpuYAkl8+RCiSMw2mWuF6P32L/chTrakTlLVXjguBR
 R7d8NdtP7jUatjuF0QcJVd7Y73bh+0UgDTb8d88PF7+uH1s5LOCXEgObQOAjjdRcOl8PI8/m
 Lpzvd5Q5hO/hxcuP8zAiC1IrjzeInsFWqQhl5cbHI6y0FZwkAkfOMCFB3+k+oyLZvVNLlIuf
 G2eip3CsKsAlEDMRHw+SCrW1u1HiJVT5h0TlA0eJ06Ek8buj+Ms2EED6iw+SwlYw32rCQ6o1
 rSH46G0GUmPw9usrM1TGW2zGwxMABCDvEr81zPlUYEfo1aADgTwwK8VYI5hP3z1N0pYfyNH5
 /eV12boXDLnZof30zdatYuJbRD8ZYQZy+AB8fxL2+yBHoImenzona+jaG4FsV3hDN9ZaIgrY
 wV11L4YVJAX/hL8b0H250d2GFjQpN25yLR+fMxc
IronPort-HdrOrdr: A9a23:ZL6gMKryNTvTNKe8Q1xHbXUaV5oveYIsimQD101hICG9E/bo7v
 xH/pwguiMc5wx+ZJhNo7G90ey7MBbhHP1OkO8s1NWZLW3bUQKTRekIgOffKn/bakrDH4VmpM
 VdmsZFaOEY0mIRse/x6mCDYrUd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="8100149"
X-MGA-submission: =?us-ascii?q?MDHjgyd7XcSJSHwU938odZCVsUl/QB59jZB7W8?=
 =?us-ascii?q?xbW3s1S02Qc9qptuzXMAlhfGwbKs0ANmW4vxvxTdBPw04V2a8oNDdE/7?=
 =?us-ascii?q?uE0nTizONHHU161a/eo6zQkyf3Tll/WRNmSUFLllTG/uQ7KDCguFPk34?=
 =?us-ascii?q?a+WMsLDwpfcBlb16siiwPZKA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 21:56:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 9283886;
	Wed,  9 Mar 2022 12:56:12 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gPVzfWwwKtIM; Wed,  9 Mar 2022 12:56:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id AA6DA85;
	Wed,  9 Mar 2022 12:56:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net AA6DA85
Date: Wed, 9 Mar 2022 12:56:09 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
Message-ID: <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 196
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/a32a6aea-bc17-2e56-947a-99325ab91265%40ewheeler.net>

> Regex groups are not supported.  You can use python to do whatever you
> want with the matched terms.  See demos/pythontococci.cocci

Thanks Julia.  It seems the Coccinelle =~ matches do not support escaping.  
I was getting errors trying to match like so:

expression E =~ "\.gplot";

It works without the \ but errors with the . 
	File "cocci/untitled-fix.cocci", line 5, column 35, charpos = 144
	  around = '\.',
	  whole content = expression EXT, arg, E =~ "untitled\.(.*)";

It failed scaping \" as well but now I'm unable to reproduce the problem.  
Sounds like python is the way to go, built-in regex's are useful and might 
need a bit of cleanup.

+1 for group and escaping support if it might be a trivial patch.


--
Eric Wheeler

On Wed, 9 Mar 2022, Julia Lawall wrote:


> 
> julia
> 
> On Tue, 8 Mar 2022, Eric Wheeler wrote:
> 
> > Hi all,
> >
> > I would like to replace this:
> >
> > 	void on_struct_save_as_gnuplot_activate(
> > 	    GtkMenuItem     *menuitem,
> > 	    gpointer         user_data)
> > 	{
> > 	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > 	      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
> > 	}
> >
> > And extract the extension ".gplot" as an identifier and pass it to the
> > function get_nec_filename_stem, like so:
> >
> > 	void on_struct_save_as_gnuplot_activate(
> > 	    GtkMenuItem     *menuitem,
> > 	    gpointer         user_data)
> > 	{
> > 	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > 	      "*.gplot", NULL, get_nec_filename_stem(newfn, ".gplot", PATH_MAX), rc_config.working_dir );
> > 	}
> >
> > The SmPL patch below works for what I want statically, but notice the
> > commented `expression E`:
> >
> > Is there a way to regex-group `expression E =~` with a parenthesis and then specify
> > something like E[0] to pick up the grouped regex match?
> >
> > 	@ replace_untitled @
> > 	identifier F;
> > 	parameter list PL;
> > 	expression list EL1, EL2;
> > 	//expression E =~ "\"untitled\.(.*)\"";
> > 	@@
> >
> > 	F(PL)
> > 	{
> > 	+   char newfn[PATH_MAX];
> > 	    ...
> > 	    file_chooser = Open_Filechooser(EL1,
> > 	-       "untitled.gplot",
> > 	+       get_nec_filename_stem(newfn, ".gplot", PATH_MAX),
> > 		EL2);
> > 	    ...
> > 	}
> >
> >
> > This doesn't work, but it explains what I'm trying to do:
> >
> > 	@ replace_untitled @
> > 	identifier F;
> > 	parameter list PL;
> > 	expression list EL1, EL2;
> > 	expression E =~ "untitled.(.*)";
> > 	@@
> >
> > 	F(PL)
> > 	{
> > 	+   char newfn[PATH_MAX];
> > 	    ...
> > 	    file_chooser = Open_Filechooser(EL1,
> > 	-       E,
> > 	+       get_nec_filename_stem(newfn, E[0], PATH_MAX),
> > 		EL2);
> > 	    ...
> > 	}
> >
> > It replaces as follows and does match "untitled.(.*)", but of course [0] is incorrect SmPL grammar:
> >
> > 	@@ -250,10 +253,13 @@ on_struct_save_as_gnuplot_activate(
> > 	     GtkMenuItem     *menuitem,
> > 	     gpointer         user_data)
> > 	 {
> > 	+  char newfn[PATH_MAX];
> > 	   /* Open file chooser to save structure image */
> > 	   SetFlag( STRUCT_GNUPLOT_SAVE );
> > 	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > 	-      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
> > 	+      "*.gplot", NULL,
> > 	+      get_nec_filename_stem(newfn, "untitled.gplot"[0], PATH_MAX),
> > 	+      rc_config.working_dir );
> > 	 }
> >
> > I tried something like this:
> > 	expression F =~ "\..*";
> > 	expression E =~ "untitled" ##F;
> > but that is invalid too.
> >
> > Ideas?
> >
> >
> > --
> > Eric Wheeler
> >
> 
