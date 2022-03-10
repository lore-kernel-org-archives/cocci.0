Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2497C433EF
	for <cocci@archiver.kernel.org>; Thu, 10 Mar 2022 22:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0yTqTG50qKNENHdy2s4ZuJWy5ldXnUrbz3r9J+fSJhY=;
  b=aGLsQ6ox4AcIBC/BebogsuZvC8H2cvTJjDDC7jEmPNIY6dFDKGNf9mY3
   WkLuef3NIA7AlMXK0RxZ3NphYzSfRaWqpsm9aM1tN5Q+X4WVTcSk8e2m2
   bOb6VfqjlkSx08jssnSeonr5gdixQz3rD2L4W5LWJhdRPnpe6FEjMhW+9
   U=;
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
X-IronPort-AV: E=Sophos;i="5.90,171,1643670000"; 
   d="scan'208";a="25544962"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2022 23:03:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6226E2FBA; Thu, 10 Mar 2022 23:03:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D529EE2FB8
	for <cocci@sympa.inria.fr>; Thu, 10 Mar 2022 23:03:34 +0100 (CET)
IronPort-SDR: 3AN5EshJViyPXY2+PJnIwklbPuPIb4ICNEiRxaMWYkcEkrm9gw8L180P6oN0kiu5l9J9finmzJ
 XzG97cwDur2rzwxMsbjAPf5K800bgBXqbLa10WzVpPjIIumS9n5gn/CyzPBdBEmQH31Oi4svwQ
 OdhKS8ukVIoFrh59HZTKp4thIYLyPN6I/5vzq9yzlIYsycGa5ERzACYpMyX6OM8O9OfQjyvM4P
 pP+YsQ51ZU+4FoI7lEN6lGS/0Rr2pL5vPGPzKoaGJNUgy75qwaUV2NdU9v1V76pZdZqTJg0k5u
 52obPMq8lcRiKJnEKSO2M6HT
X-IPAS-Result: =?us-ascii?q?A0BKBQBYdSpi/0Xcza1agQmEAgeBTQEBASkEC5QLgiieW?=
 =?us-ascii?q?wsBAwENQQQBAYUHAoQjAh0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECAwQBgQgsAWMBZwGBTgGBeQYEAwY0gjUpAYNkAQU6PxALGC5XBi6CaYMXr?=
 =?us-ascii?q?2OBM4EBiXuBPI5IJxxAgU2BFScMgQmBbj6KRASXDXgcgSFsQJJCkAeeE4NTn?=
 =?us-ascii?q?1YaLodMjnmLG4ZSllWmeYE/OSWBWR8UGggmCjuCak0BAgECAQwBAgIBAgECA?=
 =?us-ascii?q?QIBCAEBAgGMCpEDIAEBAWkCBgsBAQMJjycsgT9dAQE?=
IronPort-PHdr: A9a23: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
 zuHQReLAw==
IronPort-Data: A9a23:eQIPqawZKcBjKKdvayx6t+cPwCrEfRIJ4+MujC+fZmUNrF6WrkUGm
 GEXWjvUOqzbN2XyfNB/aY/g9EoO7Z6AnNU1TgZsq1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 Iuq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPg26
 vVtvpWcCjsXP4+TpcdNXxVoST1HaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY1poUQ6uCP
 qL1bxJJQzifOzFqBmsOJ8wGxL+yxVT4IyFh/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb34T6M7XuogsfdnCbxQotUFbui9/csjkf7+4AIIBgGE1akofS0jkOkHdRSN
 yT45xbCs4B11myLRdDRHCGGoVzbgz1MV9ZgSfEDvVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlj+8FFhQ07+LIESP1GqO86GLtaXJMfAfucAddFVNdi+QPtr3fmf4mczqOOKulyNDqGTz9x
 z2Q6i4zm93/bPLnNY3gozgrYBr2+vAlqzLZAC2ODwpJCSsgOOaYi3SAswSz0Bq5BN/xo5nol
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cbmGC0AUwQsJxrGT0k5JGQWy2yGsgTKuOGp1bEQIFn
 WeJ5F05CGF7YxNGkpObk6rqV5pxnPewfTgUfv3LbtdDZpVrdQmMuXk3DXN8LEi2+HXBUMgXZ
 /+mTCpbJS1DWPo9k2buGbt1PH1C7nlW+F4/jKvTl3yPuYdyrlbPIVvcGFfRPO0/8o2epwDZr
 4RWO8eQkkUNVOzlfjKR/JETIF0OIGJ9A53q8pQFeumGKwtgOWcgF/6Im+96IdQ4xvgMm7ea5
 Gy5V29Z1EH72y/NJzKKXW8/OrnhapBy8CAgNis2MFf1hXV6OdSz7L0SfoccdKU88LAx1uZ9S
 vQIIp3SAvlGRjnd1S4aaJ3x8N5reBix3FLcOyu+fCN5coFgSgHN98WieAbzrXFcAi2yvMo4g
 ruhygKCG8ZYHVw/VZqPZav2nV2rvHUblOZjZGfyI4FeKBf27YxnCy3tlftpccsCHhX02WfI3
 QihBxpF9/LGpJU48YSXiPnc/ZupCeZ3AmFTA3LfseStLSDf82eund1AXeKPcWyPXW/44vz/N
 +BFifzjMPAKmFtQ9YxxD+8zn6454tLuoZ5czxhlRS+XNA7zV+o8e3TWj9NSsqBtx6NCvVXkU
 Ey4+u5FZeeDNvTjHQNDPwEidOmCiK8Zw2GA8fQvLUzmzyZr577bA15KNhyBhXAPNrdzK495k
 +4ttNRPtl66mlwnLdaLgyRZ7SKKI2BZC/crsZQTAYnKjAs3ywgYPceGUnKvvMiCO4dWL00nA
 j6In66c1b5S8Ur1bCZhH3b62+cA148FvwpHzQJcKg3RyMbFnPI+wDZY7S8zElZO1hxC3u9+U
 oSx25aZ+UlaE/ZUaMl/s6SEHhEHCQKZ90H1xkFPkmDFJ6VtuqohM0VlUdthPmhAm46fQtSf1
 LWZ03r+Fzv1fMz82iYoH0hot5QPiDC3GhLqwKia8gfsI3X+ST7kmbO1I2cXqxbqBc4rwkvKu
 YGGOQq2hbLTbUYtnkHwN2VWOXn8hvxJyKyujMyNJJ80IFw=
IronPort-HdrOrdr: A9a23:OljbUqHhDlJvpAgBpLqE7MeALOsnbusQ8zAXPiFKOGVomq7xra
 +TdZsguyMc5AxxZJhko6HkBEDiewK7yXcW2/h0AV7KZmCP0wbFEGgh1/qE/9SKIVydygcy78
 ddmndFYuHYB1ISt7eY3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,171,1643670000"; 
   d="scan'208";a="8226541"
X-MGA-submission: =?us-ascii?q?MDE3Fug+UrRds5ZU1q9w2tH0c+pVBePg0e5FhH?=
 =?us-ascii?q?KfZxsZtdumY9NFuVKpbY7020EKrpiUhiMbNMeMiCxChNvjFqmijQ3Qrj?=
 =?us-ascii?q?Xo3xELkUq1+knlZ9XmimFxz8sWwzigc8IUSu+Mdp4E9fvOLN62bxK/eq?=
 =?us-ascii?q?n9w6mkILNLo6qao930+ZGynQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:03:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3045F45;
	Thu, 10 Mar 2022 14:03:30 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vxd1nNm9fjnq; Thu, 10 Mar 2022 14:03:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 44B2539;
	Thu, 10 Mar 2022 14:03:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 44B2539
Date: Thu, 10 Mar 2022 14:03:27 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20>
Message-ID: <e683d80-5764-7550-d729-273e61b607c@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien> <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net> <alpine.DEB.2.22.394.2203092218430.35182@hadrien> <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
 <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 203
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/e683d80-5764-7550-d729-273e61b607c%40ewheeler.net>

On Thu, 10 Mar 2022, Markus Elfring wrote:
> > Anyway, my needs for this are already met with a combination of SmPL
> > cleverness and a bit of manual intervention,
> 
> Would you like to share a bit more information about a (temporary) solution
> which you find good enough at the moment?

This was the resulting diff from git after doing the complete refactor to 
remove "untitled" from default filenames:

	@@ -991,6 +1019,7 @@ on_freqplots_save_as_activate(
	     GtkMenuItem     *menuitem,
	     gpointer         user_data)
	 {
	+  char newfn[PATH_MAX];
	   saveas_drawingarea = freqplots_drawingarea;
	   saveas_width  = freqplots_width;
	   saveas_height = freqplots_height;
	@@ -998,7 +1027,8 @@ on_freqplots_save_as_activate(
	   /* Open file chooser to save frequency plots */
	   SetFlag( IMAGE_SAVE );
	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
	-      "*.png", NULL, _("untitled.png"), rc_config.working_dir );
	+      "*.png", NULL, get_nec_filename_stem(newfn, ".png", PATH_MAX),
	+      rc_config.working_dir );
	 }

This was the Coccinelle SmPL:

	@ replace_untitled @
	identifier F != {on_nec2_save_as_clicked};
	parameter list PL;
	expression list EL1, EL2;
	expression EXT, arg, E =~ "untitled\.(.*)";
	@@

	F(PL)
	{
	+	char newfn[PATH_MAX];
		...
		file_chooser = Open_Filechooser(GTK_FILE_CHOOSER_ACTION_SAVE, EXT, arg,
	-		_(E),
	+		get_nec_filename_stem(newfn, EXT, PATH_MAX),
			EL2);
		...
	}

but that just moved the existing "*.png" in the metavariable EXT into EXT 
within get_nec_filename_stem(), which wasn't quite enough, because 
get_nec_filename_stem() wants ".png" not "*.png": so I manually deleted 
the *'s.

It seems that I use Coccinelle daily: there is always something that is 
easier solved with SmPL than manual editing, even if there is some minor 
intervention after SmPL does the heavy lifting.


--
Eric Wheeler



> 
> 
> > so no need to rush about trying to implement this on my behalf
> 
> Thanks for your nice feedback.
> 
> 
> > unless it would benefit others.
> 
> I guess that further demonstrations for the application of (advanced)
> regular expressions in combination with the semantic patch language can help
> to clarify corresponding use cases.
> 
> Regards,
> Markus
> 
