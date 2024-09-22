Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0FECF9C64
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SGM/ioPylYi0LqrF70PDKcXnI4MvmOgZQjfzvDi9Fjg=;
  b=B2zfWrPoeT0u80e0oHwdGHHjC4e6F5cVWGb71469eGP1YZIFFLu/sJXv
   Zc8EO7ORVqZAILJajZoPYwqdM5m+OoWz4ZHyD8JwBbIP4WBlVHBI8sMjs
   /Z9LDT3xPM7Bw0ysQriEVh27v+YdP/tt46vPhuW9O/8u1ZEA3m2aW5rbu
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184427991"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 17:15:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1DF4E0D1F; Sun, 22 Sep 2024 17:15:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 88D6FE00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 17:15:32 +0200 (CEST)
IronPort-SDR: 66f03494_fliwTc4ePLyFdpJ4Spth2ge3xao7liT+BGeAI4fQyxavXBY
 iZQvwjF2Ct6TtTNfT3mdWk1AlBdkyUReGLhSO+Q==
X-IPAS-Result: =?us-ascii?q?A0FFAQDIM/Bm/wwR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YJDB3xUMwQLSIRWj02BdTCEO4c6h1SIdoFWgUA+DwEDAQ1BAQIEAQEDBIR2C?=
 =?us-ascii?q?gKKAwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEKC?=
 =?us-ascii?q?AuFL0YNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAiYCAlYGARQBAYJ9gjABAw4jB7Q4gTKBAYIMAQEG2lofLCJXgWMJg?=
 =?us-ascii?q?RouAYhKAYYihDsnD4FVRIE8gksHMT6EQ4NbgmmHb4cRgw2CEAomiS4liGJwk?=
 =?us-ascii?q?GZSexwDWSETAVUTFwsJBYk4CoMcgW4mhBUIgSsTg1+BZwlhh2digQ2BPoFZA?=
 =?us-ascii?q?UaCc0qDUByBXQU4SYJRa048Ag0CN4IqJGqCWoEvBAWDah1AAgELbT01CQsbB?=
 =?us-ascii?q?j2uAoFZZoECEwGCaMRngQo0B4I3gWOBYwyfUgYTL5c+DgaSc5h2Iqh7gW4JL?=
 =?us-ascii?q?YFZMxokT4JnUgsOD44hhC3Gb0E1OwIHAQoBAQMJhUYBAYY+gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:N3Qj6K6MiztAQ3cQ+trmpgxRtBfGchMFZxGqfqrLsTDasY5as4F+v
 mcXXWqGP/qPNzCmc951aovj809X6J+HzdNlQQE+/H9gZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtagr414rZ8Ekz5KWo4mtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj69w/VVBrNKA2wcVcBVt00
 P4FARshcx/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIAehW1YasNmRZ4yY
 +I8YCBscQ+GThlBIFYRB7ohke3uinSXnzhw8QLJ+fBosjWCpOB3+IHhPeDZccWgfMR6mGWa9
 mv+oGfUOChPYbRzzhLAqBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+fV+yvvC9jmasWtdVM
 UVS+yw0rKF0+lbDczXmdxi/vWLCoRMWHdZdewEn1DywJmPvy17xLgA5ovRpMbTKGedvLdD2/
 jdlXu8FBACDdJWQTm+BsKiZp3W+NED56IPEiTAsFWM4DxvL+enfTS4jiv58HaTzgtCd9fTY3
 WWRtCZn71kMpZdj6kh4lGwrRxqzq5KPQgNdCsA7mI66xlsRWbNJrLBEJbQWATis4WpZopS8U
 KA4pvWj
IronPort-HdrOrdr: A9a23:mgG+yq48vxDdGGvEDQPXwBLXdLJyesId70hD6qm+c20sTiX4rb
 HUoB1/73XJYVkqKRUdcLy7Scy9qDbnhPxICOoqXYtKPjOW31dARbsKheDfKn/bak7DH4VmpM
 FdmsZFeaTNJGk/osDg/gGiHtoshPWB+ru5nPrTwh5WIT2CqJsO0+66MGum+4FNKjWuzKBZKK
 ah
X-Talos-CUID: 9a23:FORzaG67XlSpWpsxZ9ss3R9NC50sX1Pm71zUGXWdC3tAY5GIRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AAZg+KQ7b/I6LkwadWrN70dZjxoxR76mUBEsUu6w?=
 =?us-ascii?q?HlM+nN3x5A2ieoQ6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184427959"
X-MGA-submission: =?us-ascii?q?MDG4TNfoJ5MBHWMhjkaFkYfWtdpREHwiVETHGs?=
 =?us-ascii?q?kWKsOxrnupOhV7El0Tt04xBnA9hLzO5LLgnot66AEVl/UPWL+JFKGwdu?=
 =?us-ascii?q?6+KMgKgkU1by4I9ITsnNWSifSVH+1ZD22zJt1cv/tUdiyChWQ5HNGexX?=
 =?us-ascii?q?7je7L6/KP6DPJCBvj4u154bg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 17:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727018121; x=1727622921; i=markus.elfring@web.de;
	bh=SGM/ioPylYi0LqrF70PDKcXnI4MvmOgZQjfzvDi9Fjg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iTiqWH85ubrIDP2bcypBQkA/Upozq6oFUilPoManhsTP/Kgx/GLBjj/GOhDEAbHb
	 Qm4Xdv1gDkKio5/sdenS7x96c6atWqv97XWOJhWK4FNESVKOlbhCwounE/khp8flb
	 ajAffyJ01/+ap4SZKvFtjLv2giCompc6ePS/igOM42oD7UIOWhr3jIO0HpgUqwHkc
	 EPQ8/9urudLzMLzwgCASEkyiT5W7VxadcVw00okHrsgJmfHML/9sZEBbQmcxBvxX2
	 3uRPPUSYECajH8MIpLrDZ9KMqhslgbAF5HKINQVXA4o3l2HjXz/0af7GH8a6VAy7x
	 ip73/ijYgxGR7zaGsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kEV-1soFZo0pHd-006Vul; Sun, 22
 Sep 2024 17:15:21 +0200
Message-ID: <510f9dab-7c57-4b9b-bbc2-736cfa622612@web.de>
Date: Sun, 22 Sep 2024 17:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
 <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
 <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
 <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
 <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
 <alpine.DEB.2.22.394.2409221400080.3517@hadrien>
 <42f5079e-472b-42ed-9429-2c636b9a14a3@web.de>
 <alpine.DEB.2.22.394.2409221525030.3517@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409221525030.3517@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/z67bocxULxzaylNrjF3sY+9sh6pmC6o2yEIKAAdH/7TTOhvowT
 N5/x2jWFnU/JpYUF/uBeA9isoaWjZ3ZfpTivtKOV4HW5LBZRHcP06Ea4DU/4VHy5/VteEaZ
 4vT7EAQTNuX+L/RWCLmhxis7OarH8Ly4QKm/lMwepQAaCl2CMnZrCdoOFLge2oU6g/FdtiL
 mgKU7o52kfIN2j1ilfDlA==
UI-OutboundReport: notjunk:1;M01:P0:/y6PTQKvgws=;mnFTTC5sPoEvi5IWYtIn59EGxiV
 w30sR4O3+qGwyKE+NHGWTPGyXxLfGaQ12xXkxadJTwyNPZlUDBQnAGPRkKJVhMzW50FUidwkx
 Ti0+A+2maJd+XiAhFZLuqhXwtipOgzJkcJ+m1ASGfL6DmemzTNc/+UuPxHnKI+tRJgonfmMfy
 q05VZPSOPN8Z17opF/+UMeSubOATrN4ZTF8QXldawtABfyRjCPubnKzOopnbQFmWTANYUbHuy
 KTVhnF3NBcNNHtLleKfb6sbVoPbQDNQxzaqcXWIOdgBUORMKrtdbo5nznfej1v+Pxu7qwvCvK
 I7yvfPYWMFixC8AvZx7oDMkoTfJ3wshF8vw18fDmnEa7NUVoAur1fykM2dEc8Sx6czEmzPkXA
 wt++umqB2f/z7JpvgmpsKlh72JndzLXoT+SFC1nltecTBdVZhJ+B+PvBGnFiOZRjscBOFk7XO
 X24IA71Gguhs0pf6NbDo7M/J0Xlmi2sClONfKeLAB1NJ9NL3S3cTM8XPgIXD2bGwjWppsWy+m
 X0DpVErir7XYXpt0lZOPrTF7WLBr8R11r0EB/2fZe+K34JpaH99FyLxbi3BRUvYexvNRg/2Od
 ILLDfDEbxT3gYxZRs/c8azDWq7YmoSYK2+fsc1g2OYayhcINNqvaSESQ7l+iJIAVJ/9o5pauI
 RP3NQodswYO+eKF9CJzs10YriduXyE+1PlPudgwjE2vLP2rKPNS7FYltQ1dt6NYMDGuTQAZ8K
 Sfm/2P90iLVZ0pl8kCmipSGFlJUEirgyih7xwbRY1IDAc4OsIN/MLFe3Mcz2L2zM1FdWm4hUa
 Fyv/6k4XBqZwU+REiexQMeqA==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1884
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/510f9dab-7c57-4b9b-bbc2-736cfa622612%40web.de>

>> Questionable test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --pa=
rse-cocci use_common_kfree_code7.cocci
>> =E2=80=A6
>> minus: parse error:
>>   File "use_common_kfree_code7.cocci", line 11, column 18, charpos =3D =
282
>>   around =3D 'when',
>>   whole content =3D ?ath12k_warn( ... when !=3D \( x =3D e1 \| e2(..., =
&x, ...) \) );
>>
>>
>> I would appreciate your advice for this use case.
>
> I don't understand what you are trying to do.

I guess that a better understanding will evolve probably if I (or an other=
 contributor)
would publish 88 patch hunks for 6 source files in the directory =E2=80=9C=
drivers/net/wireless/ath=E2=80=9D.


>                                                It is not common to find =
an
> assignment, for example, in an argument list.  In any case, I guess that
> when is not supported on argument lists.

I hope that the support can be completed for when clauses on SmPL ellipses=
 somehow.

Regards,
Markus
