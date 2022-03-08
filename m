Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4460AC433EF
	for <cocci@archiver.kernel.org>; Tue,  8 Mar 2022 01:19:00 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24885834"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2022 02:18:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 763C3E0362; Tue,  8 Mar 2022 02:18:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9711EE004D
	for <cocci@sympa.inria.fr>; Tue,  8 Mar 2022 02:18:54 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: sz2qieDWQJ40PveMoblsZhTIm6h99Cm6HaZOz+7jPWq2kDWdlV7Bu77EdowSyNZ+6cbctrPhqO
 eZBHMqg5Zn8BQvohspEQSsRNy6bwCpOu3Zzaim2uPEpVlbAs4R/bObjB0CfidUKui7lVDuaZYm
 BDUDsnAdpIvMX/ZAVvqiVhMwzx++FdukU5Srra5Mv2EGwVy0+RXFDj9/3r6TVdruzm1UKNINkh
 30z8wywrdu7I5UddP5PJLWAlFbEMIwls7shA7xxsraIXMbPVntfDYrShLpGwgkCN67kN2QsZYR
 897LwiRA9frnhI067HRY/hSZ
X-IPAS-Result: =?us-ascii?q?A0A0BQCKriZi/0Xcza1agQmEAgeBTQEBASkEC5QLgiieW?=
 =?us-ascii?q?wsBAwENQQQBAYUHAoQfAh0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECAwQBgQgsAWMBZwGBTgGBeQYEPYI1KQGDZAEEATo/BQsLRlcGgxeCdiGtf?=
 =?us-ascii?q?oEzgQGJe4E8jkgnHECBTYQPMD6KRASWVoEDlHmQLp4Sg1OfVhoug2GSY5Fml?=
 =?us-ascii?q?lWmeYE/OSWBWR8UGggmCjuCak0BAgECAQwBAgIBAgECAQIBCAEBAgGOU446I?=
 =?us-ascii?q?AEBAWkCBgsBAQMJkW8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6kFZIq4o9XwtztfT7fYR2AxRtAPBchMFZxGqfqrLsTDasY5as4F+v
 mpJWT2EbK6IYzOmLtt+PYTnp09TvZ/XyNcwGQBt/yo9Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yiq/JWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 O90hI6XezgYB5Hju8g0DEVZMCpwALITrdcrIVDn2SCS50jWNXbzw/hjCEwse4sV5o6bA0kXq
 qdecmhQKErZ36TokdpXScE07ignBMLsN4geknVh1i3CS/s5QZ3OR6jQo9lVwF/cg+gUQaaOO
 ppCMlKDajzDW0JRG0VLCKlkmd+JllD8VGRRsXe88P9fD2/7l1Avi+myYLI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDt2nalmebLmQvpWYcYDrT+9/hwgVTVyHZ7NfENfV6r5/SmikOzX99Fb
 UoZ5kLCsJTe6mSRd+jveC+HkUe4kT0wcoUMEs4x5jySn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLho+4FFQCDo5XOFi3Arub8QSeafHlKfTVbNEfoWCNcu4G7yLzfmC4jWTqKLUJYptjlXzzvw
 z2HqCUkwbMekabnNplXH3ic3FpARbCTEmbZAzk7uEr/tWuVg6b8POSVBaDzt6ooEWpgZgDpU
 bhts5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3wIxQcZxr2r0oyf6FWy13N2YDBwxWirjUWS2C
 HI/RCsLucE70IWCMsebnL5d++xxkfa7RIu1PhwlRtdRYpV8cAKd/SdlIBbJt10BY2B3+ZzS+
 P6zL66RMJrtIf8/nWruGrxEiudDK+JX7Tq7eK0XBi+PidK2DEN5g59cWLdXRuxmvq6CvivP9
 NNTa5mDxxlFCb2sZijM7ZVVIE8KIHU/CIqwrcFLL7bRLg1jEWAnKvnQ3bJ4IdA+xfwIz7uR8
 yHvQFJcxXr+mWbDd1eAZEdjX6yzD5xxmnQ2YH43NlGy1nl+P4v2tPUDd4E6dKUM/fB4yaImV
 OEMfsiNW6wdSjnO9zkHQ4P6qYhuKEaiiQ6UZnr3ZDkkY4UmShPJ99LgcxGp8iQSV3Llucw7q
 rym9wXaXZtaHVg5Vp6LMa72wgro73YHme90U0/ZGfVpeR3hoNpwNij8rv4rOMVSex/N8Tuty
 FrECxkvo+SQ8ZQ+98PEhP3aot7xQfd+BEdTA0LS8a2yaXvB5mOmzIJNDLSIcDTaWD+m8amuf
 7wInfTsdvAYnFtHt4dmVbBm0ftmtdfoorZbyCViHWnKNg73Uek4fyDahMQf5LdQwrJ5uBetX
 hzd8NdtOYKWZJHvHmkXKVd3de+Ez/wVx2fftKxnPEXg6SZr17ObSkEObQKUgSlQIecnKo8j2
 ut96sca5xbm10gvIpCLkSBZ+mCBNDoGXrl+7sMWB4riiwwKzFBeYMWGVnSsuMzWN4xBYhswP
 zuZpKvenLAClEDMRHoECiSf1+Rqg5lT6gtBy0UPJgnXl4Od1OM3xhBY7R8+Uh9Rkkdcy+t2N
 2VmX6GvyX5iI9u8aAl/s2GQ98VpAQ3f91PxxlYNmXefSUS0PoAIwKvRJs7VlH31MUoFFtSYw
 F1c4GLkSirxOszu3iY/XUN/7fruUbSdM+EEdN+PR6y48lpTXdYhqquvfnYT7Rb4Ac48gEDd4
 +9n4I6crEE92TE4+8UGNmVR6VjcpN1o6oCPrTGNMZ7lxV3hRQw=
IronPort-HdrOrdr: A9a23:uM2ZG6FsKdfTsK3UpLqE7MeALOsnbusQ8zAXPiFKOGVomq7xra
 +TdZsguyMc5AxxZJhko6HkBEDiewK7yXcW2/h0AV7KZmCP0wbFEGgh1/qE/9SKIVydygcy78
 ddmndFYuHYB1ISt7eY3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24885833"
X-MGA-submission: =?us-ascii?q?MDH/E+mUfRkeOYk58zWV0DmEVolC0a7Frdjhkj?=
 =?us-ascii?q?IdRh9EGTaH6Pu1H1rrWfvtUUekq9izggsmDbzLBXmYzvVBAK+95jzbdZ?=
 =?us-ascii?q?J8c6J2xke7SNvLCq1a9/7jniUcZpIkw8RiL7UHfW7U71MArP90/8nDoV?=
 =?us-ascii?q?5qaHt62VqkiQ7jfkvdor7h0A=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:18:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 9C4B081;
	Mon,  7 Mar 2022 17:18:51 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pZdFH-CglMKQ; Mon,  7 Mar 2022 17:18:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id D167540;
	Mon,  7 Mar 2022 17:18:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net D167540
Date: Mon, 7 Mar 2022 17:18:49 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <73ca810a-98bc-25db-5202-2ae7305b83fc@web.de>
Message-ID: <923a1086-8eae-46d-54fa-27b8fff1e@ewheeler.net>
References: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net> <alpine.DEB.2.22.394.2203072147580.3091@hadrien> <73ca810a-98bc-25db-5202-2ae7305b83fc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL for functions with prototype disjunctions
 need to be complete?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 186
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/923a1086-8eae-46d-54fa-27b8fff1e%40ewheeler.net>

On Mon, 7 Mar 2022, Markus Elfring wrote:

> 
> >> It means there must be a longer SmPL, which is ok, but for my own
> >> curiosity: is there a shorter form?

> > It might be possible to put a disjunction around only the parameter list,
> > ie inside the parentheses.

Thanks Julia, that is a great hint!

> How useful would such an SmPL code variant be here actually?

It just makes it more readable.  I always try to avoid duplicate code no 
matter what language I'm writing for.

--
Eric Wheeler


> 
> Regards,
> Markus
> 
> 
> 
